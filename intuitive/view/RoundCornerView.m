//
//  RoundCornerView.m
//  JellyRole
//
//  Created by BoHuang on 3/22/17.
//  Copyright © 2017 mac. All rights reserved.
//

#import "RoundCornerView.h"
#import "CGlobal.h"
@implementation RoundCornerView

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
        [self customInit];
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


- (void)drawRect:(CGRect)rect {
    [self customInit];
}

- (void)setNeedsLayout {
    [super setNeedsLayout];
    [self setNeedsDisplay];
}


- (void)prepareForInterfaceBuilder {
    
    [self customInit];
}

- (void)customInit {
    
    if (self.cornerRadious > 0) {
        self.layer.cornerRadius = self.cornerRadious;
        self.layer.masksToBounds = YES;
    }
    
}
-(void)setBackMode:(NSInteger)backMode{
    switch (backMode) {
        case 3:{
            // white shadow border with
            [self.layer setBorderColor:[UIColor whiteColor].CGColor];
            [self.layer setBorderWidth:1.5f];
            [self.layer setCornerRadius:10.0f];
            self.layer.backgroundColor = [UIColor blackColor].CGColor;
            CALayer *layer = self.layer;
            layer.shadowOpacity = 1;
            layer.shadowColor = [[UIColor whiteColor] CGColor];
            layer.shadowOffset = CGSizeMake(0,0);
            layer.shadowRadius = 6;
            break;
        }
        case 2:
        {
            self.layer.borderColor = [UIColor whiteColor].CGColor;
            self.backgroundColor = [UIColor clearColor];
            self.layer.borderWidth = 1;
            self.layer.masksToBounds = true;
            
            break;
        }
        case 1:
        {
            // facebook color
            self.backgroundColor = [CGlobal colorWithHexString:@"2e4688" Alpha:1.0];
            break;
        }
        default:
            break;
    }
    _backMode = backMode;
}
@end
