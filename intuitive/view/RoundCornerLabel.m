//
//  RoundCornerLabel.m
//  JellyRole
//
//  Created by BoHuang on 3/23/17.
//  Copyright © 2017 mac. All rights reserved.
//

#import "RoundCornerLabel.h"
#import "CGlobal.h"

@implementation RoundCornerLabel

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
        case 1:
            // red color
            self.backgroundColor = [CGlobal colorWithHexString:@"ff0000" Alpha:1.0];
            self.textColor = [UIColor whiteColor];
            self.layer.borderColor = [UIColor whiteColor].CGColor;
            self.layer.borderWidth = 1 ;
            self.layer.masksToBounds = true;
            break;
        case 2:
            // lost red
            self.textColor = [CGlobal colorWithHexString:@"ff0000" Alpha:1.0];
            break;
        case 3:
            // win green
            self.textColor = [CGlobal colorWithHexString:@"00ff00" Alpha:1.0];
            break;
        default:
            break;
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
