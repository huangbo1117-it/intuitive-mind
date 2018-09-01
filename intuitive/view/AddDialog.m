//
//  AddDialog.m
//  JellyRole
//
//  Created by BoHuang on 3/25/17.
//  Copyright © 2017 mac. All rights reserved.
//

#import "AddDialog.h"
#import "CGlobal.h"
@implementation AddDialog

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setStyleWithData:(NSMutableDictionary*)data Mode:(int)mode{
    _mode = [NSNumber numberWithInt:mode];
    _txtUsername.text = data[@"username"];
    _txtPassword.text = @"";
    _txtUsername.placeholder = @"USERNAME";
    _txtPassword.placeholder = @"PASSWORD";
    _txtConfirm.placeholder = @"CONFIRM PASSWORD";
    
    _txtUsername.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    _txtPassword.secureTextEntry = true;
    _txtConfirm.secureTextEntry = true;
}
- (IBAction)onConfirm:(id)sender {
    NSString* text = _txtUsername.text;
    NSString* pass = _txtPassword.text;
    NSString* conf = _txtConfirm.text;
    if ([text isEqualToString:@""]) {
        [CGlobal AlertMessage:@"INPUT USERNAME" Title:nil Vc:nil];
        return;
    }
    if ([pass isEqualToString:@""]) {
        [CGlobal AlertMessage:@"INPUT PASSWORD" Title:nil Vc:nil];
        return;
    }
    if (![pass isEqualToString:conf]) {
        [CGlobal AlertMessage:@"PASSWORD DON'T MATCH" Title:nil Vc:nil];
        return;
    }
    
    if (_aDelegate!=nil) {
        [_aDelegate didSubmit:@{@"mode":_mode,@"username":text,@"password":pass} View:self];
    }
}
@end
