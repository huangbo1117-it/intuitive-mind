//
//  FontTextField.m
//  intuitive
//
//  Created by BoHuang on 5/29/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "FontTextField.h"

@implementation FontTextField

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
            case 1:{
                // bottom banner label
                
                break;
            }
        default:
        {
            [self setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
            break;
        }
    }
    _backMode = backMode;
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
