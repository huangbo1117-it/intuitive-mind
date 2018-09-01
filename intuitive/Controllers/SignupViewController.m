//
//  SignupViewController.m
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "SignupViewController.h"
#import "CGlobal.h"
#import "MyTextFieldDelegate.h"
#import "NetworkParser.h"
#import "MyPopupDialog.h"
#import "PromptDialog.h"
#import "UIView+Property.h"

@interface SignupViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong) NSMutableArray* data_day;
@property (nonatomic,strong) NSMutableArray* data_month;
@property (nonatomic,strong) NSMutableArray* data_year;
@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
//    [_txtUsername setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
//    [_txtPassword setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
//    [_txtEmail setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
//    [_txtConfirm setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];

    [_btnSignup addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    
    _btnSignup.tag = 201;
    
    self.data_day = [[NSMutableArray alloc] init];
    self.data_year = [[NSMutableArray alloc] init];
    self.data_month = [[NSMutableArray alloc] init];
    for (int i=31; i>=1; i--) {
        NSString *aData = [NSString stringWithFormat:@"%d",i];
        [self.data_day addObject:aData];
    }
    for (int i=12; i>=1; i--) {
        NSString *aData = [NSString stringWithFormat:@"%d",i];
        [self.data_month addObject:aData];
    }
    for (int i=2017; i>=1950; i--) {
        NSString *aData = [NSString stringWithFormat:@"%d",i];
        [self.data_year addObject:aData];
    }
    
    UIPickerView* pk1 = [[UIPickerView alloc] init];
    self.txtDay.inputView = pk1;
    pk1.delegate = self;
    pk1.dataSource = self;
    pk1.tag = 100;
    
    UIPickerView* pk2 = [[UIPickerView alloc] init];
    self.txtMonth.inputView = pk2;
    pk2.delegate = self;
    pk2.dataSource = self;
    pk2.tag = 101;
    
    UIPickerView* pk3 = [[UIPickerView alloc] init];
    self.txtYear.inputView = pk3;
    pk3.delegate = self;
    pk3.dataSource = self;
    pk3.tag = 102;
    
    self.txtDay.text = self.data_day[0];
    self.txtMonth.text = self.data_month[0];
    self.txtYear.text = self.data_year[0];
    
    MyTextFieldDelegate* txtDelegate = [[MyTextFieldDelegate alloc] init];
    txtDelegate.view = self.view;
    NSArray* array = @[_txtUsername,_txtEmail, _txtPassword,_txtConfirm];
    for (UITextField* txtField in array) {
        [txtField setReturnKeyType:UIReturnKeyDone];
        NSUInteger found = [array indexOfObject:txtField];
        txtField.tag = found+1;
        txtField.delegate = txtDelegate;
    }
    MyTextFieldDelegate* passDelegate = [[MyTextFieldDelegate alloc] init];
    passDelegate.view = self.view;
    passDelegate.field_type = [NSNumber numberWithInt:FIELD_TYPE_PASSWORD];
    passDelegate.vc = self;
    
}
-(NSMutableDictionary*)checkValidate{
    NSString* username = _txtUsername.text;
    NSString* email = _txtEmail.text;
    NSString* password = _txtPassword.text;
    NSString* confirm = _txtConfirm.text;
    
    NSMutableDictionary* param = [[NSMutableDictionary alloc] init];
    MyPopupDialog* dialog = [[MyPopupDialog alloc] init];
    PromptDialog* view = [[NSBundle mainBundle] loadNibNamed:@"PromptDialog" owner:self options:nil][0];
    
    [dialog setup:view backgroundDismiss:false backgroundColor:[UIColor darkGrayColor]];
    if (username == nil || [username isEqualToString:@""]) {
        [view setData:@{@"title":@"Invalid Username",@"action":@"close"}];
        [dialog showPopup:self.view];
        return false;
    }
    
    
    if (email == nil || [email isEqualToString:@""]) {
        [view setData:@{@"title":@"Invalid Email Account",@"action":@"close"}];
        [dialog showPopup:self.view];
        return false;
    }
    
    
    if (password == nil || [password isEqualToString:@""]) {
        [view setData:@{@"title":@"Incorrect Password",@"action":@"close"}];
        [dialog showPopup:self.view];
        return false;
    }
    
    if (confirm == nil || [confirm isEqualToString:@""]) {
        [view setData:@{@"title":@"Incorrect Password",@"action":@"close"}];
        [dialog showPopup:self.view];
        return false;
    }
    
    if (![CGlobal isValidEmail:email]) {
        [view setData:@{@"title":@"Invalid Email Account",@"action":@"close"}];
        [dialog showPopup:self.view];
        return false;
    }
    if (![password isEqualToString:confirm]) {
        [view setData:@{@"title":@"Password Mismatch",@"action":@"close"}];
        [dialog showPopup:self.view];
        return false;
    }
    if (self.gender == nil) {
        [view setData:@{@"title":@"Please select Gender.",@"action":@"close"}];
        [dialog showPopup:self.view];
        return false;
    }
    
    if ([username contains:@" "]) {
        [view setData:@{@"title":@"Invalid Username",@"action":@"close"}];
        [dialog showPopup:self.view];
        return false;
    }
    
    int year = [self.txtYear.text intValue];
    int month = [self.txtMonth.text intValue];
    int day = [self.txtDay.text intValue];
    
    NSString* birth = [NSString stringWithFormat:@"%02d-%02d-%02d 00:00:00",year,month,day];
    
    param[@"tu_username"] = username;
    param[@"tu_email"] = email;
    param[@"tu_password"] = password;
    param[@"tu_gender"] = self.gender;
    param[@"tu_birth"] = birth;
    
    return param;
}
-(void)clickView:(UIView*)sender{
    int tag = (int)sender.tag;
    switch (tag) {
        case 201:{
            // signup
            NSMutableDictionary* param = [self checkValidate];
            if (param != nil) {
                
                
                NetworkParser* manager = [NetworkParser sharedManager];
                NSString* path = [COMMON_PATH1 stringByAppendingString:ACTION_LOGIN];
                
                
                param[@"action"] = @"signup_normal";
                
                [CGlobal showIndicator:self];
                [manager ontemplateGeneralRequest:param Path:path withCompletionBlock:^(NSDictionary *dict, NSError *error) {
                    LoginResponse* resp = [[LoginResponse alloc] initWithDictionary:dict];
                    if (error == nil) {
                        
                        [CGlobal stopIndicator:self];
                        
                        MyPopupDialog* dialog = [[MyPopupDialog alloc] init];
                        PromptDialog* view = [[NSBundle mainBundle] loadNibNamed:@"PromptDialog" owner:self options:nil][0];
                        [view setData:@{@"vc":self,@"title":@"Account Created",@"action":@"exit"}];
                        [dialog setup:view backgroundDismiss:false backgroundColor:[UIColor darkGrayColor]];
                        [dialog showPopup:self.view];
                        
                        
                        return;
                    }else{
                        if ([resp.response intValue] == 500) {
                            [CGlobal AlertMessage:@"Username already exists" Title:nil Vc:self];
                            [CGlobal stopIndicator:self];
                            return;
                        }
                        if ([resp.response intValue] == 600) {
                            
                            [CGlobal AlertMessage:@"Email already exists" Title:nil Vc:self];
                            [CGlobal stopIndicator:self];
                            return;
                        }
                    }
//                    [CGlobal AlertMessage:@"Fail" Title:nil Vc:self];
                    [CGlobal stopIndicator:self];
                } method:@"post"];
                
            }
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
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    int tag = (int)pickerView.tag;
    switch (tag) {
            case 100:
        {
            return self.data_day.count;
            break;
        }
            case 101:
        {
            return self.data_month.count;
            break;
        }
        default:{
            return self.data_year.count;
            break;
        }
            
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    int tag = (int)pickerView.tag;
    switch (tag) {
        case 100:
        {
            _txtDay.text =  self.data_day[row];
            break;
        }
        case 101:
        {
            _txtMonth.text =  self.data_month[row];
            break;
        }
        default:{
            _txtYear.text = self.data_year[row];
            break;
        }
            
    }
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    int tag = (int)pickerView.tag;
    switch (tag) {
            case 100:
        {
            return self.data_day[row];
            break;
        }
            case 101:
        {
            return self.data_month[row];
            break;
        }
        default:{
            return self.data_year[row];
            break;
        }
            
    }
}
- (IBAction)clickMale:(id)sender {
    self.circleMale.backMode = 7;
    self.circleFemale.backgroundColor = [UIColor whiteColor];
    self.gender = @"1";
}
- (IBAction)clickFemale:(id)sender {
    self.circleFemale.backMode = 7;
    self.circleMale.backgroundColor = [UIColor whiteColor];
    self.gender = @"0";
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
