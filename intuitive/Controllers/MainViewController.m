//
//  MainViewController.m
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "MainViewController.h"
#import "UIView+Animation.h"
@interface MainViewController ()
@property (nonatomic,assign) int curPage;
@property (nonatomic,strong) NSArray* image_names;
@property (nonatomic,strong) NSArray* label_names;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    //[self.bottomBar customLayout:-1];
    
    self.imgLogo.hidden = false;
    self.scrollView.hidden = true;
    self.viewContent.hidden = true;
    CGRect scRect = [[UIScreen mainScreen] bounds];
    if (scRect.size.width>=414) {
        self.lblContent.msize = 15;
        NSLog(@"font size 15 width %f",scRect.size.width);
    }else{
        self.lblContent.msize = 14;
        NSLog(@"font size 14 width %f",scRect.size.width);
    }
    
    _image_names = @[@"img_s2.jpg",@"img_s1.jpg",@"ico_logo.png"];
    _label_names = @[@"Enhance and train your intuition",@"Improve Your Decision-Making Skills",@" "];
    _curPage = 0;
    

    
//    NSTimer*timer = [NSTimer scheduledTimerWithTimeInterval:5 repeats:true block:^(NSTimer * _Nonnull timer) {
//        [self slidePage];
//    }];
}
- (IBAction)tapWWW:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.intuitivemind-ip.org/tutorial"]];
}

-(void)slidePage{
    int page = (_curPage + 1)%3;
    self.curPage = page;
}
-(void)plusPage{
    int page = (_curPage + 1)%3;
    self.curPage = page;
}
-(void)setCurPage:(int)curPage{
    _curPage = curPage;
    switch (1) {
        case 1:
            if (curPage == 0) {
//                [self.viewContent slideInFromRight:0.5 Delegate:nil Bounds:CGRectZero];
                self.viewContent.hidden = true;
                self.imgLogo.hidden = false;
            }else if(curPage == 1){
//                [self.imgLogo slideInFromRight:0.5 Delegate:nil Bounds:CGRectZero];
                self.viewContent.hidden = false;
                self.imgLogo.hidden = true;
                self.imgContent.image = [UIImage imageNamed:_image_names[curPage-1]];
                self.lblContent.text = _label_names[curPage-1];
                
            }else if(curPage == 2){
//                [self.viewContent slideInFromRight:0.5 Delegate:nil Bounds:CGRectZero];
                self.imgContent.image = [UIImage imageNamed:_image_names[curPage-1]];
                self.lblContent.text = _label_names[curPage-1];
                
            }
            break;
            
        default:
            if (!self.scrollView.hidden) {
                CGRect scRect = [UIScreen mainScreen].bounds;
                CGFloat left = curPage*scRect.size.width;
                CGPoint pt = CGPointMake(left, 0);
                [self.scrollView setContentOffset:pt];
            }
            if (!self.viewContent.hidden) {
                [self.viewContent slideInFromRight:0.5 Delegate:nil Bounds:CGRectZero];
                self.imgContent.image = [UIImage imageNamed:_image_names[curPage]];
                self.lblContent.text = _label_names[curPage];
            }
            break;
    }  
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
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
        if ([status isEqualToString:@"linked"]) {
//            [self.topBar.btnConnect setTitle:@"Disconnect" forState:UIControlStateNormal];
        }else{
//            [self.topBar.btnConnect setTitle:@"Connect" forState:UIControlStateNormal];
        }
    }
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
