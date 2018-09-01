//
//  Statistics.m
//  intuitive
//
//  Created by BoHuang on 6/27/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "Statistics.h"

@implementation Statistics

-(void)setDataSet:(NSArray *)dataSet{
    _dataSet = dataSet;
    _size = dataSet.count;
}

-(double)getMean{
    double sum = 0.0;
    for (NSNumber* a in _dataSet) {
        sum = sum + [a doubleValue];
    }
    return sum/_size;
}
-(double)getVariance{
    double mean = [self getMean];
    double temp = 0;
    for (NSNumber* a in _dataSet) {
        temp = temp + ([a doubleValue]-mean)*([a doubleValue]-mean);
    }
    return temp/(_size-1);
}
@end
