//
//  MyAxisValueFormatter.m
//  intuitive
//
//  Created by BoHuang on 8/12/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "MyAxisValueFormatter.h"
#import <Charts/Charts.h>
#import "CGlobal.h"
@implementation MyAxisValueFormatter

-(NSString *)stringForValue:(double)value entry:(ChartDataEntry *)entry dataSetIndex:(NSInteger)dataSetIndex viewPortHandler:(ChartViewPortHandler *)viewPortHandler{
    return @"";
//    if(entry.x>=0 && entry.x<=self.dataLength){
//        return @"";
//    }
//    if(entry.x>=self.dataLength + g_length){
//        return @"";
//    }
//    NSString* str= [NSString stringWithFormat:@"%.1f",value];
//    return str;
}
@end
