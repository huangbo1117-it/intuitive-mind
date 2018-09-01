//
//  LoginViewController.h
//  intuitive
//
//  Created by BoHuang on 4/13/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "MenuViewController.h"

@interface LoginViewController : MenuViewController

@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UILabel *lblForgot;
@property (weak, nonatomic) IBOutlet UIButton *txtSignup;
@property (weak, nonatomic) IBOutlet UIButton *txtLogin;
@property (weak, nonatomic) IBOutlet UIButton *txtForgot;

@end
