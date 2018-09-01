//
//  TrainingSelectViewController.h
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "MenuViewController.h"
#import "ActionDelegate.h"


@interface TrainingSelectViewController : MenuViewController<ActionDelegate>


@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIPickerView *pkNumber;

@property (weak, nonatomic) IBOutlet UIStackView *stack1;
@property (weak, nonatomic) IBOutlet UIStackView *stack2;
@end
