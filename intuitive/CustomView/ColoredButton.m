//
//  ColoredButton.m
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "ColoredButton.h"
#import "CGlobal.h"
@implementation ColoredButton

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
            // yellow button
//            self.backgroundColor = COLOR_PRIMARY;
            break;
        }
        case 2:{
            self.backgroundColor = [CGlobal colorWithHexString:@"1d1d1d" Alpha:1.0f];
            break;
        }
        case 1:{
            // connect button password
            self.backgroundColor = [CGlobal colorWithHexString:@"5f5f5f" Alpha:1.0f];
            
            break;
        }
        default:
        {
//            self.backgroundColor = [CGlobal colorWithHexString:@"ffffff" Alpha:1.0f];
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
        self.titleLabel.font = font;
    }
}
@end
