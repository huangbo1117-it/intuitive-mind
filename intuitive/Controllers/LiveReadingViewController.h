//
//  LiveReadingViewController.h
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "MenuViewController.h"

@class LineChartView;
@interface LiveReadingViewController : MenuViewController

@property (weak, nonatomic) IBOutlet LineChartView *mChart;

@end
