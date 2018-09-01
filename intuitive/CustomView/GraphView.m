//
//  GraphView.m
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "GraphView.h"
#import "CGlobal.h"

@implementation GraphView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"TopBarView initWithFrame");
        [self customInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"TopBarView initWithCoder");
        [self customInit];
    }
    return self;
}
-(void)customInit{
    self.mChart.backgroundColor = [UIColor clearColor];
}
-(void)addViews{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 200, 80)];
    //set background color to see if the frame is rotated
    [label setText:@"GALVANIC VALUE"];
    label.transform=CGAffineTransformMakeRotation( ( -90 * M_PI ) / 180 );
    [label setTextColor:[CGlobal colorWithHexString:@"EBEBF1" Alpha:1.0]];
//    [label setFont:[UIFont systemFontOfSize:13.0f]];
    UIFont* font = [UIFont fontWithName:@"GoodTimesRg-Regular" size:13.0f];
    label.font = font;
    
    [_viewLeft addSubview:label];
    [label sizeToFit];
    CGPoint pt = CGPointZero;
    pt.x = _viewLeft.center.x - label.frame.size.width/4;
    pt.y = _viewLeft.center.y;
    label.center = pt;
}
-(void)customLayout{
    [self addViews];
    
    [self.btnShare addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    self.btnShare.tag = 200;
    
    self.imgShare.image = [CGlobal getColoredImageFromImage:self.imgShare.image Color:[UIColor whiteColor]];
    
    self.backgroundColor = COLOR_RESERVED;
}
-(void)clickView:(UIView*)sender{
    int tag = (int)sender.tag;
    switch (tag) {
        case 200:
        {
            // share process
            if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
                UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [UIScreen mainScreen].scale);
            } else {
                UIGraphicsBeginImageContext(self.frame.size);
            }
            [self.layer renderInContext:UIGraphicsGetCurrentContext()];
            //[self.window.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            NSData *imageData = UIImagePNGRepresentation(image);
            if (imageData) {
//                [imageData writeToFile:@"screenshot.png" atomically:YES];
                [CGlobal shareText:@"Intuition Graph" andImage:image andUrl:nil withView:sender withController:self.vc];
            } else {
                NSLog(@"error while taking screenshot");
            }
            
            break;
        }
        default:
            break;
    }
}
-(void)setTblGraph:(TblGraph *)tblGraph{
    _tblGraph = tblGraph;
    if (tblGraph!=nil) {
        NSMutableDictionary* data = [CGlobal readFromTblGraph:tblGraph];
        [self initGraph:data];
    }
    
}
-(void)setFilename:(NSString *)filename{
    if (filename == nil) {
        self.viewAxis_X.hidden = true;
        return;
    }
    self.viewAxis_X.hidden = false;
//    _filename = filename;
    NSMutableDictionary* data = [CGlobal readExcelFile:filename];
    
    [self initGraph:data];
}
-(void)initGraph:(NSMutableDictionary*)data{
    QuizResult* data_f = data[@"incorrect"];
    QuizResult* data_t = data[@"correct"];
    if (data[@"dics"]!=nil) {
        QuizResult* data_d = data[@"dics"];
        [CGlobal drawGraph:self.mChart DataTrue:data_t DataFalse:data_f DataDecision:data_d];
        self.stackDecision.hidden = false;
    }else{
        [CGlobal drawGraph:self.mChart DataTrue:data_t DataFalse:data_f DataDecision:nil];
        self.stackDecision.hidden = true;
    }
    
    NSDate* date = data[@"date"];
    self.lblTime.text = [CGlobal getCreationTime:date GMT:false MODE:4];
    float cnt_f = data_f.nCount;
    float cnt_t = data_t.nCount;
    float p = cnt_t / (cnt_f + cnt_t)*100;
    
    NSString* result = [NSString stringWithFormat:@"%.0f%% correct",p];
    self.lblInfo.text = result;
    
    if ([CGlobal quizValid:data_f Data:data_t List:nil]) {
        self.lblStatus.hidden = true;
    }else{
        self.lblStatus.hidden = false;
    }
}
-(void)setBackMode:(NSInteger)backMode{
    _backMode = backMode;
    
    
}
@end
