//
//  BluDeviceViewController.m
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BluDeviceViewController.h"
#import "AppDelegate.h"
#import "BluTableViewCell.h"

@interface BluDeviceViewController ()
@property (nonatomic,assign) BOOL isLoading;
@property (nonatomic,assign) int loopcnt;
@end

@implementation BluDeviceViewController
- (IBAction)clickLoading:(id)sender {
    
    if ([self.imgLoading.layer animationForKey:@"SpinAnimation"] == nil) {
        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.fromValue = [NSNumber numberWithFloat:0.0f];
        animation.toValue = [NSNumber numberWithFloat: 2*M_PI];
        animation.duration = 2.0f;
        animation.repeatCount = INFINITY;
        [self.imgLoading.layer addAnimation:animation forKey:@"SpinAnimation"];
        AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        [delegate initBlu];
        [_tableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recvNoti:) name:@"blu_status_changed" object:nil];
    
    AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    UINib* nib = [UINib nibWithNibName:@"BluTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    self.tableView.backgroundColor = [UIColor clearColor];
    if ([delegate.blu_status isEqualToString:@"linked"]) {
        _viewMain.hidden = true;
        _viewMessage.hidden = false;
        
    }else{
        _viewMain.hidden = false;
        _viewMessage.hidden = true;
        self.loopcnt = 0;
        [self clickLoading:nil];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)recvNoti:(NSNotification*)noti{
    id data = noti.object;
    if (data!=nil && [data isKindOfClass:[NSDictionary class]]) {
        NSDictionary* dict = data;
        NSString*status = dict[@"status"];
        
        _viewMessage.hidden = true;
        _viewMain.hidden = false;
        if ([status isEqualToString:@"found"]) {
            [self.tableView reloadData];
             [self.imgLoading.layer removeAnimationForKey:@"SpinAnimation"];
            
        }else if ([status isEqualToString:@"not_found"]) {
            AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
            self.loopcnt = self.loopcnt + 1;
            if (self.loopcnt%delegate.arrayServices.count == 0) {
                [self.tableView reloadData];
                [self.imgLoading.layer removeAnimationForKey:@"SpinAnimation"];
            }else{
                [self.imgLoading.layer removeAnimationForKey:@"SpinAnimation"];
                delegate.blueIndex = (delegate.blueIndex+1)%delegate.arrayServices.count;
                [self clickLoading:nil];
            }
            
        }else if ([status isEqualToString:@"linked"]) {
            _viewMessage.hidden = false;
            _viewMain.hidden = true;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:true];
            });
        }
        
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    if (delegate.device == nil) {
        return 0;
    }else{
        return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BluTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    cell.deviceLabel.text = delegate.device.name;
    if ([delegate.blu_status isEqualToString:@"linked"]) {
        cell.lblStatus.text = @"Connected";
    }else{
        cell.lblStatus.text = @"";
    }
//    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
//    backView.backgroundColor = [UIColor clearColor];
//    cell.backgroundView = backView;
    cell.backgroundColor = [UIColor lightGrayColor];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    [delegate link:nil];
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
