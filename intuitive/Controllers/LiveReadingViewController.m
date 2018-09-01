//
//  LiveReadingViewController.m
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "LiveReadingViewController.h"
#import "CGlobal.h"
#import <Charts/Charts.h>

@interface LiveReadingViewController ()<ChartViewDelegate>
@property (nonatomic,strong) NSTimer* timer;
@property (nonatomic,assign) int index;
@property (nonatomic,assign) int length;
@end

@implementation LiveReadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.length = 15;
    NSMutableArray* array = [[NSMutableArray alloc] init];
    for (int i=0; i<self.length; i++) {
        ChartDataEntry* entry1 = [[ChartDataEntry alloc] initWithX:(double)(i) y:(double)0];
        [array addObject:entry1];
        self.index = i;
    }
    
    ChartDataEntry* entry1 = [[ChartDataEntry alloc] initWithX:(double)(self.index) y:(double)0];
    LineChartDataSet *set_a = [[LineChartDataSet alloc] initWithValues:@[entry1] label:@""];
    set_a.drawCirclesEnabled = false;
    set_a.drawValuesEnabled = false;
    [set_a setColor:[CGlobal colorWithHexString:@"4472c4" Alpha:1.0f]];
    
    NSArray<ChartDataEntry*>* temp = [NSArray arrayWithArray:array];
    self.mChart.delegate = self;
    LineChartDataSet *set_b = [[LineChartDataSet alloc] initWithValues:temp label:@""];
    set_b.drawCirclesEnabled = false;
    set_b.drawValuesEnabled = false;
    [set_b setColor:[UIColor clearColor]];
    
    
    self.mChart.data = [[LineChartData alloc] initWithDataSets:@[set_a,set_b]];
    [self.mChart.rightAxis setDrawLabelsEnabled:false];
    [self.mChart.xAxis setLabelPosition:XAxisLabelPositionBottom];
    ChartDescription * description = [[ChartDescription alloc] init];
    description.text = @"";
    self.mChart.chartDescription = description;
    self.mChart.backgroundColor = [UIColor clearColor];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCounter) userInfo:nil repeats:true];
    
    self.mChart.leftAxis.labelTextColor = [UIColor whiteColor];
    self.mChart.xAxis.labelTextColor = [UIColor whiteColor];
    
    
    self.mChart.legend.enabled = false;
}
-(void)updateCounter{
    if (g_islive) {
        self.index = self.index+1;
        double val = [g_gsr doubleValue];
        ChartDataEntry* entry1 = [[ChartDataEntry alloc] initWithX:(double)(self.index) y:val];
        
        ChartDataEntry* entry2 = [[ChartDataEntry alloc] initWithX:(double)(self.index) y:val];
        
        
        [self.mChart.data addEntry:entry1 dataSetIndex:0];
        //    [self.mChart.data addEntry:entry2 dataSetIndex:1];
        
        [self.mChart setVisibleXRangeMinimum:(double)1];
        [self.mChart setVisibleXRangeMaximum:(double)self.length];
        [self.mChart notifyDataSetChanged];
        [self.mChart moveViewToX:(double)self.index];
        
        
//        [self.mChart setVisibleYRangeMinimum:offset1-20 axis:AxisDependencyLeft];
//        [self.mChart setVisibleYRangeMaximum:offset1+20 axis:AxisDependencyLeft];
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
