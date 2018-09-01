//
//  TestViewController.m
//  intuitive
//
//  Created by BoHuang on 6/1/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField* tempField;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _innerText.inputAccessoryView = self.keyBoxView;
    
    _tempField = [UITextField new];
    [self.view addSubview:_tempField];
    _tempField.inputAccessoryView = self.keyBoxView;
//    _tempField.delegate = self;
//    [_tempField addTarget:self action:@selector(tempFieldChanged:) forControlEvents:UIControlEventTouchUpInside];
    [self.keyBoxView.txtField addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventEditingDidEndOnExit];
}
-(void)doneButton:(UITextField*)textField{
    NSLog(@"%@",textField.text);
    
    [self.view endEditing:YES];
    [self.txtField1 resignFirstResponder];
}
-(void)tempFieldChanged:(UITextField*)textField{
    if (textField == self.tempField) {
        self.keyBoxView.txtField.text = textField.text;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)opp2:(id)sender {
    [self.keyBoxView.txtField setReturnKeyType:UIReturnKeyDone];
    self.txtField1.inputAccessoryView = self.keyBoxView;
    
    [self.txtField1 becomeFirstResponder];
    //[_tempField becomeFirstResponder];
    [self.keyBoxView.txtField becomeFirstResponder];
}
- (IBAction)opp:(id)sender {
    [self.keyBoxView.txtField setReturnKeyType:UIReturnKeyDone];
    
    [_tempField becomeFirstResponder];
    [self.keyBoxView.txtField becomeFirstResponder];
    
    
//    [self.keyBoxView.txtField becomeFirstResponder];
//    self.keyBoxView.txtField.inputAccessoryView = self.keyBoxView;
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
