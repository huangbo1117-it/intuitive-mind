//
//  MyTextFieldDelegate.h
//  intuitive
//
//  Created by BoHuang on 6/5/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

enum FIELD_TYPE  {FIELD_TYPE_NORMAL,FIELD_TYPE_PASSWORD};
@interface MyTextFieldDelegate : NSObject<UITextFieldDelegate>

@property (nonatomic,strong) UIViewController*vc;
@property (nonatomic,strong) UIView* view;
@property (strong,nonatomic) NSNumber* field_type;

@end
