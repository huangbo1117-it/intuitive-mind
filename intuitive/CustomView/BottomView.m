//
//  BottomView.m
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BottomView.h"
#import "CGlobal.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "TrainingSelectViewController.h"
#import "ListViewController.h"
#import "LiveReadingViewController.h"
#import "UploadViewController.h"
@implementation BottomView

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
        NSLog(@"TopBarView initWithFrame");
    }
    //283d61
    self.backgroundColor = COLOR_RESERVED;
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"TopBarView initWithCoder");
    }
    self.backgroundColor = [CGlobal colorWithHexString:@"181818" Alpha:1.0f];
    return self;
}
-(void)customLayout{
    if (_constraint_Height!=nil) {
        _constraint_Height.constant = 46;
    }
    
    [_btn1 addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [_btn2 addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [_btn3 addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [_btn4 addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [_btn5 addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    
    _btn1.tag = 201;
    _btn2.tag = 202;
    _btn3.tag = 203;
    _btn4.tag = 204;
    _btn5.tag = 205;
    
    
}
-(void)clickView:(UIView*)sender{
    int tag = (int)sender.tag;
    switch (tag) {
        case 201:
        {
            [BottomView clickMenu:1 Vc:self.vc];
            break;
        }
        case 202:
        {
            [BottomView clickMenu:2 Vc:self.vc];
            break;
        }
        case 203:
        {
            [BottomView clickMenu:3 Vc:self.vc];
            break;
        }
        case 204:
        {
            [BottomView clickMenu:4 Vc:self.vc];
            break;
        }
        case 205:
        {
            [BottomView clickMenu:5 Vc:self.vc];
            break;
        }
        default:
            break;
    }
}
+(void)clickMenu:(int)index Vc:(UIViewController*)vc{
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
    switch (index) {
        case 1:
        {
            nextvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"TrainingSelectViewController"];
            break;
        }
        case 2:
        {
            nextvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"ListViewController"];
            break;
        }
        case 3:
        {
            //nil
            break;
        }
        case 4:
        {
            nextvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"LiveReadingViewController"];
            break;
        }
        case 5:
        {
            nextvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadViewController"];
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
-(void)setCaption:(NSString*)caption{
    
}
@end
