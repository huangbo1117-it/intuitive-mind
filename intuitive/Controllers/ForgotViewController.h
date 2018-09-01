//
//  ForgotViewController.h
//  intuitive
//
//  Created by BoHuang on 6/1/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "MenuViewController.h"
#import "FontTextField.h"
#import "ColoredButton.h"
#import "MyPopupDialog.h"

@interface ForgotViewController : MenuViewController
@property (weak, nonatomic) IBOutlet FontTextField *edtEmail;
@property (weak, nonatomic) IBOutlet ColoredButton *btnReset;

@end
