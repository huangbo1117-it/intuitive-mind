//
//  BluDeviceViewController.h
//  intuitive
//
//  Created by BoHuang on 5/30/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "MenuViewController.h"

@interface BluDeviceViewController : MenuViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *imgLoading;
@property (weak, nonatomic) IBOutlet UIButton *btnLoading;
@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property (weak, nonatomic) IBOutlet UIView *viewMessage;

@end
