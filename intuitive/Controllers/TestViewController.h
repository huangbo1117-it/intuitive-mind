//
//  TestViewController.h
//  intuitive
//
//  Created by BoHuang on 6/1/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyBoxView.h"

@interface TestViewController : UIViewController
@property (weak, nonatomic) IBOutlet KeyBoxView *keyBoxView;
@property (weak, nonatomic) IBOutlet UITextField *innerText;
@property (weak, nonatomic) IBOutlet UITextField *txtField1;

@property (strong, nonatomic) IBOutlet UITextField *txtField;
@end
