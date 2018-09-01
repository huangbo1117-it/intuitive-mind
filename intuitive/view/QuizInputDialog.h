//
//  QuizInputDialog.h
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionDelegate.h"

@interface QuizInputDialog : UIView
@property (weak, nonatomic) IBOutlet UITextField *txtNumber;
@property (weak, nonatomic) IBOutlet UIButton *btnOK;


@property (strong, nonatomic) id<ActionDelegate> aDelegate;

@property (strong, nonatomic) NSNumber* mode;
-(void)setStyleWithData:(NSMutableDictionary*)data Mode:(int)mode;
@end
