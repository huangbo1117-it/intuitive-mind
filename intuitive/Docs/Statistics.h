//
//  Statistics.h
//  intuitive
//
//  Created by BoHuang on 6/27/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Statistics : NSObject

@property (nonatomic,strong) NSArray* dataSet;

@property (nonatomic,assign) double size;
-(double)getVariance;
-(double)getMean;
@end
