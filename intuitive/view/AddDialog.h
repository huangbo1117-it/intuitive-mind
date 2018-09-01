//
//  AddDialog.h
//  JellyRole
//
//  Created by BoHuang on 3/25/17.
//  Copyright © 2017 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionDelegate.h"

@interface AddDialog : UIView
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtConfirm;

@property (strong, nonatomic) id<ActionDelegate> aDelegate;

@property (strong, nonatomic) NSNumber* mode;
-(void)setStyleWithData:(NSMutableDictionary*)data Mode:(int)mode;
@end
