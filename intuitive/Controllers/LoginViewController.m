//
//  LoginViewController.m
//  intuitive
//
//  Created by BoHuang on 4/13/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "LoginViewController.h"
#import "SignupViewController.h"
#import "EnvVar.h"
#import "CGlobal.h"
#import "AppDelegate.h"
#import "MyTextFieldDelegate.h"
#import "NetworkParser.h"

@interface LoginViewController ()
@property (nonatomic,strong) MyTextFieldDelegate* txtDelegate;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
//    [_txtUsername setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
//    [_txtPassword setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_txtLogin addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [_txtSignup addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [_txtForgot addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    
    self.txtDelegate = [[MyTextFieldDelegate alloc] init];
    self.txtDelegate.view = self.view;
    NSArray* array = @[_txtUsername, _txtPassword];
    for (UITextField* txtField in array) {
        [txtField setReturnKeyType:UIReturnKeyDone];
        NSUInteger found = [array indexOfObject:txtField];
        txtField.tag = found+1;
        txtField.delegate = self.txtDelegate;
    }
    
    _txtLogin.tag = 200;
    _txtSignup.tag = 201;
    _txtForgot.tag = 202;
}
-(void)clickView:(UIView*)sender{
    int tag = (int)sender.tag;
    switch (tag) {
        case 200:
        {
            // login
            
            NSString* c_username = _txtUsername.text;
            NSString* c_password = _txtPassword.text;
            NetworkParser* manager = [NetworkParser sharedManager];
            NSString* path = [COMMON_PATH1 stringByAppendingString:ACTION_LOGIN];
            NSMutableDictionary* param = [[NSMutableDictionary alloc] init];
            param[@"tu_username"] = c_username;
            param[@"tu_password"] = c_password;
            param[@"action"] = @"sign";
            
            [CGlobal showIndicator:self];
            [manager ontemplateGeneralRequest:param Path:path withCompletionBlock:^(NSDictionary *dict, NSError *error) {
                LoginResponse* resp = [[LoginResponse alloc] initWithDictionary:dict];
                if (error == nil) {
                    if (resp.tblUser!=nil) {
                        AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                        [delegate goMainWindow:resp];
                        return;
                    }
                }else{
                    if (resp.response !=nil) {
                        int response = [resp.response intValue];
                        if (response == 500) {
                            [CGlobal AlertMessage:@"Invalid Username" Title:nil Vc:self];
                            
                        }
                        if (response == 600) {
                            [CGlobal AlertMessage:@"Invalid Password" Title:nil Vc:self];
                        }
                    }
                    
                }
//                [CGlobal AlertMessage:@"Fail" Title:nil Vc:self];
                
                [CGlobal stopIndicator:self];
            } method:@"post"];
            break;
        }
        case 201:{
            // signup
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                     bundle: nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"SignupViewController"];
                [self.navigationController pushViewController:vc animated:true];
                
            });
            break;
        }
        case 202:{
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                     bundle: nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"ForgotViewController"];
                [self.navigationController pushViewController:vc animated:true];
                
            });
            break;
        }
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
