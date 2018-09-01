//
//  GraphViewController.h
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "MenuViewController.h"
#import "ColoredView.h"
#import <Charts/Charts.h>
#import "GraphView.h"
#import "ListViewController.h"
#import "TblGraph.h"

@interface GraphViewController : MenuViewController

@property (weak, nonatomic) IBOutlet GraphView *mGraph;

//@property (strong, nonatomic) NSString* filename;
@property (strong, nonatomic) TblGraph* tblGraph;

@property (weak, nonatomic) IBOutlet ColoredView *viewTab;
@property (weak, nonatomic) IBOutlet ColoredView *viewTab1;
@property (weak, nonatomic) IBOutlet ColoredView *viewTab2;
@property (weak, nonatomic) IBOutlet UIButton *btnTab0;
@property (weak, nonatomic) IBOutlet UIButton *btnTab1;
@property (weak, nonatomic) IBOutlet UIButton *btnTab2;

@property (weak, nonatomic) IBOutlet UIView *viewTabHolder;


@property (assign, nonatomic) int curTabIndex;

@property (strong, nonatomic) UIViewController* vc;
@end
