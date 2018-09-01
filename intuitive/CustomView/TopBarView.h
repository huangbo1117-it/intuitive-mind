//
//  TopBarView.h
//  intuitive
//
//  Created by BoHuang on 4/13/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopBarView : UIView

@property(nonatomic,weak) IBOutlet NSLayoutConstraint* constraint_Height;

@property(nonatomic,weak) IBOutlet UILabel* label;
@property(nonatomic,weak) IBOutlet UIImageView* imgLeft;

@property(nonatomic,weak) IBOutlet UIButton* btnConnect;
@property(nonatomic,weak) IBOutlet UIButton* btnLogout;

-(void)customLayout;
@end
