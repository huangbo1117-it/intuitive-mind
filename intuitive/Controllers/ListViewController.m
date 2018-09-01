//
//  ListViewController.m
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "ListViewController.h"
#import "CGlobal.h"
#import "GraphTableViewCell.h"
#import "GraphViewController.h"
#import "SCNetworkReachability.h"
#import "CGlobal.h"
#import "NetworkParser.h"
#import "ScoreViewController.h"

@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) NSMutableArray* allData;

@property (assign,nonatomic) CGFloat cellHeight;
@property (assign,nonatomic) CGFloat cellHeight_big1;  // device name
@property (assign,nonatomic) int curTabIndex;

@property (strong,nonatomic) LoginResponse* resp;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.mGraph.mChart.backgroundColor = [UIColor clearColor];
    self.mGraph1.mChart.backgroundColor = [UIColor clearColor];
    self.mGraph2.mChart.backgroundColor = [UIColor clearColor];
    [self loadData];
    
//    SCNetworkReachability *reachability = [[SCNetworkReachability alloc] initWithHost:@"https://github.com"];
//    [reachability reachabilityStatus:^(SCNetworkStatus status)
//    {
//        switch (status)
//        {
//            case SCNetworkStatusReachableViaWiFi:
//            case SCNetworkStatusReachableViaCellular:{
//                
//                break;
//            }
//            case SCNetworkStatusNotReachable:
//                NSLog(@"Not Reachable");
//                break;
//        }
//    }];
}
-(void)loadData{
    EnvVar*env = [CGlobal sharedId].env;
    NSString*userid = [NSString stringWithFormat:@"%ld", env.lastLogin];
    
    NetworkParser* manager = [NetworkParser sharedManager];
    NSString*path = [COMMON_PATH1 stringByAppendingString:ACTION_GRAPH];
    NSMutableDictionary* param = [[NSMutableDictionary alloc] init];
    param[@"action"] = @"fetchall";
    param[@"tu_id"] = userid;
    
    [CGlobal showIndicator:self];
    
    [manager ontemplateGeneralRequest:param Path:path withCompletionBlock:^(NSDictionary *dict, NSError *error) {
        LoginResponse *resp = [[LoginResponse alloc] initWithDictionary:dict];
        self.resp = resp;
        self.allData = [[NSMutableArray alloc] init];
        self.cellHeight = 80.0f;
        self.cellHeight_big1 = 100.0f;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [self setContent:0 Data:resp];
            [self setContent:1 Data:resp];
            [self setContent:2 Data:resp];
            
            
            NSArray* tviews = @[self.tableView,self.tableView1,self.tableView2];
            NSArray* bviews = @[self.btnTab0,self.btnTab1,self.btnTab2];
            NSArray* graphs = @[self.mGraph,self.mGraph1,self.mGraph2];
            for (int i=0; i<tviews.count; i++) {
                UITableView* tview = tviews[i];
                UINib* nib = [UINib nibWithNibName:@"GraphTableViewCell" bundle:nil];
                [tview registerNib:nib forCellReuseIdentifier:@"cell"];
                tview.delegate = self;
                tview.dataSource = self;
                tview.separatorStyle = UITableViewCellSelectionStyleNone;
                tview.backgroundColor = [UIColor clearColor];
                tview.tag = 100+i;
                
                UIButton* btn = bviews[i];
                btn.tag = 100+i;
                
                GraphView* graph = graphs[i];
                graph.vc = self;
                [graph customLayout];
            }
            if (self.inputTabIndex!=nil) {
                [self setTabIndex:self.inputTabIndex];
            }else{
                [self setTabIndex:[NSNumber numberWithInt:0]];
            }
            
            [CGlobal stopIndicator:self];
        });
        
    } method:@"post"];
}
-(void)setContent:(int)index Data:(LoginResponse*)resp{
    NSMutableArray* arrayList;
    if (resp!=nil) {
        arrayList = [CGlobal getMyLogFiles:index Data:resp];
    }
    
    NSArray* graphs = @[self.mGraph,self.mGraph1,self.mGraph2];
    NSArray* cons = @[self.constraint_TH,self.constraint_TH1,self.constraint_TH2];
    NSArray* tviews = @[self.tableView,self.tableView1,self.tableView2];
    GraphView* graph = graphs[index];
    NSLayoutConstraint* con  = cons[index];
    UITableView* tableview = tviews[index];
    
    if (arrayList.count > 0) {
        NSMutableDictionary* data = arrayList[0];
        if ([data[@"tblGraph"] isKindOfClass:[TblGraph class]]) {
            graph.tblGraph = data[@"tblGraph"];
        }
        
//        [arrayList removeObjectAtIndex:0];
        
        CGFloat height = 0;
        for (int i=0; i<arrayList.count; i++) {
            data = arrayList[i];
            if ([data[@"tblGraph"] isKindOfClass:[TblGraph class]]) {
                TblGraph* tblGraph = data[@"tblGraph"];
                if ([tblGraph.tg_name length]>0) {
                    height = height + self.cellHeight_big1;
                }else{
                    height = height + self.cellHeight;
                }
            }
        }
        con.constant = height;
        [tableview setNeedsUpdateConstraints];
        [tableview layoutIfNeeded];
    }else{
        graph.tblGraph = nil;
    }
    
    [self.allData addObject:arrayList];
}
- (IBAction)clickTab:(UIView*)sender {
    int tag = (int)sender.tag;
    tag = tag - 100;
    [self setTabIndex:[NSNumber numberWithInt:tag]];
}

-(void)setTabIndex:(NSNumber*)param{
    int index = [param intValue];
    self.curTabIndex = index;
    NSArray* scrolls = @[self.scroll,self.scroll1,self.scroll2];
    NSArray* tviews = @[self.tableView,self.tableView1,self.tableView2];
    NSArray* tabs = @[self.viewTab,self.viewTab1,self.viewTab2];
    UITableView* tableview = tviews[index];
    
    [tableview reloadData];
    
    _scroll.hidden = true;
    _scroll1.hidden = true;
    _scroll2.hidden = true;
    
    UIScrollView* scroll = scrolls[index];
    scroll.hidden = false;
    
    for (ColoredView* tab in tabs) {
        tab.backMode = 10;
    }
    
    ColoredView* tab = tabs[index];
    tab.backMode = 9;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    int tag = (int)tableView.tag;
    NSMutableDictionary* data;
    switch (tag) {
        case 100:
        {
            NSArray* secData = self.allData[0];
            data = secData[indexPath.row];
            break;
        }
        case 101:
        {
            NSArray* secData = self.allData[1];
            data = secData[indexPath.row];
            break;
        }
            
        default:
        {
            NSArray* secData = self.allData[2];
            data = secData[indexPath.row];
            break;
        }
    }
    if ([data[@"tblGraph"] isKindOfClass:[TblGraph class]]) {
        TblGraph* tblGraph = data[@"tblGraph"];
        if ([tblGraph.tg_name length]>0) {
            return self.cellHeight_big1;
        }
    }
    return self.cellHeight;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    int tag = (int)tableView.tag;
    switch (tag) {
        case 100:
        {
            NSArray* secData = self.allData[0];
            GraphTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            NSMutableDictionary* data = secData[indexPath.row];
            cell.data = data;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = COLOR_RESERVED;
            
            MGSwipeTableCell*mcell = cell;
            [mcell setDelegate:self];
            return cell;
        }
        case 101:
        {
            NSArray* secData = self.allData[1];
            GraphTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            NSMutableDictionary* data = secData[indexPath.row];
            cell.data = data;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = COLOR_RESERVED;
            
            MGSwipeTableCell*mcell = cell;
            [mcell setDelegate:self];
            return cell;
        }
            
        default:
        {
            NSArray* secData = self.allData[2];
            GraphTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            NSMutableDictionary* data = secData[indexPath.row];
            cell.data = data;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = COLOR_RESERVED;
            
            MGSwipeTableCell*mcell = cell;
            [mcell setDelegate:self];
            return cell;
        }
    }
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int tag = (int)tableView.tag;
    switch (tag) {
        case 100:
        {
            NSMutableArray* data = self.allData[0];
            return data.count;
            break;
        }
        case 101:
        {
            NSMutableArray* data = self.allData[1];
            return data.count;
            break;
        }
        
        default:
        {
            NSMutableArray* data = self.allData[2];
            return data.count;
            break;
        }
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int tag = (int)tableView.tag;
    switch (tag) {
        case 100:
        {
            NSArray* secData = self.allData[0];
            NSMutableDictionary* data = secData[indexPath.row];
            
            if ([data[@"tblGraph"] isKindOfClass:[TblGraph class]]) {
                UIStoryboard* main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                GraphViewController* vc = (GraphViewController*) [main instantiateViewControllerWithIdentifier:@"GraphViewController"];
                vc.tblGraph = data[@"tblGraph"];
                vc.menuIndex = 202;
                vc.vc = self;
                vc.curTabIndex = 200;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController pushViewController:vc animated:true];
                });
            }
            
            break;
        }
        case 101:
        {
            NSArray* secData = self.allData[1];
            NSMutableDictionary* data = secData[indexPath.row];
            if ([data[@"tblGraph"] isKindOfClass:[TblGraph class]]) {
                UIStoryboard* main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                GraphViewController* vc = (GraphViewController*) [main instantiateViewControllerWithIdentifier:@"GraphViewController"];
                vc.tblGraph = data[@"tblGraph"];
                vc.menuIndex = 202;
                vc.vc = self;
                vc.curTabIndex = 201;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController pushViewController:vc animated:true];
                });
            }
            break;
        }
            
        default:
        {
            NSArray* secData = self.allData[2];
            NSMutableDictionary* data = secData[indexPath.row];
            if ([data[@"tblGraph"] isKindOfClass:[TblGraph class]]) {
                UIStoryboard* main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                GraphViewController* vc = (GraphViewController*) [main instantiateViewControllerWithIdentifier:@"GraphViewController"];
                vc.tblGraph = data[@"tblGraph"];
                vc.menuIndex = 202;
                vc.vc = self;
                vc.curTabIndex = 202;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController pushViewController:vc animated:true];
                });

            }
            break;
        }
    }
    
    
}
-(BOOL) swipeTableCell:(nonnull MGSwipeTableCell*) cell tappedButtonAtIndex:(NSInteger) index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion{
    if (index == 0 && [cell isKindOfClass:[GraphTableViewCell class]]) {
        //
        GraphTableViewCell*gcell = (GraphTableViewCell*)cell;
        
        NSMutableDictionary* data = gcell.data;
        [CGlobal showIndicator:self];
        if ([data[@"tblGraph"] isKindOfClass:[TblGraph class]]) {
            TblGraph* tblGraph = data[@"tblGraph"];
            NetworkParser* manager = [NetworkParser sharedManager];
            NSMutableDictionary*param = [[NSMutableDictionary alloc] init];
            param[@"action"] = @"deletebyid";
            param[@"tg_id"] = tblGraph.tg_id;
            
            NSString* path = [COMMON_PATH1 stringByAppendingString:ACTION_GRAPH];
            [manager ontemplateGeneralRequest:param Path:path withCompletionBlock:^(NSDictionary *dict, NSError *error) {
                LoginResponse*resp = [[LoginResponse alloc] initWithDictionary:dict];
                if (error == nil && resp.tblGraph.tg_id!=nil) {
                    [self deleteViewFor:resp.tblGraph];
                    
                }
                [CGlobal stopIndicator:self];
            } method:@"post"];
//            [CGlobal AlertMessage:@"sss" Title:nil];
            
            return true;
        }
        
        
    }
    return false;
}
-(void)deleteViewFor:(TblGraph*)graph{
    if (graph.tg_id!=nil) {
        for (int i=0; i<self.allData.count; i++) {
            NSMutableArray* secData = self.allData[i];
            for (int j=0; j<secData.count; j++) {
                NSMutableDictionary*data = secData[j];
                if ([data[@"tblGraph"] isKindOfClass:[TblGraph class]]) {
                    TblGraph* tblGraph = data[@"tblGraph"];
                    if ([tblGraph.tg_id isEqualToString:graph.tg_id]) {
                        [secData removeObject:data];
                        break;
                    }
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.tableView1 reloadData];
            [self.tableView2 reloadData];
        });
        
    }
}
- (IBAction)clickScore:(id)sender {
    
    UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Main2" bundle:nil];
    ScoreViewController*vc = [ms instantiateViewControllerWithIdentifier:@"ScoreViewController"];
    vc.resp = self.resp;
    [self.navigationController pushViewController:vc animated:true];
}

@end
