//
//  WNAAppDelegate.m
//  Wordpress News App
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import "CGlobal.h"
#import "NetworkParser.h"
#import "TblUser.h"
#import "LoginResponse.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    [IQKeyboardManager sharedManager].shouldShowTextFieldPlaceholder = false;
//    [IQKeyboardManager sharedManager].shouldHidePreviousNext = false;
    g_fakedata = false;
    
    [self setUpNavigationBar];
    [self initData];
    [self initService];
//    [self initBlu];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    
    
    return YES;
}
-(void) initService{
    CBUUID* service = self.arrayServices[self.blueIndex];
    CBUUID* character = self.arrayCharacters[self.blueIndex];
    NSDictionary* HRServsAndCharacs = @{service : @[character]};

    self.finder = [SFBLEDeviceFinder finderForDevicesWithServicesAndCharacteristics:HRServsAndCharacs advertising:@[service]];
    self.finder.delegate = self;
}

-(void) initData{
    _dbManager = [[DBManager alloc] initWithDatabaseFilename:@"country.sqlite3"];
    if (g_fakedata) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(mimicValue:) userInfo:nil repeats:true];
    }
    
    COLOR_PRIMARY = [CGlobal colorWithHexString:@"fcbd10" Alpha:1.0f];
    COLOR_RESERVED = [CGlobal colorWithHexString:@"283d61" Alpha:1.0f];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardOnScreen:) name:UIKeyboardDidShowNotification object:nil];
    
    NSMutableDictionary*tempHRServsAndCharacs = [[NSMutableDictionary alloc] init];
    NSMutableArray* arrayServices = [[NSMutableArray alloc] init];
    NSMutableArray* arrayCharacs = [[NSMutableArray alloc] init];
    if (true) {
        NSString* BLEServiceHeartRate         = @"0000ffe0-0000-1000-8000-00805f9b34fb";
        NSString* BLECharHeartRateMeasurement = @"0000ffe1-0000-1000-8000-00805f9b34fb";
        tempHRServsAndCharacs[[CBUUID UUIDWithString:BLEServiceHeartRate]] = @[[CBUUID UUIDWithString:BLECharHeartRateMeasurement]];
        [arrayServices addObject:[CBUUID UUIDWithString:BLEServiceHeartRate]];
        [arrayCharacs addObject:[CBUUID UUIDWithString:BLECharHeartRateMeasurement]];
    }
    
    if (true) {
        NSString* BLEServiceHeartRate         = @"0000fff0-0000-1000-8000-00805f9b34fb";
        NSString* BLECharHeartRateMeasurement = @"0000fff4-0000-1000-8000-00805f9b34fb";
        tempHRServsAndCharacs[[CBUUID UUIDWithString:BLEServiceHeartRate]] = @[[CBUUID UUIDWithString:BLECharHeartRateMeasurement]];
        [arrayServices addObject:[CBUUID UUIDWithString:BLEServiceHeartRate]];
        [arrayCharacs addObject:[CBUUID UUIDWithString:BLECharHeartRateMeasurement]];
    }
    
    if (true) {
        NSString* BLEServiceHeartRate         = @"EDFEC62E-9910-0BAC-5241-D8BDA6932A2F";
        NSString* BLECharHeartRateMeasurement = @"15005991-B131-3396-014C-664C9867B917";
        tempHRServsAndCharacs[[CBUUID UUIDWithString:BLEServiceHeartRate]] = @[[CBUUID UUIDWithString:BLECharHeartRateMeasurement]];
        [arrayServices addObject:[CBUUID UUIDWithString:BLEServiceHeartRate]];
        [arrayCharacs addObject:[CBUUID UUIDWithString:BLECharHeartRateMeasurement]];
    }
    
    NSDictionary* HRServsAndCharacs = [NSDictionary dictionaryWithDictionary:tempHRServsAndCharacs];
    self.serviceAndCharacters = HRServsAndCharacs;
    self.arrayServices = [NSArray arrayWithArray:arrayServices];
    self.arrayCharacters = [NSArray arrayWithArray:arrayCharacs];
    self.blueIndex = self.arrayServices.count - 1;
}
- (void)keyboardOnScreen:(NSNotification *)notification {
    NSDictionary* keyboardInfo = [notification userInfo];
    // UIKeyboardFrameEndUserInfoKey UIKeyboardFrameBeginUserInfoKey
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    g_keyboardRect = keyboardFrameBeginRect;
    
    NSNotificationCenter *center;
    [center removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    
}
-(void)mimicValue:(id)sender{
    int offset = arc4random_uniform(10000);
    g_gsr = [NSString stringWithFormat:@"%.04f",offset/1000.0f];
}
-(void)logout{
    EnvVar *env = [CGlobal sharedId].env;
    [env logOut];
    g_launchoptions = nil;
    
    
    
    
    [CGlobal sharedId].curUser = nil;
    [self defaultLogin];
}
-(void)goMainWindow:(LoginResponse*)data{
    EnvVar*env = [CGlobal sharedId].env;
    [env setUsername:data.tblUser.tu_username];
    [env setPassword:data.tblUser.tu_password];
    [env setLastLogin:[data.tblUser.tu_id intValue]];
    
    [CGlobal sharedId].curUser = data.tblUser;
    [CGlobal sharedId].loginResponse = data;
    
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        UITabBarController *navigationController = (UITabBarController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"CMainNav"];
        self.window.rootViewController = navigationController;
        
    });
}
-(void)defaultLogin{
    EnvVar*env = [CGlobal sharedId].env;
    [env setLastLogin:0];
    //    g_searchTerm = nil;
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    UINavigationController *navigationController = (UINavigationController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"CLoginNav"];
    
    self.window.rootViewController = navigationController;
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)setUpNavigationBar
{
    
}

-(void)initBlu{
    CBUUID* service = self.arrayServices[self.blueIndex];
    CBUUID* character = self.arrayCharacters[self.blueIndex];
    NSDictionary* HRServsAndCharacs = @{service : @[character]};
    NSLog(@"%@",[service UUIDString]);
    NSLog(@"%@",[character UUIDString]);
    NSLog(@"---\n");
    self.finder = [SFBLEDeviceFinder finderForDevicesWithServicesAndCharacteristics:HRServsAndCharacs advertising:@[service]];
    self.finder.delegate = self;
    
    self.blu_status = @"none";
    [self startFind:nil];
    g_islive = false;
}
- (IBAction)startFind:(id)sender
{
    self.device = nil;
    [self.finder findDevices:3.5];
}
- (void)link:(id)sender
{
    [self.device link];
}
- (void)unlink:(id)sender
{
    [self.device unlink];
}
- (void)setDevice:(SFBLEDevice*)device
{
    if (_device == device)
        return;
    NSLog(@"%@",device.name);
    [_device unlink];
    _device.delegate = nil;
    
    _device = device;
    
    _device.delegate = self;
}

#pragma mark -
#pragma mark SFBLEDeviceFinderDelegate


- (void)finderFoundDevices:(NSArray*)bleDevices error:(NSError*)error
{
    if (bleDevices.count) {
        self.blu_status = @"found";
        self.device = bleDevices.firstObject;
        
    }
    else {
        self.blu_status = @"not_found";
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"blu_status_changed" object:@{@"status":self.blu_status} userInfo:nil];
}


- (void)finderStoppedFindWithError:(NSError*)error
{
    
}


- (void)bluetoothNotAvailable
{
    
}


- (void)bluetoothAvailableAgain
{
    
}




#pragma mark -
#pragma mark SFBLEDeviceDelegate


- (void)deviceLinkedSuccessfully:(SFBLEDevice*)device
{
    NSAssert(self.device == device, @"We should not connect to any other device, than the one in the ivar");
    CBUUID* uuid = self.arrayCharacters[self.blueIndex];
    [device subscribeToCharacteristic:uuid];
    
    self.blu_status = @"linked";
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"blu_status_changed" object:@{@"status":@"linked"} userInfo:nil];
    g_islive = true;
}


- (void)device:(SFBLEDevice*)SFBLEDevice failedToLink:(NSError*)error
{
    self.blu_status = @"link_failed";
    [[NSNotificationCenter defaultCenter] postNotificationName:@"blu_status_changed" object:@{@"status":@"link_failed"} userInfo:nil];
    g_islive = false;
}
- (void)device:(SFBLEDevice*)SFBLEDevice unlinked:(NSError*)error
{
    self.blu_status = @"unlinked";
    [[NSNotificationCenter defaultCenter] postNotificationName:@"blu_status_changed" object:@{@"status":@"unlinked"} userInfo:nil];
    g_islive = false;
}


- (void)device:(SFBLEDevice*)device receivedData:(NSData*)data fromCharacteristic:(CBUUID*)uuid
{
    //  UInt8 heartRate;
    //  [data getBytes:&heartRate range:NSMakeRange(1, 1)];
    //  self.hrLabel.text = @(heartRate).stringValue;
    NSString* str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self testValue:str];
//    NSLog(@"%@ %@",[uuid UUIDString],str);
    //    self.lbluuid.text = [uuid UUIDString];
}
-(BOOL)testValue:(NSString*)str{
    @try {
        double val = [str doubleValue];
        g_gsr = [NSString stringWithFormat:@"%.4f",val];
        return true;
    } @catch (NSException *exception) {
        return false;
    }
}
@end
