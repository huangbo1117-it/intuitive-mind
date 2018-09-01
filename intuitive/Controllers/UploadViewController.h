//
//  UploadViewController.h
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "MenuViewController.h"
#import "TopBarView.h"
#import "BottomView.h"
#import "ColoredView.h"
#import "ColoredButton.h"
#import "KeyBoxView.h"
#import "MyPopupDialog.h"

@interface UploadViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,ViewDialogDelegate>

@property (weak, nonatomic) IBOutlet ColoredLabel *lblLastTick;
@property (weak, nonatomic) IBOutlet KeyBoxView *keyBoxView;


@property (weak, nonatomic) IBOutlet UIView *viewStartHolder;

@property (weak, nonatomic) IBOutlet UIButton *btnType1;
@property (weak, nonatomic) IBOutlet UIButton *btnType2;
@property (weak, nonatomic) IBOutlet UIButton *btnType3;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;

@property (weak, nonatomic) IBOutlet UITextField *txt1;
@property (weak, nonatomic) IBOutlet UITextField *txt2;
@property (weak, nonatomic) IBOutlet UITextField *txt3;
@property (weak, nonatomic) IBOutlet UITextField *txt4;

@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIImageView *img4;

@property (weak, nonatomic) IBOutlet UIImageView *imgCenter;

@property (weak, nonatomic) IBOutlet UILabel* lblSeconds;

@property (weak, nonatomic) IBOutlet UIImageView *imgUpload1;
@property (weak, nonatomic) IBOutlet UIImageView *imgUpload2;
@property (weak, nonatomic) IBOutlet UIImageView *imgUpload3;
@property (weak, nonatomic) IBOutlet UIImageView *imgUpload4;
@property (weak, nonatomic) IBOutlet UIButton *btnUpload1;
@property (weak, nonatomic) IBOutlet UIButton *btnUpload2;
@property (weak, nonatomic) IBOutlet UIButton *btnUpload3;
@property (weak, nonatomic) IBOutlet UIButton *btnUpload4;
@property (weak, nonatomic) IBOutlet ColoredButton* btnOK;
@property (weak, nonatomic) IBOutlet ColoredView *viewQuiz;
@property (weak, nonatomic) IBOutlet ColoredView *viewDecision;

@property (weak, nonatomic) IBOutlet UIView *viewLay1;
@property (weak, nonatomic) IBOutlet UIView *viewLay2;
@property (weak, nonatomic) IBOutlet UIView *viewLay3;
@property (weak, nonatomic) IBOutlet UIView *viewLay4;
@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UILabel *lbl2;
@property (weak, nonatomic) IBOutlet UILabel *lbl3;
@property (weak, nonatomic) IBOutlet UILabel *lbl4;

@property (weak, nonatomic) IBOutlet UIStackView *stackTypeSelect;
@property (weak, nonatomic) IBOutlet UIImageView* imgResult;

@property (weak, nonatomic) IBOutlet UIButton *btnExit;
@property (weak, nonatomic) IBOutlet UIStackView *stackBottomMenu;
@end
