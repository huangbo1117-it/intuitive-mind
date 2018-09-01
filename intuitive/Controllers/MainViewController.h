//
//  MainViewController.h
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "MenuViewController.h"
#import "ColoredView.h"
#import "ColoredLabel.h"
@interface MainViewController : MenuViewController<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet ColoredView *viewContent;
@property (weak, nonatomic) IBOutlet UIImageView *imgContent;
@property (weak, nonatomic) IBOutlet ColoredLabel *lblContent;


@property (weak, nonatomic) IBOutlet UIImageView *imgSlide1;
@property (weak, nonatomic) IBOutlet ColoredLabel *labelSlide1;

@property (weak, nonatomic) IBOutlet UIImageView *imgSlide2;
@property (weak, nonatomic) IBOutlet ColoredLabel *labelSlide2;

@property (weak, nonatomic) IBOutlet UIImageView *imgSlide3;
@property (weak, nonatomic) IBOutlet ColoredLabel *labelSlide3;
@end
