//
//  ColoredView.m
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "ColoredView.h"
#import "CGlobal.h"

@implementation ColoredView

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
        case 10:{
            // when tab not selected
            self.backgroundColor = COLOR_RESERVED;
            
            break;
        }
        case 9:{
            self.backgroundColor = [CGlobal colorWithHexString:@"aaaaaa" Alpha:1.0f];
            // when tab selected
            break;
        }
        case 8:{
            // sign up view selected gender background color
            self.backgroundColor = [CGlobal colorWithHexString:@"1b1d1d" Alpha:1.0f];
            break;
        }
        case 7:{
            // bottom menu seperator color
            self.backgroundColor = COLOR_PRIMARY;
            break;
        }
        case 6:{
            // bottom menu back color
            self.backgroundColor = COLOR_RESERVED;
            
            break;
        }
        case 5:{
            // decision color
            self.backgroundColor = COLOR_PRIMARY;
            break;
        }
        case 4:{
            // yaxis back color
            self.backgroundColor = [CGlobal colorWithHexString:@"675939" Alpha:1.0f];
            break;
        }
        case 3:{
            // incorrect orange
            self.backgroundColor = [CGlobal colorWithHexString:@"ed7d31" Alpha:1.0f];
            break;
        }
        case 2:{
            // correct blue
            self.backgroundColor = [CGlobal colorWithHexString:@"4472c4" Alpha:1.0f];
            break;
        }
        case 1:{
            // yellow
            self.backgroundColor = [CGlobal colorWithHexString:@"febf0f" Alpha:1.0f];
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
-(void)setCornerRadious:(CGFloat)cornerRadious{
    if (cornerRadious>0) {
        self.layer.cornerRadius = cornerRadious;
        self.layer.masksToBounds = true;
    }
    _cornerRadious = cornerRadious;
}
@end
