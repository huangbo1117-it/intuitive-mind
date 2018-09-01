//
//  GsrViewController.m
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "GsrViewController.h"
#import "CGlobal.h"
#import "QuizResult.h"
#import "GraphViewController.h"
#import "NetworkParser.h"

@interface GsrViewController ()
@property (nonatomic,strong) NSTimer*timer;
@property (nonatomic,assign) int tick;

@property (assign, nonatomic) int curPos;
@property (strong, nonatomic) NSMutableArray* quizResult;
@property (copy, nonatomic) NSString* GSR_5;
@property (copy, nonatomic) NSString* GSR_7;
@property (copy, nonatomic) NSString* GSR_10;
@property (copy, nonatomic) NSString* GSR_12;
@property (copy, nonatomic) NSString* GSR_15;
@property (assign, nonatomic) int mSeconds;

@property (assign, nonatomic) int curCount;
@property (assign, nonatomic) int clickIndex,genIndex;

@property (strong, nonatomic) NSMutableArray* historyIndex;
@property (strong, nonatomic) NSMutableArray* sessionIndex;
@end

@implementation GsrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customInit];
    [self restart];
    
//    self.bottomBar.constraint_Height.constant = 0;
//    self.bottomBar.viewLatest.backgroundColor = [UIColor clearColor];
    
}
-(void)restart{
    self.historyIndex = [[NSMutableArray alloc] init];
    self.sessionIndex = [[NSMutableArray alloc] init];
    
    self.curPos = 0;
    self.curCount = 0;
    self.quizResult = [[NSMutableArray alloc] init];
    [self handleMessage:100];
    
    if (g_fakedata) {
        self.nCount = 3;
    }
//    self.nCount = 3;
}
-(void)showRandomImages{
    switch (self.mMode) {
        case 0:{
            int n1 = 60;
            NSMutableArray* nums = [CGlobal getRandomIndex:_curPos Length:n1 allIndex:self.historyIndex TempSession:self.sessionIndex];
            
            NSString*name1 = [NSString stringWithFormat:@"scoo%@.jpg",nums[0]];
            NSString*name2 = [NSString stringWithFormat:@"scoo%@.jpg",nums[1]];
            NSString*name3 = [NSString stringWithFormat:@"scoo%@.jpg",nums[2]];
            NSString*name4 = [NSString stringWithFormat:@"scoo%@.jpg",nums[3]];
            self.img1.image = [UIImage imageNamed:name1];
            self.img2.image = [UIImage imageNamed:name2];
            self.img3.image = [UIImage imageNamed:name3];
            self.img4.image = [UIImage imageNamed:name4];
            self.curPos = self.curPos + 4;
            _curPos = _curPos%(n1);
            break;
        }
        case 1:{
            int n1 = 58;
            NSMutableArray* nums = [CGlobal getRandomIndex:_curPos Length:n1 allIndex:self.historyIndex TempSession:self.sessionIndex];
            NSString*name1 = [NSString stringWithFormat:@"fcoo%@.jpg",nums[0]];
            NSString*name2 = [NSString stringWithFormat:@"fcoo%@.jpg",nums[1]];
            NSString*name3 = [NSString stringWithFormat:@"fcoo%@.jpg",nums[2]];
            NSString*name4 = [NSString stringWithFormat:@"fcoo%@.jpg",nums[3]];
            self.img1.image = [UIImage imageNamed:name1];
            self.img2.image = [UIImage imageNamed:name2];
            self.img3.image = [UIImage imageNamed:name3];
            self.img4.image = [UIImage imageNamed:name4];
            self.curPos = self.curPos + 4;
            _curPos = _curPos%(n1);
            break;
        }
        default:{
            int n1 = 60;
            NSMutableArray* nums = [CGlobal getRandomIndex:_curPos Length:n1 allIndex:self.historyIndex TempSession:self.sessionIndex];
            NSString*name1 = [NSString stringWithFormat:@"mcoo%@.jpg",nums[0]];
            NSString*name2 = [NSString stringWithFormat:@"mcoo%@.jpg",nums[1]];
            NSString*name3 = [NSString stringWithFormat:@"mcoo%@.jpg",nums[2]];
            NSString*name4 = [NSString stringWithFormat:@"mcoo%@.jpg",nums[3]];
            self.img1.image = [UIImage imageNamed:name1];
            self.img2.image = [UIImage imageNamed:name2];
            self.img3.image = [UIImage imageNamed:name3];
            self.img4.image = [UIImage imageNamed:name4];
            self.curPos = self.curPos + 4;
            _curPos = _curPos%(n1);
            break;
        }
    }
    
    _genIndex = arc4random_uniform(100)%4;
    NSLog(@"Answer Index %d",_genIndex);
    self.mSeconds = 10;
    
    _lblSeconds.text = @"10";
    _lblSeconds.hidden = false;
    _btn1.enabled = false;
    _btn2.enabled = false;
    _btn3.enabled = false;
    _btn4.enabled = false;
    if (_timer!=nil) {
        [_timer invalidate];
    }
    self.tick = 0;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runnable1:) userInfo:nil repeats:true];
}
-(void)runnable1:(id)sender{
    self.tick = self.tick + 1;
    _lblSeconds.text = [NSString stringWithFormat:@"%d",self.mSeconds-self.tick];
    if (self.tick>=self.mSeconds) {
        
        self.lblSeconds.hidden = true;
        self.btn1.enabled = true;
        self.btn2.enabled = true;
        self.btn3.enabled = true;
        self.btn4.enabled = true;
        [self.timer invalidate];
        self.timer = nil;
    }else{
        switch (_tick) {
            case 5:
            {
                self.GSR_5 = g_gsr;
                break;
            }
            case 7:
            {
                self.GSR_7 = g_gsr;
                break;
            }
            default:
                break;
        }
    }
}
-(void)customInit{
    // Do any additional setup after loading the view.
    [self.btn1 addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn2 addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn3 addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn4 addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    self.btn1.tag = 201;
    self.btn2.tag = 202;
    self.btn3.tag = 203;
    self.btn4.tag = 204;
    
    self.quizResult = [[NSMutableArray alloc] init];
    
    
    self.layResult.hidden = true;
    self.layMain.hidden = false;
}
-(void)showGeneratedImage{
    switch (_genIndex) {
        case 0:
        {
            self.imgResult.image = self.img1.image;
            break;
        }
        case 1:
        {
            self.imgResult.image = self.img2.image;
            break;
        }
        case 2:
        {
            self.imgResult.image = self.img3.image;
            break;
        }
        case 3:
        {
            self.imgResult.image = self.img4.image;
            break;
        }
        default:
            break;
    }
    self.layMain.hidden = true;
    _layResult.hidden = false;
    self.mSeconds = 8;
    if (_timer !=nil) {
        [_timer invalidate];
    }
    self.tick = 0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runnable2:) userInfo:nil repeats:true];
}
-(void)runnable2:(id)sender{
    self.tick = self.tick + 1;
    if (self.tick>=self.mSeconds) {
        [self.timer invalidate];
        self.timer = nil;
        [self handleMessage:300];
        
    }else{
        switch (self.tick) {
            case 2:
            {
                self.GSR_12 = g_gsr;
                break;
            }
            case 5:{
                self.GSR_15 = g_gsr;
                break;
            }
            default:
                break;
        }
    }
}
-(void)logValues{
    if (self.quizResult == nil) {
        self.quizResult = [[NSMutableArray alloc] init];
    }
    QuizResult* quizModel = [[QuizResult alloc] init];
    quizModel.selectedPos = _clickIndex;
    quizModel.RandomPos = _genIndex;
    quizModel.GSR5 = self.GSR_5;
    quizModel.GSR7 = self.GSR_7;
    quizModel.GSR10 = self.GSR_10;
    quizModel.GSR12 = self.GSR_12;
    quizModel.GSR15 = self.GSR_15;
    [CGlobal checkQuizResult:quizModel];
    
    [quizModel genResult];
    
    [self.quizResult addObject:quizModel];
}
-(void)saveQuiz{
    TblGraph*graph = [CGlobal getTblGraphFromQuizModel:self.quizResult DicResult:nil];
    EnvVar* env = [CGlobal sharedId].env;
    NSString*userid = [NSString stringWithFormat:@"%ld",env.lastLogin];
    if (graph!=nil) {
        NetworkParser* manager = [NetworkParser sharedManager];
        NSString*path = [COMMON_PATH1 stringByAppendingString:ACTION_GRAPH];
        NSMutableDictionary*param = [BaseModel getQuestionDict:graph];
        param[@"action"] = @"insert";
        param[@"tu_id"] = userid;
        
        [CGlobal showIndicator:self];
        [manager ontemplateGeneralRequest:param Path:path withCompletionBlock:^(NSDictionary *dict, NSError *error) {
            LoginResponse* resp = [[LoginResponse alloc] initWithDictionary:dict];
            if (resp.tblGraph!=nil) {
                int lastNum = [CGlobal getLastFileNumber] ;
//                NSString* filename = [CGlobal getFileName:lastNum Mode:0];
                
                UIStoryboard* main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                GraphViewController* vc = (GraphViewController*) [main instantiateViewControllerWithIdentifier:@"GraphViewController"];
                vc.tblGraph = resp.tblGraph;
                vc.menuIndex = 201;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController pushViewController:vc animated:true];
                });
                [CGlobal stopIndicator:self];
                return;
            }
//            [CGlobal AlertMessage:@"Fail" Title:nil Vc:self];
            [CGlobal stopIndicator:self];
        } method:@"post"];
    }
}
-(void)clickView:(UIView*)sender{
    int tag = (int)sender.tag;
    switch (tag) {
        case 201:
        {
            self.GSR_10 = g_gsr;
            self.clickIndex = 0;
            [self handleMessage:200];
            break;
        }
        case 202:
        {
            self.GSR_10 = g_gsr;
            self.clickIndex = 1;
            [self handleMessage:200];
            break;
        }
        case 203:
        {
            self.GSR_10 = g_gsr;
            self.clickIndex = 2;
            [self handleMessage:200];
            break;
        }
        case 204:
        {
            self.GSR_10 = g_gsr;
            self.clickIndex = 3;
            [self handleMessage:200];
            break;
        }
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)handleMessage:(int)what{
    switch (what) {
        case 100:
        {
            [self showRandomImages];
            break;
        }
        case 200:
        {
            [self showGeneratedImage];
            break;
        }
        case 300:{
            self.layMain.hidden = false;
            self.layResult.hidden = true;
            self.curCount = self.curCount + 1;
            NSLog(@"%d",self.curCount);
            [self logValues];
            if (self.curCount >= _nCount) {
                if (_quizResult.count>1) {
                    [_quizResult removeObjectAtIndex:0];
                }
                
                [self saveQuiz];
                
                
            }else{
                [self showRandomImages];
            }
            break;
        }
        case 400:{
            break;
        }
        default:
            break;
    }
}
- (IBAction)tapExit:(id)sender {
    [BottomView clickMenu:-1 Vc:self];
}


@end
