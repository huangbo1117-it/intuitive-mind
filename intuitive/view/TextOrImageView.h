//
//  TextOrImageView.h
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionDelegate.h"

@interface TextOrImageView : UIView
@property (weak, nonatomic) IBOutlet UIButton *btnText;
@property (weak, nonatomic) IBOutlet UIButton *btnImage;

@property (strong, nonatomic) id<ActionDelegate> aDelegate;

@property (strong, nonatomic) NSNumber* mode;
-(void)setStyleWithData:(NSMutableDictionary*)data Mode:(int)mode;

@end
