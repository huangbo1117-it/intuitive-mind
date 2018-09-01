//
//  MyTextFieldDelegate.m
//  intuitive
//
//  Created by BoHuang on 6/5/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "MyTextFieldDelegate.h"
#import "MyPopupDialog.h"
#import "PromptDialog.h"

@implementation MyTextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [self.view viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (_field_type!=nil) {
        enum FIELD_TYPE type =  [_field_type intValue];
        switch (type) {
            case FIELD_TYPE_PASSWORD:
            {
                return [self shouldChangePassword:string];
                break;
            }
                
                
            default:
                break;
        }
    }
    return true;
}
-(BOOL)shouldChangePassword:(NSString*)string{
    if ([string containsString:@" "]) {
        if (self.vc!=nil) {
            MyPopupDialog* dialog = [[MyPopupDialog alloc] init];
            PromptDialog* view = [[NSBundle mainBundle] loadNibNamed:@"PromptDialog" owner:self.vc options:nil][0];
            [view setData:@{@"title":@"No Space Allowed",@"action":@"close"}];
            [dialog showPopup:self.view];
        }
        
        return NO;
    }
    return YES;
}
@end
