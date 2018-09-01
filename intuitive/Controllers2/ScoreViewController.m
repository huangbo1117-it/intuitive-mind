//
//  ScoreViewController.m
//  intuitive
//
//  Created by BoHuang on 8/12/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "ScoreViewController.h"
#import "CGlobal.h"
#import "NetworkParser.h"

@interface ScoreViewController ()
@property (nonatomic,assign) int chart_moving;
@property (nonatomic,assign) int chart_param1;
@property (nonatomic,strong) NSTimer* timer;

@end

@implementation ScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imgArrow.image = [CGlobal getColoredImageFromImage:self.imgArrow.image Color:COLOR_PRIMARY];
    CGRect scRect = [UIScreen mainScreen].bounds;
    CGFloat width = 300;
    self.chartView = [[BarChartView alloc] init];
    [self.viewContent addSubview:self.chartView];
    
    self.chartView.frame = CGRectMake((scRect.size.width-width)/2, 0, width, 200);
    
    self.imgAxis1.image = nil;
    self.imgAxis2.image = [CGlobal getColoredImageFromImage:self.imgAxis2.image Color:[UIColor whiteColor]];
//    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] init];
//    gesture.delegate = self;
//    [self.chartView addGestureRecognizer:gesture];
    
    _chart_moving = 0;
    _chart_param1 = 0;
    [self loadData];
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan");
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesCancelled");
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesEnded");
}
-(void)loadData{
    EnvVar*env = [CGlobal sharedId].env;
    NSString*userid = [NSString stringWithFormat:@"%ld", env.lastLogin];
    
    NetworkParser* manager = [NetworkParser sharedManager];
    NSString*path = [COMMON_PATH1 stringByAppendingString:ACTION_GRAPH];
    NSMutableDictionary* param = [[NSMutableDictionary alloc] init];
    param[@"action"] = @"fetchall";
    param[@"tu_id"] = userid;
    
    [CGlobal showIndicator:self];
    if (self.resp != nil) {
        [CGlobal drawGraph:self.chartView Result:self.resp.tblGraph_list];
        
        [CGlobal stopIndicator:self];
        
        [self.chartView setDelegate:self];
        
        [self checkVisibleBars];
    }else{
        [manager ontemplateGeneralRequest:param Path:path withCompletionBlock:^(NSDictionary *dict, NSError *error) {
            LoginResponse *resp = [[LoginResponse alloc] initWithDictionary:dict];
            [CGlobal drawGraph:self.chartView Result:resp.tblGraph_list];
            
            [CGlobal stopIndicator:self];
            
            [self.chartView setDelegate:self];
            
            [self checkVisibleBars];
        } method:@"post"];
    }
    
    
    NSTimer*timer = [NSTimer scheduledTimerWithTimeInterval:0.5 repeats:true block:^(NSTimer * _Nonnull timer) {
        if(self.chart_moving == 1){
            if (self.chart_param1 == 1) {
                [self checkVisibleBars];
                self.chart_param1 = 0;
                self.chart_moving = 0;
            }else{
                self.chart_param1 = 1;
            }
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickCal:(id)sender {
    [self checkVisibleBars];
}

-(void)checkVisibleBars{

    BarChartDataSet* set1 = self.chartView.data.dataSets.firstObject;
    int foundIndex = -1;
    for (int i=0; i<set1.values.count; i++) {
        ChartDataEntry* entry =  set1.values[i];
        
        CGPoint point = CGPointMake(entry.x, entry.y);
        CGPoint pt = [self.chartView pixelForValuesWithX:point.x y:point.y axis:AxisDependencyLeft];
        if ([self.chartView.viewPortHandler isInBoundsX:pt.x]) {
            NSLog(@"contains %f %f index = %d",point.x,point.y,i);
            foundIndex = i;
            break;
        }else{
            NSLog(@"Not Contains");
        }
    }
    
    if (foundIndex>=0) {
        foundIndex = foundIndex + g_length;
        if (foundIndex<set1.values.count) {
            ChartDataEntry* entry =  set1.values[foundIndex];
            if ([entry.data isKindOfClass:[TblGraph class]]) {
                TblGraph* tblGraph = entry.data;
                NSDate* date = [CGlobal getDateFromDbString:tblGraph.create_datetime Gmt:true];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.lblDate.text = [CGlobal getCreationTime:date GMT:false MODE:2];
                    self.lblTime.text = [CGlobal getCreationTime:date GMT:false MODE:3];
                    NSString* str= [NSString stringWithFormat:@"%.2f",[tblGraph.tg_score doubleValue]];
                    self.lblScore.text = str;
                });
                
            }
        }
    }
}
-(void)chartTranslated:(ChartViewBase *)chartView dX:(CGFloat)dX dY:(CGFloat)dY{
    
//    if([chartView.viewPortHandler isInBoundsLeft:8]){
//        NSLog(@"true");
//    }else{
//        NSLog(@"false");
//    }
//    NSLog(@"offsetLeft %f", chartView.viewPortHandler.offsetLeft);
//    NSLog(@"contentLeft %f", chartView.viewPortHandler.contentLeft);
    
//    NSLog(@"%f %f",dX,dY);
    _chart_moving = 1;
}
-(void)chartValueSelected:(ChartViewBase *)chartView entry:(ChartDataEntry *)entry highlight:(ChartHighlight *)highlight{
    NSLog(@"sss");
}

@end
