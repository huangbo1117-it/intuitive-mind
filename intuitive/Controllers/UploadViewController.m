//
//  UploadViewController.m
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "UploadViewController.h"
#import "CGlobal.h"
#import "QuizResult.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "GraphViewController.h"
#import "KeyBoxView.h"
#import "NetworkParser.h"
#import "MyPopupDialog.h"
#import "PromptDialog.h"
#import "UIView+Property.h"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface UploadViewController ()

@property (assign, nonatomic) int mSeconds;

@property (nonatomic,strong) NSTimer*timer;
@property (nonatomic,assign) int tick;

@property (nonatomic,assign) BOOL passUpload;
@property (assign, nonatomic) int nCount,mMode,curCount;
@property (assign, nonatomic) int clickIndex,genIndex;
@property (assign, nonatomic) int number,curPos;

@property (assign, nonatomic) int boxsize;
@property (assign, nonatomic) int limitcnt;

@property (assign, nonatomic) int prevIndex;
//@property (assign, nonatomic) int totalChoice;

@property (strong, nonatomic) NSMutableArray* quizResult;
@property (strong, nonatomic) NSMutableArray* dicsResult;

@property (strong, nonatomic) NSMutableArray* views_lbl;
@property (strong, nonatomic) NSMutableArray* views_image;
@property (strong, nonatomic) NSMutableArray* views_btn;
@property (strong, nonatomic) NSMutableArray* views_lay;
@property (strong, nonatomic) NSMutableArray* views_txt;

@property (copy, nonatomic) NSString* GSR_5;
@property (copy, nonatomic) NSString* GSR_7;
@property (copy, nonatomic) NSString* GSR_10;
@property (copy, nonatomic) NSString* GSR_12;
@property (copy, nonatomic) NSString* GSR_15;

@property (copy, nonatomic) NSString* devicename;

@property (strong, nonatomic) UIImage* selectedImage;
@property (strong, nonatomic) NSMutableArray* historyIndex;
@property (strong, nonatomic) NSMutableArray* sessionIndex;
@property (nonatomic,strong) UITextField* tempField;


@end

@implementation UploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDefault];
    [self customInit];
    
    self.historyIndex = [[NSMutableArray alloc] init];
    self.sessionIndex = [[NSMutableArray alloc] init];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        MyPopupDialog* dialog = [[MyPopupDialog alloc] init];
        PromptDialog* view = [[NSBundle mainBundle] loadNibNamed:@"PromptDialog" owner:self options:nil][1];
        [view setData:@{@"vc":self,@"title":@"Decision Name",@"action":@"inputtext",@"aDelegate":self,@"sender":view}];
        [dialog setup:view backgroundDismiss:false backgroundColor:[UIColor darkGrayColor]];
        view.txtDeviceName.placeholder = @"Enter Decision Name";
        
        CGPoint pt = CGPointMake(self.view.center.x, (self.view.frame.size.height - 258)/2);
        dialog.contentview.center = pt;
        [dialog showPopup:self.view];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [view.txtDeviceName becomeFirstResponder];
        });
    });
}
-(BOOL)didSubmit:(NSDictionary *)data View:(id)view{
    if ([view isKindOfClass:[PromptDialog class]]) {
        NSString* devicename = data[@"devicename"];
        if(devicename!=nil && [devicename length]>0){
            UIView* uuview = view;
            if ([uuview.xo isKindOfClass:[MyPopupDialog class]]) {
                MyPopupDialog* dg = (MyPopupDialog*)uuview.xo;
                [dg dismissPopup];
            }
            NSLog(@"%@",devicename);
            
            self.devicename = devicename;
            
//            UIView* sender = data[@"sender"];
//            int tag = (int)sender.tag-200;
//            [self handleMessage:400 Data:nil];
        }
    }
    return false;
}
-(void)initDefault{
    self.passUpload = false;
    self.boxsize = 4;
    self.limitcnt = self.boxsize;
    
    self.prevIndex = 0;
//    self.totalChoice = 0;
    
    self.views_lbl = [[NSMutableArray alloc] init];
    self.views_image = [[NSMutableArray alloc] init];
    self.views_btn = [[NSMutableArray alloc] init];
    self.views_lay = [[NSMutableArray alloc] init];
    self.views_txt = [[NSMutableArray alloc] init];
    
    NSArray* temp1 = @[_lbl1,_lbl2,_lbl3,_lbl4];
    self.views_lbl = [[NSMutableArray alloc] initWithArray:temp1];
    
    temp1 = @[_btnUpload1,_btnUpload2,_btnUpload3,_btnUpload4];
    self.views_btn = [[NSMutableArray alloc] initWithArray:temp1];
    
    temp1 = @[_imgUpload1,_imgUpload2,_imgUpload3,_imgUpload4];
    self.views_image = [[NSMutableArray alloc] initWithArray:temp1];
    
    temp1 = @[_viewLay1,_viewLay2,_viewLay3,_viewLay4];
    self.views_lay = [[NSMutableArray alloc] initWithArray:temp1];
    
    temp1 = @[_txt1,_txt2,_txt3,_txt4];
    self.views_txt = [[NSMutableArray alloc] initWithArray:temp1];
    
    self.quizResult = [[NSMutableArray alloc] init];
    self.dicsResult = [[NSMutableArray alloc] init];
    
    [self.btnType1 addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnType2 addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnType3 addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnType1.tag = 400;
    self.btnType2.tag = 401;
    self.btnType3.tag = 402;
    
}
-(void)clickView_Decision:(UIView*)view{
    if (self.passUpload) {
        self.GSR_10 = g_gsr;
        
        [self handleMessage:400 Data:nil];
    }
}
-(void)clickView_Add:(UIView*)view{
    int tag = (int)view.tag-200;
    if (tag < self.boxsize) {
        UITextField*txt = _views_txt[tag];
        txt.inputAccessoryView = self.keyBoxView;
        self.prevIndex =  tag;
        _selectedImage = nil;
        
        
        [self.keyBoxView.txtField setReturnKeyType:UIReturnKeyDone];
        
        [txt becomeFirstResponder];
        [self.keyBoxView.txtField becomeFirstResponder];
        
        
        
        self.keyBoxView.txtField.text = @"";
        
//        self.prevIndex =  tag;
//        _selectedImage = nil;
//        self.imgInput.image = nil;
//        
//        [self.keyBoxView.txtField setReturnKeyType:UIReturnKeyDone];
//        
//        [_tempField becomeFirstResponder];
//        [self.keyBoxView.txtField becomeFirstResponder];
//        
//        self.imgInput.hidden = false;
//        self.imgResult.hidden = true;
//        _viewQuiz.hidden = true;
//        _viewDecision.hidden = true;
//        _stackTypeSelect.hidden = true;
//        
//        self.keyBoxView.txtField.text = @"";
        
    }
}
-(void)clickView_Quiz:(UIView*)view{
    self.GSR_10 = g_gsr;
    int tag = (int)view.tag - 200;
    self.clickIndex = tag;
    [self handleMessage:200 Data:nil];
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
    self.lblSeconds.text = @"10";
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
    self.lblSeconds.text = [NSString stringWithFormat:@"%d",self.mSeconds - self.tick];
    if (self.tick>=self.mSeconds) {
        self.lblSeconds.text = @"";
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
    
    
    
    [self.btnUpload1 addTarget:self action:@selector(clickView_Add:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnUpload2 addTarget:self action:@selector(clickView_Add:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnUpload3 addTarget:self action:@selector(clickView_Add:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnUpload4 addTarget:self action:@selector(clickView_Add:) forControlEvents:UIControlEventTouchUpInside];
    self.btnUpload1.tag = 200;
    self.btnUpload2.tag = 201;
    self.btnUpload3.tag = 202;
    self.btnUpload4.tag = 203;
    
    self.imgResult.hidden = true;
    _viewQuiz.hidden = true;
    _viewDecision.hidden = false;
    _stackTypeSelect.hidden = true;
    
    [_btnOK addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    _btnOK.tag = 300;
    
    for (int i=0; i<_views_lbl.count; i++) {
        UILabel*textview = self.views_lbl[i];
        UITextField*txt = self.views_txt[i];
        textview.hidden = false;
        if (i>0) {
            textview.text = @"";
//            txt.text = @"";
        }
        
    }
    for (int i=0; i<_views_image.count; i++) {
        UIImageView*imageView = self.views_image[i];
        imageView.hidden = false;
        imageView.image = nil;
    }
    
    [_btn1 addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [_btn2 addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [_btn3 addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    _btn1.tag = 401;
    _btn2.tag = 402;
    _btn3.tag = 403;
    
//    _tempField = [UITextField new];
//    [self.view addSubview:_tempField];
//    _tempField.inputAccessoryView = self.keyBoxView;\
    
    _txt1.inputAccessoryView = self.keyBoxView;
    
    _tempField = [UITextField new];
    [self.view addSubview:_tempField];
    _tempField.inputAccessoryView = self.keyBoxView;
    //    _tempField.delegate = self;
    //    [_tempField addTarget:self action:@selector(tempFieldChanged:) forControlEvents:UIControlEventTouchUpInside];
//    [self.keyBoxView.txtField addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [self.keyBoxView.txtField addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.keyBoxView firstProcess];
     
    
    self.lblLastTick.hidden = true;
    
    [self.btnOK setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.btnOK.enabled = false;
}

-(void)goText:(int)number View:(UIView*)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Decision" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.keyboardType = UIKeyboardTypeDefault;
    }];
    UIAlertAction* action1 = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField* field1 = alert.textFields[0];
        if ([field1.text length]>0) {
            [self doneInput:field1.text Number:number];
        }
        
    }];
    
    [alert addAction:action1];
    UIPopoverPresentationController* popPresenter =  alert.popoverPresentationController;
    popPresenter.sourceView = self.view;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:true completion:nil];
    });
    
    
}
-(void)goImage:(UIImage*)image{
    [self doneInput:image Number:self.prevIndex];
}
-(void)doneInput:(id)object Number:(int)number{
    UILabel* textView = _views_lbl[number];
    UIImageView* imageView = _views_image[number];
    UIButton* btnView = _views_btn[number];
    if ([object isKindOfClass:[NSString class]]) {
        NSString* data = object;
        textView.text = data;
        
        textView.hidden = false;
        imageView.hidden = true;
        
        [btnView addTarget:self action:@selector(clickView_Decision:) forControlEvents:UIControlEventTouchDown];
        [btnView setTitle:@"" forState:UIControlStateNormal];
        btnView.titleLabel.text = @"";
    }else if([object isKindOfClass:[UIImage class]]){
        UIImage*data = object;
        imageView.image = data;
        textView.hidden = true;
        imageView.hidden = false;
        [btnView addTarget:self action:@selector(clickView_Decision:) forControlEvents:UIControlEventTouchDown];
        [btnView setTitle:@"" forState:UIControlStateNormal];
        btnView.titleLabel.text = @"";
    }
    
    
    int cnt = 0;
    for (int i=0; i<_limitcnt; i++) {
        btnView = _views_btn[i];
        NSString* txt = btnView.titleLabel.text;
        if ([txt length] > 0) {
            // non input
            
        }else{
            // input things
            cnt++;
        }
        
    }
    if (cnt>=2) {
        
        [self.btnOK setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.btnOK.enabled = true;
        
    }
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
    self.viewQuiz.hidden = true;
    self.imgResult.hidden = false;
    self.viewDecision.hidden = true;
    
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
        [self handleMessage:300 Data:nil];
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
-(void)logDecision{
    QuizResult* quizModel = [[QuizResult alloc] init];
    quizModel.selectedPos = _clickIndex;
    quizModel.RandomPos = _genIndex;
    quizModel.GSR5 = self.GSR_5;
    quizModel.GSR7 = self.GSR_7;
    quizModel.GSR10 = self.GSR_10;
    quizModel.GSR12 = self.GSR_12;
    quizModel.GSR15 = self.GSR_15;
    [quizModel genResult];
    
    [self.dicsResult addObject:quizModel];
}
-(void)saveQuiz{
    TblGraph*graph = [CGlobal getTblGraphFromQuizModel:self.quizResult DicResult:self.dicsResult];
    graph.tg_name = self.devicename;
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
                UIStoryboard* main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                GraphViewController* vc = (GraphViewController*) [main instantiateViewControllerWithIdentifier:@"GraphViewController"];
                vc.tblGraph = resp.tblGraph;
                vc.menuIndex = 205;
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
        case 400:{
            [self doneChoice:0];
            break;
        }
        case 401:{
            [self doneChoice:1];
            break;
        }
        case 402:{
            [self doneChoice:2];
            break;
        }
        case 300:{
            // btnok
            for (int i=0; i<_limitcnt; i++) {
                UIButton* btnView = _views_btn[i];
                NSString* txt = btnView.titleLabel.text;
                if ([txt length] > 0) {
                    // non input
                    btnView.enabled = false;
                }else{
                    // input things
                    NSLog(@"input things");
                }
                
            }
            self.imgResult.hidden = true;
            _viewQuiz.hidden = true;
            _viewDecision.hidden = true;
            _stackTypeSelect.hidden = false;
            break;
        }
        default:
            break;
    }
}
-(void)doneChoice:(int)which{
    _passUpload = true;
    _mMode = which;
    _viewQuiz.hidden = false;
    _viewDecision.hidden = true;
    _imgResult.hidden  = true;
    _stackTypeSelect.hidden = true;
    [self initQuiz];
    [self handleMessage:100 Data:nil];
    
    _btnExit.hidden = false;
    
    // dismiss dialog
}
-(void)initQuiz{
    [self.btn1 addTarget:self action:@selector(clickView_Quiz:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn2 addTarget:self action:@selector(clickView_Quiz:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn3 addTarget:self action:@selector(clickView_Quiz:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn4 addTarget:self action:@selector(clickView_Quiz:) forControlEvents:UIControlEventTouchUpInside];
    self.btn1.tag = 200;
    self.btn2.tag = 201;
    self.btn3.tag = 202;
    self.btn4.tag = 203;
    if (g_fakedata) {
        self.nCount = 3;
    }else{
        self.nCount = 12;
    }
    
    self.curPos = 0;
    self.curCount = 0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)handleMessage:(int)what Data:(id)data{
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
            self.viewDecision.hidden = true;
            self.viewQuiz.hidden = false;
            self.imgResult.hidden = true;
            self.curCount = self.curCount + 1;
            NSLog(@"%d",self.curCount);
            [self logValues];
            if (self.curCount >= _nCount) {
                if (_quizResult.count>1) {
                    [_quizResult removeObjectAtIndex:0];
                }
                _viewDecision.hidden = false;
                _viewQuiz.hidden = true;
                _imgResult.hidden = true;
                _stackTypeSelect.hidden = true;
                
                [self startDecision];
            }else{
                [self showRandomImages];
            }
            break;
        }
        case 400:{
            [self logDecision];
            [self saveQuiz];
            
            
            
            break;
        }
        default:
            break;
    }
}
-(void)startDecision{
    self.genIndex = arc4random_uniform(100)%4;
    self.mSeconds = 10;
    
    self.viewStartHolder.hidden = true;
    self.lblLastTick.hidden = false;
    
    
    self.lblLastTick.textColor = COLOR_PRIMARY;
    self.lblLastTick.text = @"10";
    for (int i=0; i<_limitcnt; i++) {
        UIButton* button = _views_btn[i];
        UITextField*txt = _views_txt[i];
        button.enabled = false;
        txt.enabled = false;
    }
    
    if (_timer !=nil) {
        [_timer invalidate];
    }
    self.tick = 0;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runnable3:) userInfo:nil repeats:true];
    
}
-(void)runnable3:(id)sender{
    
    
    self.tick = self.tick + 1;
    
    self.lblLastTick.text = [NSString stringWithFormat:@"%d",self.mSeconds - self.tick];
    if (self.tick>=self.mSeconds) {
        self.lblLastTick.text = @"";
        for (int i=0; i<_limitcnt; i++) {
            UIButton* button = _views_btn[i];
            button.enabled = true;
        }
        [self.timer invalidate];
        self.timer = nil;
    }else{
        switch (self.tick) {
            case 5:
            {
                self.GSR_5 = g_gsr;
                break;
            }
            case 7:{
                self.GSR_7 = g_gsr;
                break;
            }
            default:
                break;
        }
    }
}
-(void)selectImage:(UIView*)sender{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Upload Image" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* ac1 = [UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [CGlobal grantedPermissionCamera:^(BOOL ret) {
            if (ret) {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    picker.allowsEditing = false;
                    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
                    picker.delegate = self;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self presentViewController:picker animated:true completion:nil];
                    });
                    
                }else{
                    [CGlobal AlertMessage:@"No Camera" Title:nil Vc:self];
                }
            }else{
                [CGlobal AlertMessage:@"To continue ,please enable Intuitive's access to your Device Camera" Title:nil Vc:self];
            }
        }];
        
        
    }];
    UIAlertAction* ac2 = [UIAlertAction actionWithTitle:@"Choose from Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        BOOL authrozied = false;
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
            if([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized){
                authrozied = true;
            }else if([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusDenied){
                authrozied = false;
            }else if([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusNotDetermined){
                [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                    
                    [self doSelectAlbum:status == PHAuthorizationStatusAuthorized];
                }];
                return;
            }
        }else{
            authrozied = true;
        }
        
        [self doSelectAlbum:authrozied];
    }];
    UIAlertAction* ac3 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:ac1];
    [alert addAction:ac2];
    [alert addAction:ac3];
    
    UIPopoverPresentationController* popPresenter =  alert.popoverPresentationController;
    popPresenter.sourceView = self.view;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:true completion:nil];
    });
    
    
}
-(void)doSelectAlbum:(BOOL)authrozied{
    if (authrozied) {
        //gallery
        //picture
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
            picker.allowsEditing = false;
//            picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.delegate = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:picker animated:true completion:nil];
            });
            
        }else{
            [CGlobal AlertMessage:@"No PhotoLibrary" Title:nil Vc:self];
        }
    }else{
        
        [CGlobal AlertMessage:@"To continue ,please enable Intuitive's access to your Photo Album" Title:nil Vc:self];
    }
}

#pragma -mark ImagePicker
-(void) imagePickerController:(UIImagePickerController*) picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info
{
    
    UIImage * pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if (pickedImage == nil) {
        NSURL* url = [info objectForKey:UIImagePickerControllerReferenceURL];
        
        ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
        [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset) {
            ALAssetRepresentation *rep = [asset defaultRepresentation];
            
            CGImageRef iref = [rep fullScreenImage];
            if (iref) {
                UIImage* image = [UIImage imageWithCGImage:iref];
                _selectedImage = image;
                
                [picker dismissViewControllerAnimated:YES completion:nil];
                
                [self goImage:_selectedImage];
                
            }
        } failureBlock:^(NSError *err) {
            NSLog(@"Error: %@",[err localizedDescription]);
        }];
    }else{
        _selectedImage = pickedImage;
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        [self goImage:_selectedImage];
        
    }
    
}
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:true completion:nil];
}
-(void)doneButton:(UITextField*)textField{
    NSString* string = textField.text;
    if ([string length] > 0) {
        // valid string
        [self doneInput:string Number:self.prevIndex];
    }else if(_selectedImage != nil ){
        [self doneInput:_selectedImage Number:self.prevIndex];
    }
    NSLog(@"%@",textField.text);
    
    [self.view endEditing:YES];
    
    [self.keyBoxView.txtField resignFirstResponder];
    for (UITextField* txt in _views_txt) {
        [txt resignFirstResponder];
    }
//    UITextField* txt = _views_txt[self.prevIndex];
//    [txt resignFirstResponder];
    
    self.imgResult.hidden = true;
    _viewQuiz.hidden = true;
    _viewDecision.hidden = false;
    _stackTypeSelect.hidden = true;
    
    self.keyBoxView.txtField.text = @"";
    
    _btnExit.hidden = true;
}
- (IBAction)clickCamera:(id)sender {
    [CGlobal grantedPermissionCamera:^(BOOL ret) {
        if (ret) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                picker.allowsEditing = false;
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
                picker.delegate = self;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self presentViewController:picker animated:true completion:nil];
                });
                
            }else{
                [CGlobal AlertMessage:@"No Camera" Title:nil Vc:self];
            }
        }else{
            [CGlobal AlertMessage:@"To continue ,please enable Intuitive's access to your Device Camera" Title:nil Vc:self];
        }
    }];
}
- (IBAction)clickGallery:(id)sender {
    BOOL authrozied = false;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        if([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized){
            authrozied = true;
        }else if([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusDenied){
            authrozied = false;
        }else if([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusNotDetermined){
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                
                [self doSelectAlbum:status == PHAuthorizationStatusAuthorized];
            }];
            return;
        }
    }else{
        authrozied = true;
    }
    
    [self doSelectAlbum:authrozied];
}
- (IBAction)tapExit:(id)sender {
    [BottomView clickMenu:-1 Vc:self];
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
