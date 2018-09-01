//
//  ColoredLabel.m
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "ColoredLabel.h"
#import "CGlobal.h"

@implementation ColoredLabel

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
        case 2:{
            // yellow button
            self.textColor = [CGlobal colorWithHexString:@"fcbd10" Alpha:1.0];
            break;
        }
        case 1:{
            // forgot password
            self.textColor = [UIColor lightGrayColor];
            break;
        }
        default:
        {
            
            break;
        }
    }
    _backMode = backMode;
}
-(void)setCornerRadious:(CGFloat)cornerRadious{
    if (cornerRadious>0) {
        self.layer.cornerRadius = cornerRadious;
        self.layer.masksToBounds = true;
    }
    _cornerRadious = cornerRadious;
}
-(void)setMsize:(CGFloat)msize{
    if (msize > 0) {
        //        UIFont* font = [UIFont boldSystemFontOfSize:msize];
        //        self.font = font;
        UIFont* font = [UIFont fontWithName:@"GoodTimesRg-Regular" size:msize];
        self.font = font;
    }
}
@end
