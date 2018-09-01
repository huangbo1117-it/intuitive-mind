//
//  PromptDialog.h
//  intuitive
//
//  Created by BoHuang on 7/8/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBaseView.h"
@interface PromptDialog : MyBaseView<UITextFieldDelegate>

@property (nonatomic,weak) IBOutlet UILabel*lblTitle;
@property (nonatomic,weak) IBOutlet UIButton*btnAction;

@property (weak, nonatomic) IBOutlet UITextField *txtDeviceName;

@end
