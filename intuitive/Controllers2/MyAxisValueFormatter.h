//
//  MyAxisValueFormatter.h
//  intuitive
//
//  Created by BoHuang on 8/12/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Charts/Charts.h>

@interface MyAxisValueFormatter : NSObject<IChartValueFormatter>
@property (nonatomic,assign) NSInteger dataLength;
@end
