//
//  GraphView.h
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColoredView.h"
#import <Charts/Charts.h>
#import "TblGraph.h"

@interface GraphView : UIView

@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblInfo;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;

@property (weak, nonatomic) IBOutlet ColoredView *viewLeft;
@property (weak, nonatomic) IBOutlet UIImageView *imgAxis_Head;
@property (weak, nonatomic) IBOutlet LineChartView *mChart;

@property (weak, nonatomic) IBOutlet UIImageView *imgAxis;

@property(nonatomic,strong) UIViewController *vc;

-(void)customLayout;

//@property(nonatomic,strong) NSString* filename;
@property(nonatomic,strong) TblGraph* tblGraph;

@property (weak, nonatomic) IBOutlet UIStackView *stackDecision;
@property (weak, nonatomic) IBOutlet UIView *viewAxis_X;

@property (weak, nonatomic) IBOutlet UIButton *btnShare;
@property (weak, nonatomic) IBOutlet UIImageView *imgShare;

@property (nonatomic) IBInspectable NSInteger backMode;
@end
