//
//  TextOrImageView.m
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "TextOrImageView.h"

@implementation TextOrImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setStyleWithData:(NSMutableDictionary*)data Mode:(int)mode{
    _mode = [NSNumber numberWithInt:mode];
}
- (IBAction)onText:(id)sender {
    if (_aDelegate!=nil) {
        [_aDelegate didSubmit:@{@"mode":_mode,@"number":@"text"} View:self];
    }
}
- (IBAction)onImage:(id)sender {
    if (_aDelegate!=nil) {
        [_aDelegate didSubmit:@{@"mode":_mode,@"number":@"image"} View:self];
    }
}
@end
