//
//  ListViewController.h
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "MenuViewController.h"
#import "GraphView.h"
#import "MGSwipeTableCell.h"

@interface ListViewController : MenuViewController<UITableViewDelegate,UITableViewDataSource,MGSwipeTableCellDelegate>

@property (weak, nonatomic) IBOutlet GraphView *mGraph;
@property (weak, nonatomic) IBOutlet GraphView *mGraph1;
@property (weak, nonatomic) IBOutlet GraphView *mGraph2;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *tableView1;
@property (weak, nonatomic) IBOutlet UITableView *tableView2;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_TH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_TH1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_TH2;

@property (weak, nonatomic) IBOutlet UIButton *btnTab0;
@property (weak, nonatomic) IBOutlet UIButton *btnTab1;
@property (weak, nonatomic) IBOutlet UIButton *btnTab2;

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll1;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll2;
@property (weak, nonatomic) IBOutlet ColoredView *viewTab;
@property (weak, nonatomic) IBOutlet ColoredView *viewTab1;
@property (weak, nonatomic) IBOutlet ColoredView *viewTab2;

@property (strong, nonatomic) NSNumber* inputTabIndex;
@end
