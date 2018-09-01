//
//  BottomView.h
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomView : UIView
@property(nonatomic,weak) IBOutlet NSLayoutConstraint* constraint_Height;

@property(nonatomic,weak) IBOutlet UIButton* btn1;
@property(nonatomic,weak) IBOutlet UIButton* btn2;
@property(nonatomic,weak) IBOutlet UIButton* btn3;
@property(nonatomic,weak) IBOutlet UIButton* btn4;
@property(nonatomic,weak) IBOutlet UIButton* btn5;

@property(nonatomic,strong) UIViewController *vc;

-(void)customLayout;

+(void)clickMenu:(int)index Vc:(UIViewController*)vc;
@end
