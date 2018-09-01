//
//  BottomBarView.m
//  intuitive
//
//  Created by BoHuang on 5/29/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BottomBarView.h"
#import "CGlobal.h"
#import "AppDelegate.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "TrainingSelectViewController.h"
#import "ListViewController.h"
#import "LiveReadingViewController.h"
#import "UploadViewController.h"
#import "BluDeviceViewController.h"
#import "ForgotViewController.h"
#import "MyPopupDialog.h"
#import "PromptDialog.h"
#import "NetworkParser.h"

@implementation BottomBarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"BottomBarView initWithFrame");
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"BottomBarView initWithCoder");
    }
    return self;
}
-(void)showLatestScore{
    if (g_LatestGraph!=nil) {
        self.lblLatest.text = [g_LatestGraph getLatestScoreStr];
    }else{
        EnvVar*env = [CGlobal sharedId].env;
        NSString*userid = [NSString stringWithFormat:@"%ld", env.lastLogin];
        
        NetworkParser* manager = [NetworkParser sharedManager];
        NSString*path = [COMMON_PATH1 stringByAppendingString:ACTION_GRAPH];
        NSMutableDictionary* param = [[NSMutableDictionary alloc] init];
        param[@"action"] = @"fetchall";
        param[@"tu_id"] = userid;
        
        [manager ontemplateGeneralRequest:param Path:path withCompletionBlock:^(NSDictionary *dict, NSError *error) {
            LoginResponse *resp = [[LoginResponse alloc] initWithDictionary:dict];
            if ([resp.tblGraph_list count]>0) {
                TblGraph* graph = [resp.tblGraph_list lastObject];
                if ([graph isKindOfClass:[TblGraph class]]) {
                    g_LatestGraph = graph;
                    self.lblLatest.text = [g_LatestGraph getLatestScoreStr];
                }
            }
            
        } method:@"post"];
    }
}
-(void)customLayout:(int)menuIndex ScoreAvailable:(BOOL)scoreAvailable{
    CGFloat scoreBarHeight = 38;
    CGFloat menuBoxHeight = 200;
    if (_constraint_Height!=nil) {
        CGRect rt = [UIScreen mainScreen].bounds;
        
        CGFloat height = rt.size.width*0.5;
        if (height>=200) {
            height = 200;
        }
        if (scoreAvailable) {
            _constraint_Height.constant = menuBoxHeight + scoreBarHeight;
            _viewLatest.hidden = false;
            [self showLatestScore];
        }else{
            _constraint_Height.constant = menuBoxHeight;
            _viewLatest.hidden = true;
        }
        
    }
    NSArray* array = @[_imgMenu1,_imgMenu2,_imgMenu3,_imgMenu4,_imgMenu5,_imgMenu6];
    for (int i=0; i<[array count]; i++) {
        UIImageView* img = array[i];
        UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:@"ico_menu%d.png",i+1]];
        img.image = image;
    }
    if (menuIndex>=0) {
        UIImageView* img = array[menuIndex];
        UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:@"ico_menu%d_gray.png",menuIndex+1]];
        img.image = image;
    }
    
    [self.btnMenu1 addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnMenu2 addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnMenu3 addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnMenu4 addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnMenu5 addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnMenu6 addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnMenu1.tag = 101;
    self.btnMenu2.tag = 102;
    self.btnMenu3.tag = 103;
    self.btnMenu4.tag = 104;
    self.btnMenu5.tag = 105;
    self.btnMenu6.tag = 106;
    
    CGFloat boxHeight = menuBoxHeight/2;
    
    array = @[_lbl1,_lbl2,_lbl3,_lbl4,_lbl5,_lbl6];
    for (int i=0; i< array.count; i++) {
        ColoredLabel* lbl = array[i];
        lbl.msize = 10;
    }
    
    // 90 height
    //      18              0.2
    // 25           0.27
    //      12              0.13
    // 20           0.22
    //
    //              0.18
    
    int testmode = 1;
    switch (testmode) {
        case 2:
        {
            
            break;
        }
        case 1:
        {
            CGFloat rate_top = 0.13;
            CGFloat rate_imgH = 0.4;
            CGFloat rate_space = 0.08;
            CGFloat rate_lblH = 0.22;
            CGFloat rate_rest = 0.18;
            _cons_img_T2.constant = boxHeight *rate_top;
            _cons_img_T5.constant = boxHeight *rate_top;
            
//            array = @[_cons_img_H1,_cons_img_H2,_cons_img_H3,_cons_img_H4,_cons_img_H5,_cons_img_H6];
            array = @[_cons_img_H2,_cons_img_H5];
            for (int i=0; i<array.count; i++) {
                NSLayoutConstraint* cons = array[i];
                cons.constant = boxHeight*rate_imgH;
            }
            
            _cons_img_SP2.constant = boxHeight * rate_space;
            _cons_img_SP5.constant = boxHeight * rate_space;
            break;
        }
            
            
        default:{
            _cons_img_SP2.constant = 12;
            _cons_img_SP5.constant = 12;
            break;
        }
    }
    
    
    EnvVar* env = [CGlobal sharedId].env;
    if (env.lastLogin>0) {
        // logined
        _lbl1.text = @"Log out";
    }else{
        // logout
        _lbl1.text = @"Log in";
    }
    
    
}
-(void)clickView:(UIView*)sender{
    int tag = (int)sender.tag;
    tag = tag - 100;
    NSMutableDictionary*dic = [[NSMutableDictionary alloc] init];
    dic[@"vc"] = self.vc;
    dic[@"index"] = [NSNumber numberWithInt:tag];
    [BottomBarView clickMenu:dic];
}
-(void)setCaption:(NSString*)caption{
    
}
- (IBAction)logout:(id)sender {
    EnvVar* env = [CGlobal sharedId].env;
    [env logOut];
    AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate defaultLogin];
}
- (IBAction)toggleConnect:(id)sender {
    
}
+(BOOL)hasLogin:(UIViewController*)vc{
    EnvVar* env = [CGlobal sharedId].env;
    if (env.lastLogin >0) {
        return true;
    }else{
        MyPopupDialog* dialog = [[MyPopupDialog alloc] init];
        PromptDialog* view = [[NSBundle mainBundle] loadNibNamed:@"PromptDialog" owner:vc options:nil][0];
        
        [dialog setup:view backgroundDismiss:false backgroundColor:[UIColor darkGrayColor]];
        
        [view setData:@{@"title":@"Please Sign In",@"action":@"close"}];
        [dialog showPopup:vc.view];
        return false;
    }
}
//+(void)clickMenu:(int)index Vc:(UIViewController*)vc{
+(void)clickMenu:(NSMutableDictionary*)data{
    UIViewController*vc = data[@"vc"];
    int index = [data[@"index"] intValue];
    NSNumber*tabIndex = data[@"tabIndex"];
    if (vc == nil) {
        return;
    }
    NSArray* array =  vc.navigationController.viewControllers;
    MainViewController* vc_main = nil;
    for (UIViewController* ivc in array) {
        if ([ivc isKindOfClass:[MainViewController class]]) {
            vc_main = (MainViewController*)ivc;
            break;
        }
    }
    UIViewController*nextvc = nil;
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    EnvVar* env = [CGlobal sharedId].env;
    switch (index) {
            case 1:
        {
            nextvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            [env logOut];
            if (vc_main!=nil) {
                [vc_main.bottomBar customLayout:-1 ScoreAvailable:true];
            }
            
            // unlink
            AppDelegate* delegate = (AppDelegate*)([UIApplication sharedApplication].delegate);
            [delegate unlink:nil];
            
            break;
        }
            case 2:
        {
            if ([BottomBarView hasLogin:vc]) {
                nextvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"TrainingSelectViewController"];
            }else{
                return;
            }
            break;
        }
            case 3:
        {
            
            if ([BottomBarView hasLogin:vc]) {
                nextvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"ListViewController"];
                ListViewController*lvc = (ListViewController*)nextvc;
                lvc.inputTabIndex = tabIndex;
            }else{
                return;
            }
            
            break;
        }
            case 4:
        {
            if ([BottomBarView hasLogin:vc]) {
                nextvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"BluDeviceViewController"];
            }else{
                return;
            }
            break;
        }
            case 5:
        {
            if ([BottomBarView hasLogin:vc]) {
                nextvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"LiveReadingViewController"];
            }else{
                return;
            }
            break;
        }
            case 6:
        {
            if ([BottomBarView hasLogin:vc]) {
                nextvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadViewController"];
            }else{
                return;
            }
            break;
        }
        default:
            break;
    }
    if (nextvc!=nil) {
        NSArray* newArray = @[vc_main,nextvc];
        [vc.navigationController setViewControllers:newArray animated:true];
    }else{
        NSArray* newArray = @[vc_main];
        [vc.navigationController setViewControllers:newArray animated:true];
    }
}
@end
