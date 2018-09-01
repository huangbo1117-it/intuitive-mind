//
//  QuizInputDialog.m
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "QuizInputDialog.h"

@implementation QuizInputDialog

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setStyleWithData:(NSMutableDictionary*)data Mode:(int)mode{
    _mode = [NSNumber numberWithInt:mode];
    [_txtNumber setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
}
- (IBAction)onConfirm:(id)sender {
    NSString* number = _txtNumber.text;
    if ([number length] == 0) {
        return;
    }
    
    if (_aDelegate!=nil) {
        [_aDelegate didSubmit:@{@"mode":_mode,@"number":number} View:self];
    }
}
@end
