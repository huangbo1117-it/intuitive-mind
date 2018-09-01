//
//  MenuViewController.h
//  intuitive
//
//  Created by BoHuang on 4/25/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BottomView.h"
#import "BottomBarView.h"

@interface MenuViewController : UIViewController
@property (strong, nonatomic) BottomBarView *bottomBar;

@property (weak, nonatomic) IBOutlet UIStackView *stackBottomMenu;
@property (assign,nonatomic) int menuIndex;
@end
