//
//  MenuViewController.m
//  intuitive
//
//  Created by BoHuang on 4/25/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "MenuViewController.h"
#import "MainViewController.h"
#import "TrainingSelectViewController.h"
#import "GsrViewController.h"
#import "ListViewController.h"
#import "GraphViewController.h"
#import "LiveReadingViewController.h"
#import "UploadViewController.h"
#import "BluDeviceViewController.h"
#import "SignupViewController.h"
#import "LoginViewController.h"
#import "ForgotViewController.h"
#import "ScoreViewController.h"
#import "CGlobal.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBottomView];
    // Do any additional setup after loading the view.
    if (_menuIndex>=200 && _menuIndex<=205) {
        [_bottomBar customLayout:_menuIndex-200 ScoreAvailable:true];
    }else{
        if ([self isKindOfClass:[MainViewController class]]) {
            [_bottomBar customLayout:-1 ScoreAvailable:true];
        }else if ([self isKindOfClass:[TrainingSelectViewController class]]) {
            [_bottomBar customLayout:1 ScoreAvailable:true];
        }else if ([self isKindOfClass:[GsrViewController class]]) {
            [_bottomBar customLayout:1 ScoreAvailable:true];
        }else if ([self isKindOfClass:[ListViewController class]]) {
            [_bottomBar customLayout:2 ScoreAvailable:false];
        }else if ([self isKindOfClass:[BluDeviceViewController class]]) {
            [_bottomBar customLayout:3 ScoreAvailable:true];
        }else if ([self isKindOfClass:[LiveReadingViewController class]]) {
            [_bottomBar customLayout:4 ScoreAvailable:true];
        }else if ([self isKindOfClass:[UploadViewController class]]) {
            [_bottomBar customLayout:5 ScoreAvailable:true];
        }else if ([self isKindOfClass:[SignupViewController class]]) {
            [_bottomBar customLayout:0 ScoreAvailable:false];
        }else if ([self isKindOfClass:[LoginViewController class]]) {
            [_bottomBar customLayout:0 ScoreAvailable:false];
        }else if ([self isKindOfClass:[ForgotViewController class]]) {
            [_bottomBar customLayout:0 ScoreAvailable:false];
        }else if ([self isKindOfClass:[ScoreViewController class]]) {
            [_bottomBar customLayout:2 ScoreAvailable:false];
        }else{
            [_bottomBar customLayout:-1 ScoreAvailable:true];
        }
    }
    
    _bottomBar.vc = self;
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.view.backgroundColor = COLOR_RESERVED;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if ([self isKindOfClass:[GraphViewController class]]) {
        GraphViewController*gvc = (GraphViewController*)self;
//        if(gvc.viewTabHolder.hidden){
//            self.navigationController.navigationBar.hidden = false;
//            return;
//        }
    }
    self.navigationController.navigationBar.hidden = true;
    
}
-(void)addBottomView{
    NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"BottomBarView" owner:self options:nil];
    _bottomBar = (BottomBarView*)views[0];
    
    [_stackBottomMenu addArrangedSubview:_bottomBar];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)gotoMenu:(int)index{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
