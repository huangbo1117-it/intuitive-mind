//
//  PromptDialog.m
//  intuitive
//
//  Created by BoHuang on 7/8/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "PromptDialog.h"
#import "UIView+Property.h"
#import "MyPopupDialog.h"

@implementation PromptDialog

-(void)setData:(NSDictionary *)data{
    [super setData:data];
    
    self.lblTitle.text = data[@"title"];
    
    if(self.txtDeviceName!=nil){
        self.txtDeviceName.delegate = self;
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (self.aDelegate !=nil) {
        NSMutableDictionary* data = [[NSMutableDictionary alloc] initWithDictionary:self.inputData];
        data[@"devicename"] = textField.text;
        [self.aDelegate didSubmit:data View:self];
    }
    
    if ([textField.text length]>0) {
        return true;
    }
    return false;
}
- (IBAction)clickAction:(id)sender {
    if (self.aDelegate !=nil) {
        [self.aDelegate didSubmit:self.inputData View:self];
    }else{
        NSString* action = self.inputData[@"action"];
        if([action isKindOfClass:[NSString class]]){
            if ([action isEqualToString:@"exit"]) {
                if (self.vc!=nil) {
                    [self.vc.navigationController popViewControllerAnimated:true];
                }
            }
        }
        
        if ([self.xo isKindOfClass:[MyPopupDialog class]]) {
            MyPopupDialog* dialog = (MyPopupDialog*)self.xo;
            [dialog dismissPopup];
        }
    }
}
-(void)customInit{
    self.layer.cornerRadius = 12;
    self.layer.masksToBounds = true;
    self.layer.borderWidth = 0;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self customInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self customInit];
    }
    return self;
}
@end
