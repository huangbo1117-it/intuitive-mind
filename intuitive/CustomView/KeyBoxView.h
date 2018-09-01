//
//  KeyBoxView.h
//  intuitive
//
//  Created by BoHuang on 6/1/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyBoxView : UIView
@property (weak, nonatomic) IBOutlet UIButton *btnCamera;
@property (weak, nonatomic) IBOutlet UIButton *btnGallery;

@property (weak, nonatomic) IBOutlet UITextField *txtField;
@property (weak, nonatomic) IBOutlet UIImageView *imgCamera;
@property (weak, nonatomic) IBOutlet UIImageView *imgPicture;

-(void) firstProcess;
@end
