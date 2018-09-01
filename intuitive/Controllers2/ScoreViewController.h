//
//  ScoreViewController.h
//  intuitive
//
//  Created by BoHuang on 8/12/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "MenuViewController.h"
#import <Charts/Charts.h>
#import "ColoredLabel.h"
#import "ColoredView.h"
#import "LoginResponse.h"

@interface ScoreViewController : MenuViewController<ChartViewDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgArrow;
@property (weak, nonatomic) IBOutlet ColoredView *viewContent;

@property (strong, nonatomic) BarChartView *chartView;
@property (weak, nonatomic) IBOutlet ColoredLabel *lblDate;
@property (weak, nonatomic) IBOutlet ColoredLabel *lblTime;
@property (weak, nonatomic) IBOutlet ColoredLabel *lblScore;
@property (weak, nonatomic) IBOutlet ColoredView *viewAxis;
@property (weak, nonatomic) IBOutlet UIImageView *imgAxis1;
@property (weak, nonatomic) IBOutlet UIImageView *imgAxis2;

@property (strong,nonatomic) LoginResponse* resp;
@end
