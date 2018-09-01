//
//  ForgotViewController.m
//  intuitive
//
//  Created by BoHuang on 6/1/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "ForgotViewController.h"
#import "MyTextFieldDelegate.h"
#import "NetworkParser.h"
#import "MyPopupDialog.h"
#import "PromptDialog.h"
#import "UIView+Property.h"

@interface ForgotViewController ()

@end

@implementation ForgotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MyTextFieldDelegate* txtDelegate = [[MyTextFieldDelegate alloc] init];
    txtDelegate.view = self.view;
    NSArray* array = @[_edtEmail];
    for (UITextField* txtField in array) {
        [txtField setReturnKeyType:UIReturnKeyDone];
        NSUInteger found = [array indexOfObject:txtField];
        txtField.tag = found+1;
        txtField.delegate = txtDelegate;
    }
    
    [self.btnReset addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)clickView:(UIView*)sender{
    if ([self.edtEmail.text length]>0) {
        NetworkParser* manager = [NetworkParser sharedManager];
        NSMutableDictionary*param = [[NSMutableDictionary alloc] init];
        param[@"tu_email"] = self.edtEmail.text;
        [CGlobal showIndicator:self];
        NSString* path = [COMMON_PATH1 stringByAppendingString:ACTION_FORGOT];
        [manager ontemplateGeneralRequest:param Path:path withCompletionBlock:^(NSDictionary *dict, NSError *error) {
            LoginResponse* resp=[[LoginResponse alloc] initWithDictionary:dict];
            if (error == nil) {
                MyPopupDialog* dialog = [[MyPopupDialog alloc] init];
                PromptDialog* view = [[NSBundle mainBundle] loadNibNamed:@"PromptDialog" owner:self options:nil][0];
                [view setData:@{@"vc":self,@"title":@"Please Check Your Email",@"action":@"exit"}];
                [dialog setup:view backgroundDismiss:false backgroundColor:[UIColor darkGrayColor]];
                [dialog showPopup:self.view];
                
                return;
            }
            [CGlobal AlertMessage:@"Invalid Email Account" Title:nil  Vc:self];
            [CGlobal stopIndicator:self];
        } method:@"post"];
    }
    
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
