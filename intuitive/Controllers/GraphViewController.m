//
//  GraphViewController.m
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "GraphViewController.h"

@interface GraphViewController ()

@end

@implementation GraphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewTabHolder.hidden = false;
    
    self.btnTab0.tag = 100;
    self.btnTab1.tag = 101;
    self.btnTab2.tag = 102;
    
    [self.btnTab0 addTarget:self action:@selector(clickTab:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnTab1 addTarget:self action:@selector(clickTab:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnTab2 addTarget:self action:@selector(clickTab:) forControlEvents:UIControlEventTouchUpInside];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        _mGraph.tblGraph = self.tblGraph;
        _mGraph.vc = self;
        [_mGraph customLayout];
    });
    
}
- (IBAction)clickTab:(UIView*)sender {
    int tag = (int)sender.tag;
    tag = tag - 100;
    if ([self.vc isKindOfClass:[ListViewController class]]) {
        [self.vc performSelector:@selector(setTabIndex:) withObject:[NSNumber numberWithInt:tag]];
        [self.navigationController popViewControllerAnimated:true];
    }else{
        NSMutableDictionary*dic = [[NSMutableDictionary alloc] init];
        dic[@"vc"] = self;
        dic[@"index"] = [NSNumber numberWithInt:3];
        dic[@"tabIndex"] = [NSNumber numberWithInt:tag];
        [BottomBarView clickMenu:dic];
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setTabIndex:(int)index{
    
    NSArray* tabs = @[self.viewTab,self.viewTab1,self.viewTab2];
        
    for (ColoredView* tab in tabs) {
        tab.backMode = 10;
    }
    
    ColoredView* tab = tabs[index];
    tab.backMode = 9;
    
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
