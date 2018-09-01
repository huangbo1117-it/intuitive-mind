//
//  GsrViewController.h
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "MenuViewController.h"

@interface GsrViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;

@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIImageView *img4;

@property (weak, nonatomic) IBOutlet UIImageView *imgResult;
@property (weak, nonatomic) IBOutlet UIButton *btnResult;

@property (weak, nonatomic) IBOutlet UILabel* lblSeconds;


@property (weak, nonatomic) IBOutlet UIView *layMain;
@property (weak, nonatomic) IBOutlet UIView *layResult;

@property (assign, nonatomic) int nCount;
@property (assign, nonatomic) int mMode;


@property (weak, nonatomic) IBOutlet UIStackView *stackBottomMenu;
@end
