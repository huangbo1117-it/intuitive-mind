//
//  TopBarView.m
//  intuitive
//
//  Created by BoHuang on 4/13/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "TopBarView.h"
#import "CGlobal.h"
#import "AppDelegate.h"

@implementation TopBarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"TopBarView initWithFrame");
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"TopBarView initWithCoder");
    }
    return self;
}
-(void)customLayout{
    if (_constraint_Height!=nil) {
        _constraint_Height.constant = 128;
    }
    
    if (_label!=nil) {
        _label.hidden = true;
    }
}
-(void)setCaption:(NSString*)caption{
    if (_label!=nil) {
        _label.text = caption;
        _label.hidden = false;
    }
}
- (IBAction)logout:(id)sender {
    EnvVar* env = [CGlobal sharedId].env;
    [env logOut];
    AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate defaultLogin];
}
- (IBAction)toggleConnect:(id)sender {
    AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSString* title = self.btnConnect.titleLabel.text;
    if ([title isEqualToString:@"Disconnect"]) {
        [delegate unlink:nil];
    }else if([title isEqualToString:@"Connect"]){
        [delegate link:nil];
    }
}
@end
