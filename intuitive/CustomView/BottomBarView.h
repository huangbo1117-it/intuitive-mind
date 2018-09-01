//
//  BottomBarView.h
//  intuitive
//
//  Created by BoHuang on 5/29/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColoredLabel.h"
#import "ColoredView.h"

@interface BottomBarView : UIView
@property(nonatomic,weak) IBOutlet NSLayoutConstraint* constraint_Height;

@property(nonatomic,weak) IBOutlet UIButton* btnMenu1;
@property(nonatomic,weak) IBOutlet UIButton* btnMenu2;
@property(nonatomic,weak) IBOutlet UIButton* btnMenu3;
@property(nonatomic,weak) IBOutlet UIButton* btnMenu4;
@property(nonatomic,weak) IBOutlet UIButton* btnMenu5;
@property(nonatomic,weak) IBOutlet UIButton* btnMenu6;

@property(nonatomic,weak) IBOutlet UIImageView* imgMenu1;
@property(nonatomic,weak) IBOutlet UIImageView* imgMenu2;
@property(nonatomic,weak) IBOutlet UIImageView* imgMenu3;
@property(nonatomic,weak) IBOutlet UIImageView* imgMenu4;
@property(nonatomic,weak) IBOutlet UIImageView* imgMenu5;
@property(nonatomic,weak) IBOutlet UIImageView* imgMenu6;


@property(nonatomic,strong) UIViewController *vc;
-(void)customLayout:(int)menuIndex ScoreAvailable:(BOOL)scoreAvailable;

//@property(nonatomic,weak) IBOutlet NSLayoutConstraint* cons_img_H1;
//@property(nonatomic,weak) IBOutlet NSLayoutConstraint* cons_img_T1;
//@property(nonatomic,weak) IBOutlet NSLayoutConstraint* cons_img_SP1;
@property(nonatomic,weak) IBOutlet ColoredLabel* lbl1;

@property(nonatomic,weak) IBOutlet NSLayoutConstraint* cons_img_H2;
@property(nonatomic,weak) IBOutlet NSLayoutConstraint* cons_img_T2;
@property(nonatomic,weak) IBOutlet NSLayoutConstraint* cons_img_SP2;
@property(nonatomic,weak) IBOutlet ColoredLabel* lbl2;

//@property(nonatomic,weak) IBOutlet NSLayoutConstraint* cons_img_H3;
//@property(nonatomic,weak) IBOutlet NSLayoutConstraint* cons_img_T3;
//@property(nonatomic,weak) IBOutlet NSLayoutConstraint* cons_img_SP3;
@property(nonatomic,weak) IBOutlet ColoredLabel* lbl3;

//@property(nonatomic,weak) IBOutlet NSLayoutConstraint* cons_img_H4;
//@property(nonatomic,weak) IBOutlet NSLayoutConstraint* cons_img_T4;
//@property(nonatomic,weak) IBOutlet NSLayoutConstraint* cons_img_SP4;
@property(nonatomic,weak) IBOutlet ColoredLabel* lbl4;

@property(nonatomic,weak) IBOutlet NSLayoutConstraint* cons_img_H5;
@property(nonatomic,weak) IBOutlet NSLayoutConstraint* cons_img_T5;
@property(nonatomic,weak) IBOutlet NSLayoutConstraint* cons_img_SP5;
@property(nonatomic,weak) IBOutlet ColoredLabel* lbl5;

//@property(nonatomic,weak) IBOutlet NSLayoutConstraint* cons_img_H6;
//@property(nonatomic,weak) IBOutlet NSLayoutConstraint* cons_img_T6;
//@property(nonatomic,weak) IBOutlet NSLayoutConstraint* cons_img_SP6;
@property(nonatomic,weak) IBOutlet ColoredLabel* lbl6;

+(void)clickMenu:(NSMutableDictionary*)data;
@property (weak, nonatomic) IBOutlet UILabel *lblLatest;
@property (weak, nonatomic) IBOutlet ColoredView *viewLatest;

@end
