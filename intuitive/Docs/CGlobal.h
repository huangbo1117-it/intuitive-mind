//
//  CGlobal.h
//  SchoolApp
//
//  Created by apple on 9/24/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"
#import "WNAActivityIndicator.h"
#import "NSString+Common.h"
#import "CustomTextField.h"
#import "EnvVar.h"
#import <CoreLocation/CLLocation.h>
#import "TblUser.h"
#import "LoginResponse.h"
#import "QuizResult.h"
#import <Charts/Charts.h>

extern  UIColor*   COLOR_TOOLBAR_TEXT;
extern  UIColor*   COLOR_TOOLBAR_BACK;
extern  UIColor*   COLOR_PRIMARY;
extern  UIColor*   COLOR_SECONDARY_PRIMARY;
extern  UIColor*   COLOR_SECONDARY_GRAY;
extern  UIColor*   COLOR_SECONDARY_THIRD;
extern  UIColor*   COLOR_RESERVED;

extern  NSString * g_baseUrl;
extern  NSString * g_shareurl;
extern BOOL g_fakedata;
extern BOOL g_islive;
extern int g_length;
extern TblGraph* g_LatestGraph;
extern int g_scale;

extern CGRect g_keyboardRect;

extern  NSString*   APISERVICE_IP_URL;
extern  NSString*   APISERVICE_MAP_URL;
extern  NSString*   COMMON_PATH1;

extern  NSString*   ACTION_LOGIN;
extern  NSString*   ACTION_GRAPH;
extern  NSString*   ACTION_FORGOT;
extern  NSString*   ACTION_INVITE_GAME;
extern  NSString*   ACTION_UPDATE_GAME;
extern  NSString*   ACTION_GET_BELL;
extern  NSString*   ACTION_CONQUERED_COUNTRY;
extern  NSString*   ACTION_UPLOAD;
extern  NSString*   ACTION_LIKEPIC;
extern  NSString*   ACTION_REPORT;
extern  NSString*   ACTION_ACTIVEBIDS ;
extern  NSString*   ACTION_MAKEPOST ;
extern  NSString*   ACTION_COMMENT ;
extern  NSString*   ACTION_USERINFO ;
extern  NSString*   ACTION_UPDATEPROFILE ;
extern  NSString*   ACTION_LOADNOTI ;
extern  NSString*   ACTION_TOGO_IDS ;
extern  NSString*   ACTION_TOGO_DATA ;
extern  NSString*   ACTION_CONQUERED_DATA ;

extern  NSString*   ACTION_DEFAULTPROFILE ;


extern  NSString*   G_SHARETEXT ;

extern int gms_camera_zoom;
extern NSString* g_gsr;
extern NSDictionary*g_launchoptions;
extern NSString*g_head1 ;
extern NSString*g_head2 ;
//basic data



//notifications
extern NSString *GLOBALNOTIFICATION_DATA_CHANGED_PHOTO ;
extern NSString *GLOBALNOTIFICATION_MAP_PICKLOCATION ;
extern NSString *GLOBALNOTIFICATION_RECEIVE_USERINFO_SUCC;
extern NSString *GLOBALNOTIFICATION_RECEIVE_USERINFO_FAIL;
extern NSString *GLOBALNOTIFICATION_CHANGEVIEWCONTROLLER;
extern NSString *GLOBALNOTIFICATION_CHANGEVIEWCONTROLLERREBATE;
extern NSString *GLOBALNOTIFICATION_MQTTPAYLOAD;
extern NSString *GLOBALNOTIFICATION_MQTTPAYLOAD_PROCESS;
extern NSString *GLOBALNOTIFICATION_TRENDINGRESET;
extern NSString *GLOBALNOTIFICATION_LIKEDBUTTON;

extern NSString *NOTIFICATION_RECEIVEUUID;

extern NSString *const kPhotoManagerChangedContentNotificationHot;
extern NSString *const kPhotoManagerChangedContentNotificationFresh;
extern NSString *const kPhotoManagerChangedContentNotificationOthers;

//menu height
extern CGFloat GLOBAL_MENUHEIGHT;
extern CGFloat GLOBAL_MENUWIDTH;

typedef void (^PermissionCallback)(BOOL ret);

@interface CGlobal : NSObject
+ (CGlobal *)sharedId;

@property (nonatomic, strong) TblUser* curUser;
@property (nonatomic, strong) LoginResponse* loginResponse;
@property (nonatomic, assign) CLLocationCoordinate2D defaultPos;
@property (nonatomic, strong) EnvVar * env;

// COMMON FUMCTIONS
+(void)makeTermsPrivacyForLabel: (TTTAttributedLabel *) label withUrl:(NSString*)urlString;
+(void)initSample;
+(int)getOrientationMode;
+(void)showIndicator:(UIViewController*)viewcon;
+(void)stopIndicator:(UIViewController*)viewcon;
+(void)showIndicatorForView:(UIView*)viewcon;
+(void)stopIndicatorForView:(UIView*)viewcon;
+(void)AlertMessage:(NSString*)message Title:(NSString*)title Vc:(UIViewController*)vc;
+(void)backProcess;
+(void)backProcess:(UIViewController*)con Delegate:(id)mydelegate;
+(void)makeBorderBlackAndBackWhite:(UIView*)target;
+(void)makeBorderASUITextField:(UIView*)target;
+(CGFloat)heightForView:(NSString*)text Font:(UIFont*) font Width:(CGFloat) width;
+(NSString*)getUDID;
+(void)setDefaultBackground:(UIViewController*)viewcon;
+(NSString*) jsonStringFromDict:(BOOL) prettyPrint Dict:(NSDictionary*)dict;
+(NSString*)getEncodedString:(NSString*)input;
//+(BOOL)gotoViewController:(UIViewController*)controller Mode:(int) mode;

+(NSString*)getDateFromPickerForDb:(UIDatePicker*)datePicker;
+(NSDate*)getDateFromDbString:(NSString*)string Gmt:(BOOL)useGmt;
+(NSDate*)getLocalDateFromDbString:(NSString*)string;
+(NSString*)getLocalDateFromDBString:(NSString*)string;
+(NSString*)getGmtHour;
+(NSString*)getCurrentTimeInGmt0;
+(NSString*)getTimeStringFromDate:(NSDate*)sourceDate;
+(NSArray*)getIntegerArrayFromRids:(NSString*)rids;
+(NSString*)getFormattedTimeFormPicker:(UIDatePicker*)picker;
+(int)ageFromBirthday:(NSDate *)birthdate;
+(NSString*)getAgoTime:(NSString*)param1 IsGmt:(BOOL)isGmt;
+(NSNumber*)getNumberFromStringForCurrency:(NSString*)formatted_str;
+(NSString*)getStringFromNumberForCurrency:(NSNumber*)number;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert Alpha:(CGFloat)alpha;
+(void)shareText:(NSString *)text andImage:(UIImage *)image andUrl:(NSURL *)url withView:(UIView*)view withController:(UIViewController*)controller;
+ (NSString *)urlencode:(NSString*)param1;
+(NSString*)timeStamp;
+(NSTimeInterval)timeStampInterval;
// program specific
+(void)setStyleForInput1:(UIView*)buttonView;
+(void)setStyleForInput2:(UIView*)viewRound View:(UIView*)viewtext Radius:(CGFloat)radius;
+(void)setStyleForInput3:(UIView*)viewRound TextField:(UITextField*)textField LeftorRight:(BOOL)isLeft Radius:(CGFloat)radius SelfView:(UIView*)view;
+(void)showMenu:(UIViewController*)viewcon;
+(void)hideMenu;
+(void)toggleMenu:(UIViewController*)viewcon;
+(void)addRangeSlider:(UIView*)view Min:(CGFloat)min Max:(CGFloat)max RangeSlider:(id)m_slider WithFrame:(CGRect)rect SliderType:(int)type;
+(NSString*)checkTimeForCreateBid:(NSString*)string;
+ (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
+ (UIImage*)getScaledImage:(UIImage*)image Source:(UIImagePickerControllerSourceType)sourceType;
+(void)removeDuplicatesForPhotos:(NSMutableArray*)source WithData:(NSMutableArray*)data;
//PARSING JSON

+(UIImage*)getImageForMap:(UIImage*)bm NSString:(NSString*)number;
+(UIImage*)getImageForMap:(NSString*)number;
-(instancetype)initWithDictionary:(NSDictionary*) dict;
+(NSMutableDictionary*)getQuestionDict:(id)targetClass;
+(void)parseResponse:(id)targetClass Dict:(NSDictionary*)dict;
+(id)getDuplicate:(id)targetClass;

+(NSData*)buildJsonData:(id)targetClass;
+ (UIImage *)ipMaskedImageNamed:(NSString *)name color:(UIColor *)color;
+ (UIImage *)scaleAndRotateImage:(UIImage *)image;
+ (CGSize)getSizeForAspect:(UIImage*)image Frame:(CGSize)frame;
+ (CGSize)getSizeForAspectFromSize:(CGSize)imageSize Frame:(CGSize)frame;
+(void)grantedPermissionCamera:(PermissionCallback)callback;
+(void)grantedPermissionPhotoLibrary:(PermissionCallback)callback;
+(UIImage*)getColoredImage:(NSString*)imgName Color:(UIColor*)color;
+(UIImage*)getColoredImageFromImage:(UIImage*)image Color:(UIColor*)color;
+(void) setTerm:(TTTAttributedLabel*)attributedLabel;
+(BOOL) isValidEmail:(NSString*)email;
+(NSString *) escapeString:(NSString *)string;
+(NSString*) getDateString:(NSInteger)offset;
+(int)getLastFileNumber;
+(NSString*)getFileName:(int)max Mode:(int)mode;
+(TblGraph*)getTblGraphFromQuizModel:(NSMutableArray*)quizResult DicResult:(NSMutableArray*)dicsResult;
+(BOOL)saveExcelFile:(NSString*)fileName Result:(NSMutableArray*)quizResult DicResult:(NSMutableArray*)dicsResult;
+(NSMutableDictionary*)readExcelFile:(NSString*)fileName;
+(NSMutableDictionary*)readFromTblGraph:(TblGraph*)tblGraph;
+(BOOL)quizValid:(QuizResult*)data_f Data:(QuizResult*)data_t List:(NSMutableArray*)resultList;
+(QuizResult*)getGraphRowDataDic:(NSMutableArray*)resultList;
+(NSMutableArray*)getGraphRowData:(NSMutableArray*)resultList;
+(int)checkHead:(NSString*)line;
+(NSArray*)drawGraph:(BarChartView*)mChart Result:(NSMutableArray*)list;
+(void)drawGraph:(LineChartView*)mChart DataTrue:(QuizResult*)data_t DataFalse:(QuizResult*)data_f DataDecision:(QuizResult*)data_d;
+(NSString*)getCreationTime:(NSDate*)date GMT:(BOOL)isGmt MODE:(int)mode;
+(NSMutableArray*)getMyLogFiles:(int)mode;
+(NSMutableArray*)getMyLogFiles:(int)mode Data:(LoginResponse*)resp;
+(NSMutableArray*)getMyLogFiles;
+(NSMutableArray*)getMyLogFiles_FromLogin:(LoginResponse*)resp;
+(NSMutableArray*)getRandomIndex:(int)pos Length:(int)n1 allIndex:(NSMutableArray*)allData TempSession:(NSMutableArray*)tempSession;
+(void)checkQuizResult:(QuizResult*)result;
@end
