//
//  TrainingSelectViewController.m
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "TrainingSelectViewController.h"
#import "QuizInputDialog.h"
#import "MyPopupDialog.h"
#import "UIView+Property.h"
#import "GsrViewController.h"

@interface TrainingSelectViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong) MyPopupDialog* dialog;

@property(nonatomic,strong) NSMutableArray* numbers;
@property(nonatomic,assign) int selection;
@end

@implementation TrainingSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_btn1 addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [_btn2 addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [_btn3 addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    _btn1.tag = 201;
    _btn2.tag = 202;
    _btn3.tag = 203;
    
    self.stack1.hidden = false;
    self.stack2.hidden = true;
    
    self.numbers = [[NSMutableArray alloc] init];
    for (int i=8; i<31; i++) {
        NSString* number = [NSString stringWithFormat:@"%d",i];
        [self.numbers addObject:number];
    }
    self.pkNumber.delegate = self;
    self.pkNumber.dataSource = self;
    [self.pkNumber selectRow:1 inComponent:0 animated:false];
    
}
- (IBAction)clickStart:(id)sender {
    int selrow = (int)[self.pkNumber selectedRowInComponent:0];
    int number = [self.numbers[selrow] intValue];
    UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GsrViewController* vc = [ms instantiateViewControllerWithIdentifier:@"GsrViewController"];
    vc.nCount = number;
    vc.mMode = self.selection;
    dispatch_async(dispatch_get_main_queue(), ^{
        UINavigationController* navc = self.navigationController;
        [self.navigationController pushViewController:vc animated:true];
    });
}

-(void)clickView:(UIView*)sender{
    int tag = (int)sender.tag;
    switch (tag) {
        case 201:
        {
            self.selection = 0;
            break;
        }
        case 202:
        {
            self.selection = 1;
            break;
        }
        case 203:
        {
            self.selection = 2;
            break;
        }
        default:
            break;
    }
    self.stack2.hidden = false;
    self.stack1.hidden = true;
//    QuizInputDialog * quiz = (QuizInputDialog*)[[NSBundle mainBundle] loadNibNamed:@"QuizInputDialog" owner:self options:nil][0];
//    [quiz setStyleWithData:nil Mode:1];
//    MyPopupDialog* dialog = [[MyPopupDialog alloc] init];
//    [dialog setup:quiz Mode:1];
//    quiz.aDelegate = self;
//    [dialog showPopup:self.view];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)didSubmit:(id)obj View:(UIView *)view{
    // obj
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary*dic = (NSDictionary*)obj;
        if(dic[@"number"]!=nil){
            int number = [dic[@"number"] intValue];
            UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            GsrViewController* vc = [ms instantiateViewControllerWithIdentifier:@"GsrViewController"];
            vc.nCount = number;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController pushViewController:vc animated:true];
            });
        }
    }
    if (view.xo!=nil) {
        [view.xo removeFromSuperview];
    }
}
-(void)didCancel:(UIView *)view{
    if (view.xo!=nil) {
        [view.xo removeFromSuperview];
    }
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.numbers.count;
    
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.numbers[row];
}
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = self.numbers[row];
    NSAttributedString *attString =
    [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    return attString;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
