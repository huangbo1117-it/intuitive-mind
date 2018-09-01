//
//  AppDelegate.h
//  intuitive
//
//  Created by BoHuang on 4/13/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginResponse.h"
#import "DBManager.h"
#import "SFBLEDeviceFinder.h"
#import "SFBLEDevice.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate,SFBLEDeviceDelegate, SFBLEDeviceFinderDelegate>

@property (strong, nonatomic) UIWindow *window;
-(void)goMainWindow:(LoginResponse*)data;
-(void)defaultLogin;
-(void)logout;

@property (nonatomic, strong) NSDictionary *serviceAndCharacters;
@property (nonatomic, strong) NSArray *arrayServices;
@property (nonatomic, strong) NSArray *arrayCharacters;

@property (nonatomic, strong) DBManager *dbManager;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) SFBLEDeviceFinder* finder;
@property (nonatomic) SFBLEDevice* device;
-(void)initBlu;
@property (nonatomic,strong) NSString* blu_status;
- (void)link:(id)sender;
- (void)unlink:(id)sender;

@property (nonatomic,assign) NSInteger blueIndex;
@end

