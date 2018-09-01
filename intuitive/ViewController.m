//
//  ViewController.m
//  intuitive
//
//  Created by BoHuang on 4/13/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "ViewController.h"
#import "CGlobal.h"
#import "AppDelegate.h"
#import "MainViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[CGlobal showIndicator:self];
    
    self.navigationController.navigationBar.hidden = true;
}

- (IBAction)tapSkip:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    UIViewController*vc_main = [mainStoryboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    UIViewController* nextvc = nil;
    
    EnvVar* env = [CGlobal sharedId].env;
    
    if (env.lastLogin>0) {
        nextvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"TrainingSelectViewController"];
    }else{
        nextvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    }
    
    if (nextvc!=nil) {
        NSArray* newArray = @[vc_main,nextvc];
        [self.navigationController setViewControllers:newArray animated:true];
    }else{
        NSArray* newArray = @[vc_main];
        [self.navigationController setViewControllers:newArray animated:true];
    }
}
- (IBAction)tapLink:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.intuitivemind-ip.org/tutorial"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
