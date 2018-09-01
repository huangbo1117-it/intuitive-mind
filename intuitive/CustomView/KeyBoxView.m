//
//  KeyBoxView.m
//  intuitive
//
//  Created by BoHuang on 6/1/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "KeyBoxView.h"
#import "CGlobal.h"


@implementation KeyBoxView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void) firstProcess{
    _imgCamera.image = [CGlobal getColoredImageFromImage:_imgCamera.image Color:[UIColor blackColor]];
    _imgPicture.image = [CGlobal getColoredImageFromImage:_imgPicture.image Color:[UIColor blackColor]];
    
    [self.txtField setReturnKeyType:UIReturnKeyDone];
}
@end
