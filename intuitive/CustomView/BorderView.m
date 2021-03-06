//
//  BorderView.m
//  JellyRole
//
//  Created by BoHuang on 3/23/17.
//  Copyright © 2017 mac. All rights reserved.
//

#import "BorderView.h"
#import "CGlobal.h"
@implementation BorderView

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
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        //[self customInit];
    }
    return self;
}
-(void)setBackMode:(NSInteger)backMode{
    switch (backMode) {
        case 3:{
            // yellow border for image view
            self.layer.borderColor = COLOR_PRIMARY.CGColor;
            self.backgroundColor = [UIColor clearColor];
            break;
        }
        case 2:{
            // black border
            self.layer.borderColor = [UIColor blackColor].CGColor;
            self.backgroundColor = [UIColor clearColor];
            break;
        }
        case 1:{
            // white border
            self.layer.borderColor = [UIColor whiteColor].CGColor;
            self.backgroundColor = [UIColor clearColor];
            break;
        }
        default:
        {
            self.backgroundColor = [UIColor clearColor];
            break;
        }
    }
    _backMode = backMode;
}
-(void)setBorderWidth:(CGFloat)borderWidth{
    if (borderWidth>0) {
        self.layer.borderWidth = borderWidth;
        self.layer.masksToBounds = true;
    }
}
-(void)setCornerRadious:(CGFloat)cornerRadious{
    if (cornerRadious>0) {
        self.layer.cornerRadius = cornerRadious;
        self.layer.masksToBounds = true;
    }
    _cornerRadious = cornerRadious;
}
@end
