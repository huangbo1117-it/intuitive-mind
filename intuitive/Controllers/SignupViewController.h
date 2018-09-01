//
//  SignupViewController.h
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "MenuViewController.h"
#import "BottomBarView.h"
#import "FontTextField.h"
#import "ColoredView.h"

@interface SignupViewController : MenuViewController
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtConfirm;
@property (weak, nonatomic) IBOutlet UIButton *btnSignup;

@property (weak, nonatomic) IBOutlet FontTextField *txtDay;
@property (weak, nonatomic) IBOutlet FontTextField *txtMonth;
@property (weak, nonatomic) IBOutlet FontTextField *txtYear;

@property (weak, nonatomic) IBOutlet ColoredView *circleMale;
@property (weak, nonatomic) IBOutlet ColoredView *circleFemale;

@property (copy, nonatomic) NSString* gender;
@end
