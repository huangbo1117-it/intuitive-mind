	//
//  CGlobal.m
//  SchoolApp
//
//  Created by apple on 9/24/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

#import "CGlobal.h"
#import <objc/runtime.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <CoreLocation/CoreLocation.h>
#import "QuizResult.h"

#import "Statistics.h"
#import "MyPopupDialog.h"
#import "PromptDialog.h"
#import "MyAxisValueFormatter.h"

UIColor*   COLOR_TOOLBAR_TEXT;
UIColor*   COLOR_TOOLBAR_BACK;
UIColor*   COLOR_PRIMARY;
UIColor*   COLOR_SECONDARY_PRIMARY;
UIColor*   COLOR_SECONDARY_GRAY;
UIColor*   COLOR_SECONDARY_THIRD;
UIColor*   COLOR_RESERVED;

//NSString* g_baseUrl = @"http://192.168.1.100";
NSString* g_baseUrl = @"http://intuition-ipt.com";
NSString* g_shareurl = @"http://techlo9.com/Cuda-Templet/Graph.php";
BOOL g_fakedata = false;    // fake data
BOOL g_islive = false;
int g_length = 7;
TblGraph* g_LatestGraph;
int g_scale=1;

CGRect g_keyboardRect;

NSString*   APISERVICE_IP_URL = @"http://ip-api.com/json";
NSString*   APISERVICE_MAP_URL = @"http://maps.googleapis.com/maps";
NSString*   COMMON_PATH1 = @"/webservice/rest/apnsv1/";
//NSString*   COMMON_PATH1 = @"/intuition/rest/apnsv1/";

NSString*   ACTION_LOGIN = @"login.php";
NSString*   ACTION_GRAPH = @"actiongraph.php";
NSString*   ACTION_FORGOT = @"forgotpassword.php";
NSString*   ACTION_INVITE_GAME = @"/invite_game.php";
NSString*   ACTION_UPDATE_GAME = @"/update_game.php";
NSString*   ACTION_GET_BELL = @"/get_bell.php";
NSString*   ACTION_CONQUERED_COUNTRY = @"/loadconquered_country.php";

NSString*   ACTION_UPLOAD = @"/fileuploadmm.php";
NSString*   ACTION_LIKEPIC = @"/actionlike.php";
NSString*   ACTION_REPORT = @"/actionreport.php";
NSString*   ACTION_MAKEPOST = @"/makepost.php";
NSString*   ACTION_COMMENT = @"/actioncomment.php";
NSString*   ACTION_USERINFO = @"/userinfo.php";
NSString*   ACTION_UPDATEPROFILE = @"/updateprofile.php";
NSString*   ACTION_LOADNOTI = @"/load_noti.php";
NSString*   ACTION_TOGO_IDS = @"/loadtogo_ids.php";

NSString*   ACTION_TOGO_DATA = @"/loadtogo_data.php";
NSString*   ACTION_CONQUERED_DATA = @"/loadconquered_data.php";

NSString*   ACTION_DEFAULTPROFILE = @"/assets/uploads/user1.png";

NSString*   G_SHARETEXT = @"Start tracking your pool games with us at jellyrollpool.com.";

int gms_camera_zoom = 3;
NSString* g_gsr;
NSDictionary*g_launchoptions;
NSString*g_head1 = @"5,7,choice,10,12,15,random,result";
NSString*g_head2 = @",,,,,,,";

//basic info

// notifications
NSString *GLOBALNOTIFICATION_DATA_CHANGED_PHOTO = @"GLOBALNOTIFICATION_DATA_CHANGED_PHOTO";;
NSString *GLOBALNOTIFICATION_MAP_PICKLOCATION = @"GLOBALNOTIFICATION_MAP_PICKLOCATION";
NSString *GLOBALNOTIFICATION_RECEIVE_USERINFO_SUCC = @"GLOBALNOTIFICATION_RECEIVE_USERINFO_SUCC";
NSString *GLOBALNOTIFICATION_RECEIVE_USERINFO_FAIL = @"GLOBALNOTIFICATION_RECEIVE_USERINFO_FAIL";
NSString *GLOBALNOTIFICATION_CHANGEVIEWCONTROLLER = @"GLOBALNOTIFICATION_CHANGEVIEWCONTROLLER";
NSString *GLOBALNOTIFICATION_CHANGEVIEWCONTROLLERREBATE = @"GLOBALNOTIFICATION_CHANGEVIEWCONTROLLERREBATE";

NSString *GLOBALNOTIFICATION_MQTTPAYLOAD = @"GLOBALNOTIFICATION_MQTTPAYLOAD";
NSString *GLOBALNOTIFICATION_MQTTPAYLOAD_PROCESS = @"GLOBALNOTIFICATION_MQTTPAYLOAD_PROCESS";

NSString *GLOBALNOTIFICATION_TRENDINGRESET = @"GLOBALNOTIFICATION_TRENDINGRESET";
NSString *GLOBALNOTIFICATION_LIKEDBUTTON =  @"GLOBALNOTIFICATION_LIKEDBUTTON";

NSString *NOTIFICATION_RECEIVEUUID =  @"NOTIFICATION_RECEIVEUUID";

NSString *const kPhotoManagerChangedContentNotificationHot = @"NOTIFICATION_PhotoManagerChangedContentHot";

NSString *const kPhotoManagerChangedContentNotificationFresh = @"NOTIFICATION_PhotoManagerChangedContentFresh";

NSString *const kPhotoManagerChangedContentNotificationOthers = @"NOTIFICATION_PhotoManagerChangedContentOthers";


//MENU HEIGHT
CGFloat GLOBAL_MENUHEIGHT = 50;
CGFloat GLOBAL_MENUWIDTH = 200;

//common variables
NSMutableArray *g_buttonTitles;
UIFont * g_largefont;
CGFloat g_menuHeight = 50;
NSMutableArray* menu_bottomList;
NSMutableArray* menu_topList;

@implementation CGlobal

+(void)initSample{
    [self initConfig];
    
}
+(void)initConfig{
    
}


+ (CGlobal *)sharedId
{
    static dispatch_once_t onceToken;
    static CGlobal *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[CGlobal alloc] init];
    });
    return instance;
}

- (id) init
{
    self = [super init];
    if (self != nil)
    {
        _env = [[EnvVar alloc] init];
        //        _curUser = [[TblUser alloc] init];
        // 33.858606, 35.816947
        _defaultPos = CLLocationCoordinate2DMake(33.858606, 35.816947);
    }
    return self;
}

// Common Funcs
+(void)makeCountLabel:(UILabel*) label{
    
}
+(void)makeTermsPrivacyForLabel: (TTTAttributedLabel *) label withUrl:(NSString*)urlString{
    //TTTAttributedLabel *tttLabel = ;
    NSString *labelText = label.text;
    
    NSRange r = [labelText rangeOfString:labelText];
    [label addLinkToURL:[NSURL URLWithString:urlString] withRange:r];
    
}
+(void)showIndicator:(UIViewController*)viewcon{
    WNAActivityIndicator* activityIndicator = (WNAActivityIndicator*)[viewcon.view viewWithTag:1999];
    if(activityIndicator == nil){
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        activityIndicator = [[WNAActivityIndicator alloc] initWithFrame:screenRect];
        activityIndicator.tag = 1999;
        [activityIndicator setHidden:NO];
    }
    if (![activityIndicator isDescendantOfView:viewcon.view]) {
        [viewcon.view addSubview:activityIndicator];
    }
    [viewcon.view bringSubviewToFront:activityIndicator];
}
+(void)stopIndicator:(UIViewController*)viewcon{
    WNAActivityIndicator* activityIndicator = (WNAActivityIndicator*)[viewcon.view viewWithTag:1999];
    if(activityIndicator!=nil){
        [activityIndicator setHidden:YES];
        [activityIndicator removeFromSuperview];
        activityIndicator = nil;
    }
    NSLog(@"ddd");
    
    //    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}
+(void)showIndicatorForView:(UIView*)viewcon{
    if (viewcon==nil) {
        return;
    }
    WNAActivityIndicator* activityIndicator = (WNAActivityIndicator*)[viewcon viewWithTag:1999];
    if(activityIndicator == nil){
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        activityIndicator = [[WNAActivityIndicator alloc] initWithFrame:screenRect];
        activityIndicator.tag = 1999;
        [activityIndicator setHidden:NO];
    }
    if (![activityIndicator isDescendantOfView:viewcon]) {
        [viewcon addSubview:activityIndicator];
    }
    [viewcon bringSubviewToFront:activityIndicator];
}
+(void)stopIndicatorForView:(UIView*)viewcon{
    if (viewcon==nil) {
        return;
    }
    WNAActivityIndicator* activityIndicator = (WNAActivityIndicator*)[viewcon viewWithTag:1999];
    if(activityIndicator!=nil){
        [activityIndicator setHidden:YES];
        [activityIndicator removeFromSuperview];
        activityIndicator = nil;
    }
    NSLog(@"ddd1");
    //    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}
//+(void)showIndicator:(UIViewController*)viewcon{
//    UIActivityIndicatorView* view = (UIActivityIndicatorView*)[viewcon.view viewWithTag:1000];
//    if(view == nil){
//        CGFloat width = 60.0;
//        CGFloat height = 60.0;
//        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//
//        [indicatorView setColor:[UIColor colorWithRed:69.0/255.0 green:98.0/255.0 blue:163.0/255.0 alpha:1]];
//        indicatorView.center = viewcon.view.center;
//        indicatorView.tag = 1000;
//        [viewcon.view addSubview:indicatorView];
//        [viewcon.view bringSubviewToFront:indicatorView];
//
//        view = indicatorView;
//    }
//
//    view.hidden = false;
//    [viewcon.view bringSubviewToFront:view];
//    [view startAnimating];
//}
//+(void)stopIndicator:(UIViewController*)viewcon{
//    UIActivityIndicatorView* view = (UIActivityIndicatorView*)[viewcon.view viewWithTag:1000];
//    if(view != nil){
//        view.hidden = YES;
//        [view stopAnimating];
//    }
//}
+(void)removeIndicator:(UIViewController*)viewcon{
    UIActivityIndicatorView* view = (UIActivityIndicatorView*)[viewcon.view viewWithTag:1000];
    if(view != nil){
        [view removeFromSuperview];
    }
}
+(void)AlertMessageMessage:(NSString*)message Title:(NSString*)title{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:title
                          message:message
                          delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil];
    [alert show];
}
+(void)AlertMessage:(NSString*)message Title:(NSString*)title Vc:(UIViewController*)vc{
    if (vc == nil) {
        [CGlobal AlertMessageMessage:message Title:title];
        
    }else{
        MyPopupDialog* dialog = [[MyPopupDialog alloc] init];
        PromptDialog* view = [[NSBundle mainBundle] loadNibNamed:@"PromptDialog" owner:vc options:nil][0];
        [view setData:@{@"vc":vc,@"title":message,@"action":@"close"}];
        [dialog setup:view backgroundDismiss:false backgroundColor:[UIColor darkGrayColor]];
        [dialog showPopup:vc.view];
    }
}
+(void)makeBorderBlackAndBackWhite:(UIView*)target{
    target.layer.borderWidth = 1;
    target.layer.borderColor = [UIColor blackColor].CGColor;
    target.layer.masksToBounds = true;
}
+(void)makeBorderASUITextField:(UIView*)target{
    target.layer.borderWidth = 1;
    target.layer.borderColor = [UIColor blackColor].CGColor;
    target.layer.cornerRadius = 4;
    target.layer.masksToBounds = true;
}
+(CGFloat)heightForView:(NSString*)text Font:(UIFont*) font Width:(CGFloat) width{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, CGFLOAT_MAX)];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.font = font;
    label.text = text;
    [label sizeToFit];
    
    CGFloat height = MAX(label.frame.size.height, 21);
    return height;
}

+(NSString*)getUDID{
    NSString *uuid = [[NSUUID UUID] UUIDString];
    return uuid;
}
+(void)setDefaultBackground:(UIViewController*)viewcon{
    UIImageView* view = (UIImageView*)[viewcon.view viewWithTag:2000];
    if(view == nil){
        view = [[UIImageView alloc] initWithFrame:viewcon.view.frame];
        view.image = [UIImage imageNamed:@"bg_shopping.png"];
        
        view.center = viewcon.view.center;
        view.tag = 2000;
        [viewcon.view addSubview:view];
        [viewcon.view sendSubviewToBack:view];
    }
}
+(int)getOrientationMode{
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    int mode = 4;
    if (orientation == UIDeviceOrientationLandscapeLeft) {
        mode = 1;
    } else if (orientation == UIDeviceOrientationLandscapeRight) {
        mode = 2;
    } else if (orientation == UIDeviceOrientationPortraitUpsideDown) {
        mode = 3;
    } else if (orientation == UIDeviceOrientationPortrait) {
        mode = 4;
    }
    return mode;
}
+(NSString*) jsonStringFromDict:(BOOL) prettyPrint Dict:(NSDictionary*)dict{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:(NSJSONWritingOptions)    (prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"bv_jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}
+(NSString*)getEncodedString:(NSString*)input{
    NSCharacterSet *URLCombinedCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@" \"#%/:<>?@[\\]^`,.&'{|}\n"] invertedSet];
    
    
    NSString *path = [input stringByAddingPercentEncodingWithAllowedCharacters:URLCombinedCharacterSet];
    return  path;
}

// datepicker and time

+(NSString*)getDateFromPickerForDb:(UIDatePicker*)datePicker{
    NSDate *myDate = datePicker.date;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *prettyVersion = [dateFormat stringFromDate:myDate];
    return prettyVersion;
}
+(NSDate*)getDateFromDbString:(NSString*)string Gmt:(BOOL)useGmt{
    
    
    NSString *str =string;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    if (useGmt) {
        NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        [formatter setTimeZone:gmt];
    }else{
        NSTimeZone *gmt = [NSTimeZone localTimeZone];
        [formatter setTimeZone:gmt];
    }
    
    NSDate* date = [formatter dateFromString:str];
    
    //    NSLog(@"%@",date);
    return date;
}
+(NSDate*)getLocalDateFromDbString:(NSString*)string{
    
    
    NSString *str =string;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *timezone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    //    NSTimeZone* timezone = [NSTimeZone systemTimeZone];
    [formatter setTimeZone:timezone];
    NSDate* date = [formatter dateFromString:str];
    
    //    NSLog(@"%@",date);
    return date;
    
}
+(NSString*)getLocalDateFromDBString:(NSString*)string{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    NSTimeZone *gmtTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:gmtTimeZone];
    NSDate *dateFromString = [dateFormatter dateFromString:string];
    NSLog(@"Input date as GMT: %@",dateFromString);
    
    NSTimeZone* sourceTimeZone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:sourceTimeZone];
    NSString *dateRepresentation = [dateFormatter stringFromDate:dateFromString];
    NSLog(@"Date formated with local time zone: %@",dateRepresentation);
    
    return dateRepresentation;
}
+(NSString*)getGmtHour{
    NSDate* sourceDate = [NSDate date];
    
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    //    NSTimeZone* destinationTimeZone = [NSTimeZone timeZoneWithName:@"America/New_York"];
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate] ;
    
    NSDate* sourceDateM = [[NSDate alloc] initWithTimeInterval:-interval sinceDate:destinationDate] ;
    
    NSUInteger componentFlags =  NSCalendarUnitHour|NSCalendarUnitMinute;
    //    NSDateComponents *compoenents = [[NSCalendar currentCalendar] components:componentFlags fromDate:destinationDate];
    
    NSDateComponents *compoenents = [[NSCalendar currentCalendar]  components:NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:sourceDateM toDate:destinationDate options:0];
    
    NSInteger hour = [compoenents hour];
    NSInteger min = [compoenents minute];
    NSString *gmt = [NSString stringWithFormat:@"%d;%d",hour,min];
    
    return gmt;
}
+(NSString*)getCurrentTimeInGmt0{
    NSDate* sourceDate = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *prettyVersion = [dateFormat stringFromDate:sourceDate];
    
    return prettyVersion;
}
+(NSString*)getTimeStringFromDate:(NSDate*)sourceDate{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *prettyVersion = [dateFormat stringFromDate:sourceDate];
    
    return prettyVersion;
}
+(NSArray*)getIntegerArrayFromRids:(NSString*)rids{
    if (rids == nil || [rids isBlank]) {
        return nil;
    }
    NSString*mm = [rids stringByReplacingOccurrencesOfString:@";;" withString:@";"];
    if ([mm length]>=3) {
        mm = [mm substringFrom:1 to:[mm length]-1];
    }else{
        return nil;
    }
    NSArray*foo = [mm componentsSeparatedByString:@";"];
    
    return foo;
}
+(NSString*)getFormattedTimeFormPicker:(UIDatePicker*)picker{
    return @"";
}
+(int)ageFromBirthday:(NSDate *)birthdate {
    NSDate *today = [NSDate date];
    NSString*date1 = [CGlobal getTimeStringFromDate:today];
    NSString*date2 = [CGlobal getTimeStringFromDate:birthdate];
    
    int age = [[date1 substringToIndex:4] intValue] - [[date2 substringToIndex:4] intValue];
    
    //    NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
    //                                       components:NSYearCalendarUnit
    //                                       fromDate:birthdate
    //                                       toDate:today
    //                                       options:0];
    return age;
}
+(NSString*)getAgoTime:(NSString*)param1 IsGmt:(BOOL)isGmt{
    NSDate*agoDate = [self getDateFromDbString:param1 Gmt:false];
    NSDate*curDate = [NSDate date];
    
    if ([agoDate compare:curDate] != NSOrderedAscending) {
        return @"Just Now";
    }
    
    NSDateComponents *compoenents = [[NSCalendar currentCalendar]  components:NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:agoDate toDate:curDate options:0];
    
    
    NSInteger hour = [compoenents hour];
    NSInteger min = [compoenents minute];
    NSInteger sec = [compoenents second];
    NSString *gmt = [NSString stringWithFormat:@"%d hours %d minutes ago",hour,min];
    if (hour == 0 && min == 0) {
        gmt = @"Just Now";
    }
    
    return gmt;
}
+(NSNumber*)getNumberFromStringForCurrency:(NSString*)formatted_str{
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setCurrencySymbol:@""];
    [numberFormatter setGroupingSeparator:@","];
    [numberFormatter setGroupingSize:3];
    [numberFormatter setMaximumFractionDigits:0];
    return [numberFormatter numberFromString:formatted_str];
}
+(NSString*)getStringFromNumberForCurrency:(NSNumber*)number{
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setCurrencySymbol:@""];
    [numberFormatter setGroupingSeparator:@","];
    [numberFormatter setGroupingSize:3];
    [numberFormatter setMaximumFractionDigits:0];
    return [numberFormatter stringFromNumber:number];
}
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert Alpha:(CGFloat)alpha
{
    NSString *noHashString = [stringToConvert stringByReplacingOccurrencesOfString:@"#" withString:@""]; // remove the #
    NSScanner *scanner = [NSScanner scannerWithString:noHashString];
    [scanner setCharactersToBeSkipped:[NSCharacterSet symbolCharacterSet]]; // remove + and $
    
    unsigned hex;
    if (![scanner scanHexInt:&hex]) return nil;
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:alpha];
}
+ (void)shareText:(NSString *)text andImage:(UIImage *)image andUrl:(NSURL *)url withView:(UIView*)view withController:(UIViewController*)controller
{
    NSMutableArray *sharingItems = [NSMutableArray new];
    
    if (text) {
        [sharingItems addObject:text];
    }
    if (image) {
        [sharingItems addObject:image];
    }
    if (url) {
        [sharingItems addObject:url];
    }
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        activityController.popoverPresentationController.sourceView = view;
    }
    
    [controller presentViewController:activityController animated:YES completion:nil];
}
+ (NSString *)urlencode:(NSString*)param1 {
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[param1 UTF8String];
    int sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

+(NSString*)timeStamp{
    return [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]*1000 ];
}

+(NSTimeInterval)timeStampInterval{
    return [[NSDate date] timeIntervalSince1970];
}
// program specific
+(void)setStyleForInput1:(UIView*)buttonView{
    if (buttonView != nil) {
        if ([buttonView isKindOfClass:[UITextField class]]) {
            UITextField*text = (UITextField*)buttonView;
            [text setTextColor:[self colorWithHexString:@"#0099cc" Alpha:1.0]];
        }else if ([buttonView isKindOfClass:[UIButton class]]) {
            UIButton*text = (UIButton*)buttonView;
            [text setTitleColor:[self colorWithHexString:@"#0099cc" Alpha:1.0] forState:UIControlStateNormal];
        }
        buttonView.layer.borderWidth = 1;
        buttonView.layer.cornerRadius = 6;
        buttonView.layer.borderColor = [[self colorWithHexString:@"#0099cc" Alpha:1.0] CGColor];
        buttonView.layer.masksToBounds = true;
    }
}
+(void)setStyleForInput2:(UIView*)viewRound View:(UIView*)viewtext Radius:(CGFloat)radius{
    if (viewRound != nil) {
        viewRound.layer.cornerRadius =radius;
        viewRound.backgroundColor = [self colorWithHexString:@"#373737" Alpha:1.0];
        viewRound.layer.borderWidth = 0;
        viewRound.layer.masksToBounds = true;
    }
    
    if(viewtext!=nil){
        if ([viewtext isKindOfClass:[UITextField class]]) {
            ((UITextField*)viewtext).textColor = [UIColor whiteColor];
        }else if([viewtext isKindOfClass:[UILabel class]]) {
            ((UILabel*)viewtext).textColor = [UIColor whiteColor];
        }else if([viewtext isKindOfClass:[UITextView class]]) {
            ((UITextView*)viewtext).textColor = [UIColor whiteColor];
        }else if([viewtext isKindOfClass:[CustomTextField class]]) {
            ((CustomTextField*)viewtext).textColor = [UIColor whiteColor];
        }
        viewtext.layer.borderWidth = 0;
        viewtext.layer.masksToBounds = true;
        viewtext.backgroundColor = [UIColor clearColor];
        
    }
}
+(void)setStyleForInput3:(UIView*)viewRound TextField:(UITextField*)textField LeftorRight:(BOOL)isLeft Radius:(CGFloat)radius SelfView:(UIView*)view{
    if (viewRound != nil) {
        if(isLeft){
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:viewRound.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft ) cornerRadii:CGSizeMake(10.0, 10.0)];
            
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = view.bounds;
            maskLayer.path  = maskPath.CGPath;
            viewRound.layer.mask = maskLayer;
        }else{
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:viewRound.bounds byRoundingCorners:(UIRectCornerBottomRight | UIRectCornerTopRight ) cornerRadii:CGSizeMake(10.0, 10.0)];
            
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = view.bounds;
            maskLayer.path  = maskPath.CGPath;
            viewRound.layer.mask = maskLayer;
        }
    }
    
    if(textField!=nil){
        textField.textColor = [UIColor whiteColor];
    }
}

+(NSString*)checkTimeForCreateBid:(NSString*)string{
    NSString*ret = nil;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [formatter setTimeZone:gmt];
    NSDate* suggestTime = [formatter dateFromString:string];
    NSDate* currentDate = [NSDate date];
    
    NSTimeInterval secondsBetween = [currentDate timeIntervalSinceDate:suggestTime];
    
    
    
    NSInteger hour = secondsBetween/(60*60);
    if (hour < 24) {
        NSDate* dateAfter24 = [suggestTime dateByAddingTimeInterval:24*60*60];
        
        secondsBetween = [dateAfter24 timeIntervalSinceDate:currentDate];
        
        NSInteger hour = secondsBetween/(60*60);
        secondsBetween = secondsBetween - hour*(60*60);
        NSInteger min = secondsBetween/(60);
        secondsBetween = secondsBetween - min*(60);
        NSInteger sec = secondsBetween;
        
        ret = [NSString stringWithFormat:@"%02d:%02d:%02d",hour,min,sec];
        
    }
    
    
    return ret;
}
+ (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
{
    
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage*)getScaledImage:(UIImage*)image Source:(UIImagePickerControllerSourceType)sourceType
{
    CGImageRef cgImage =  image.CGImage;
    
    CGFloat width = CGImageGetWidth(cgImage);
    CGFloat height = CGImageGetHeight(cgImage);
    
    if(width<1024){
        return image;
    }else{
        CGFloat newSizeWidth = 1024;
        CGFloat newSizeHeight = 1024;
        
        CGFloat scale = width / 1024.0;
        newSizeHeight = height / scale;
        
        UIDeviceOrientation deviceOrientation = [[UIDevice currentDevice] orientation];
        UIImageOrientation imageOrientation = UIImageOrientationLeft;
        
        int odd = 0;
        if (sourceType == UIImagePickerControllerSourceTypeCamera) {
            switch (deviceOrientation)
            {
                case UIDeviceOrientationPortrait:
                    imageOrientation = UIImageOrientationRight;
                    NSLog(@"UIImageOrientationRight");
                    odd = 1;
                    break;
                case UIDeviceOrientationPortraitUpsideDown:
                    imageOrientation = UIImageOrientationLeft;
                    NSLog(@"UIImageOrientationLeft");
                    odd = 1;
                    break;
                case UIDeviceOrientationLandscapeLeft:
                    imageOrientation = UIImageOrientationUp;
                    NSLog(@"UIImageOrientationUp");
                    
                    break;
                case UIDeviceOrientationLandscapeRight:
                    imageOrientation = UIImageOrientationDown;
                    NSLog(@"UIImageOrientationDown");
                    
                    break;
                default:
                    NSLog(@"Default");
                    imageOrientation = UIImageOrientationRight ;
                    odd = 1;
                    break;
            }
        }else{
            odd = 0;
        }
        
        if (odd == 0) {
            return [CGlobal imageWithImage:image scaledToSize:CGSizeMake(newSizeWidth, newSizeHeight)];
        }else{
            return [CGlobal imageWithImage:image scaledToSize:CGSizeMake(newSizeHeight, newSizeWidth)];
        }
        
        
    }
}

- (UIImage *)image:(UIImage *)image scaledCopyOfSize:(CGSize)newSize {
    
    UIDeviceOrientation deviceOrientation = [[UIDevice currentDevice] orientation];
    UIImageOrientation imageOrientation = UIImageOrientationLeft;
    
    switch (deviceOrientation)
    {
        case UIDeviceOrientationPortrait:
            imageOrientation = UIImageOrientationRight;
            NSLog(@"UIImageOrientationRight");
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            imageOrientation = UIImageOrientationLeft;
            NSLog(@"UIImageOrientationLeft");
            break;
        case UIDeviceOrientationLandscapeLeft:
            imageOrientation = UIImageOrientationUp;
            NSLog(@"UIImageOrientationUp");
            break;
        case UIDeviceOrientationLandscapeRight:
            imageOrientation = UIImageOrientationDown;
            NSLog(@"UIImageOrientationDown");
            break;
        default:
            NSLog(@"Default");
            imageOrientation = UIImageOrientationRight ;
            break;
    }
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > newSize.width || height > newSize.height) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = newSize.width;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = newSize.height;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}

+(NSURL*)urlForPath:(NSString*)param{
    NSURL* url = [NSURL URLWithString:param];
    return url;
}
+(UIImage*)getImageForMap:(UIImage*)bm NSString:(NSString*)number{
    int spellsize = 12;
    UIFont*font = [UIFont fontWithName:@"Helvetica" size:spellsize];
    CGSize textSize = [number sizeWithAttributes:@{NSFontAttributeName:font}];
    CGFloat bw = textSize.width;
    CGFloat bh = textSize.height;
    float radius = 10;
    if (bw<bh) {
        radius = bh/2;
    }else{
        radius = bw/2;
    }
    radius+=5;
    
    int sm,cw,tw,th;
    sm = 1;
    cw = radius;
    tw = 60;
    th = 60;
    int dw = tw - 2*sm - cw;
    int dh = tw - 2*sm-cw;
    int thumb_width = bm.size.width;
    int thumb_height = bm.size.height;
    int realwidth,realheight;
    if (thumb_width>thumb_height){
        realwidth = dw;
        realheight = (int) (((float)realwidth/(float)thumb_width)*thumb_height);
    }else{
        realheight = dh;
        realwidth =  (int) (((float)realheight/(float)thumb_height)*thumb_width);
    }
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(tw,th), NO, 2.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    // drawing with a white stroke color
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    // drawing with a white fill color
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextFillRect(context, CGRectMake(0, cw, sm*2+dw, th));
    
    int cx = (dw-realwidth)/2+sm,cy = (dh-realheight)/2+sm+cw;
    CGRect dst = CGRectMake(cx,cy,realwidth,realheight);
    [bm drawInRect:dst];
    
    if ([number intValue] > 1) {
        CGRect circle_rect = CGRectMake(tw-cw*2, 0, 2*cw, 2*cw);
        CGContextSetRGBFillColor(context, 0.29, 0.60, 0.85,1.0);
        CGContextFillEllipseInRect(context, circle_rect);
        
        CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
        NSDictionary* dict =  [NSDictionary dictionaryWithObjectsAndKeys:
                               font, NSFontAttributeName,
                               [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName, nil];
        
        CGRect text_rect = CGRectMake((circle_rect.size.width-bw)/2+circle_rect.origin.x,(circle_rect.size.height-bh)/2+circle_rect.origin.y,bw,bh);
        [number drawInRect:text_rect withAttributes:dict];
    }
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}
+(UIImage*)drawFront:(UIImage*)image text:(NSString*)text atPoint:(CGPoint)point
{
    UIFont *font = [UIFont fontWithName:@"Halter" size:21];
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    CGRect rect = CGRectMake(point.x, (point.y - 5), image.size.width, image.size.height);
    [[UIColor whiteColor] set];
    
    NSMutableAttributedString* attString = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange range = NSMakeRange(0, [attString length]);
    
    [attString addAttribute:NSFontAttributeName value:font range:range];
    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:range];
    
    NSShadow* shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor darkGrayColor];
    shadow.shadowOffset = CGSizeMake(1.0f, 1.5f);
    [attString addAttribute:NSShadowAttributeName value:shadow range:range];
    
    [attString drawInRect:CGRectIntegral(rect)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+(NSMutableDictionary*)getQuestionDict:(id)targetClass{
    unsigned int numberOfProperties = 0;
    objc_property_t *propertyArray = class_copyPropertyList([targetClass class], &numberOfProperties);
    
    NSMutableArray *objects = [[NSMutableArray alloc] init];
    NSMutableArray *keys = [[NSMutableArray alloc] init];
    NSMutableDictionary *questionDict;
    
    for (NSUInteger i = 0; i < numberOfProperties; i++)
    {
        objc_property_t property = propertyArray[i];
        NSString *name = [[NSString alloc] initWithUTF8String:property_getName(property)];
        //NSString *attributesString = [[NSString alloc] initWithUTF8String:property_getAttributes(property)];
        NSString* value = [targetClass valueForKey:name];
        if (value!=nil && [value isKindOfClass:[NSString class]]) {
            [objects addObject:value];
            [keys addObject:name];
        }
        //NSLog(@"Property %@ attributes: %@", name, name);
    }
    free(propertyArray);
    if ([objects count] > 0) {
        questionDict = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    }
    
    return questionDict;
}


+(void)parseResponse:(id)targetClass Dict:(NSDictionary*)dict{
    unsigned int numberOfProperties = 0;
    objc_property_t *propertyArray = class_copyPropertyList([targetClass class], &numberOfProperties);
    
    for (NSUInteger i = 0; i < numberOfProperties; i++)
    {
        objc_property_t property = propertyArray[i];
        NSString *name = [[NSString alloc] initWithUTF8String:property_getName(property)];
        //NSString *attributesString = [[NSString alloc] initWithUTF8String:property_getAttributes(property)];
        id value = [dict objectForKey:name];
        
        if (value!=nil && [value isKindOfClass:[NSString class]] && value != [NSNull null] ) {
            [targetClass setValue:value forKey:name];
        }
        //NSLog(@"Property %@ attributes: %@", name, name);
    }
    free(propertyArray);
    
    
}

+(NSData*)buildJsonData:(id)targetClass{
    NSData* jsonData = nil;
    
    unsigned int numberOfProperties = 0;
    objc_property_t *propertyArray = class_copyPropertyList([targetClass class], &numberOfProperties);
    
    NSMutableArray *objects = [[NSMutableArray alloc] init];
    NSMutableArray *keys = [[NSMutableArray alloc] init];
    NSMutableDictionary *questionDict;
    
    for (NSUInteger i = 0; i < numberOfProperties; i++)
    {
        objc_property_t property = propertyArray[i];
        NSString *name = [[NSString alloc] initWithUTF8String:property_getName(property)];
        //NSString *attributesString = [[NSString alloc] initWithUTF8String:property_getAttributes(property)];
        NSString* value = [targetClass valueForKey:name];
        if (value!=nil && [value isKindOfClass:[NSString class]]) {
            [objects addObject:value];
            [keys addObject:name];
        }
        //NSLog(@"Property %@ attributes: %@", name, name);
    }
    free(propertyArray);
    if ([objects count] > 0) {
        questionDict = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * error = nil;
        jsonData = [NSJSONSerialization dataWithJSONObject:questionDict options:NSJSONWritingPrettyPrinted error:&error];
        
        
        
    }
    
    return jsonData;
}
+(id)getDuplicate:(id)targetClass{
    
    id ret = [[targetClass class] alloc];
    
    unsigned int numberOfProperties = 0;
    objc_property_t *propertyArray = class_copyPropertyList([targetClass class], &numberOfProperties);
    
    for (NSUInteger i = 0; i < numberOfProperties; i++)
    {
        objc_property_t property = propertyArray[i];
        NSString *name = [[NSString alloc] initWithUTF8String:property_getName(property)];
        //NSString *attributesString = [[NSString alloc] initWithUTF8String:property_getAttributes(property)];
        NSString* value = [targetClass valueForKey:name];
        if (value!=nil && [value isKindOfClass:[NSString class]]) {
            [ret setValue:value forKey:name];
        }
        //NSLog(@"Property %@ attributes: %@", name, name);
    }
    free(propertyArray);
    
    return ret;
}
+ (UIImage *)scaleAndRotateImage:(UIImage *)image {
    
    int kMaxResolution = 1600; // Or whatever
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = roundf(bounds.size.width / ratio);
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = roundf(bounds.size.height * ratio);
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}
+ (UIImage *)ipMaskedImageNamed:(NSString *)name color:(UIColor *)color
{
    UIImage *image = [UIImage imageNamed:name];
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, image.scale);
    CGContextRef c = UIGraphicsGetCurrentContext();
    [image drawInRect:rect];
    CGContextSetFillColorWithColor(c, [color CGColor]);
    CGContextSetBlendMode(c, kCGBlendModeSourceAtop);
    CGContextFillRect(c, rect);
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}
+ (CGSize)getSizeForAspect:(UIImage*)image Frame:(CGSize)frame{
    CGSize size = frame;
    CGImageRef cgImage =  image.CGImage;
    
    CGFloat width = CGImageGetWidth(cgImage);
    CGFloat height = CGImageGetHeight(cgImage);
    
    CGFloat retWidth = size.width;
    
    CGFloat retHeight = retWidth/width*height;
    
    return CGSizeMake(retWidth, retHeight);
}
+ (CGSize)getSizeForAspectFromSize:(CGSize)imageSize Frame:(CGSize)frame{
    CGSize size = frame;
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat retWidth = size.width;
    
    CGFloat retHeight = retWidth/width*height;
    
    return CGSizeMake(retWidth, retHeight);
}
+(void)grantedPermissionCamera:(PermissionCallback)callback{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusAuthorized) {
        callback(true);
        return;
        // do your logic
    }else if(authStatus ==AVAuthorizationStatusNotDetermined){
        [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
            callback(granted);
        }];
        return;
    }
    else{
        callback(false);
        return;
    }
}
+(void)grantedPermissionPhotoLibrary:(PermissionCallback)callback{
    if([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized){
        callback(true);
        return;
    }else if([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusNotDetermined){
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            callback(status);
            return;
        }];
        return;
    }else{
        callback(false);
        return;
    }
}
+(void)grantedPermissionLocation:(PermissionCallback)callback{
    CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
    
    if (authorizationStatus == kCLAuthorizationStatusAuthorized ||
        authorizationStatus == kCLAuthorizationStatusAuthorizedAlways ||
        authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        
        callback(true);
        return;
        
    }else if(authorizationStatus == kCLAuthorizationStatusNotDetermined){
        CLLocationManager * manager = [[CLLocationManager alloc] init];
        [manager requestAlwaysAuthorization];
    }
}
+(UIImage*)getImageForMap:(NSString*)number{
    int spellsize = 12;
    UIFont*font = [UIFont fontWithName:@"Helvetica" size:spellsize];
    CGSize textSize = [number sizeWithAttributes:@{NSFontAttributeName:font}];
    CGFloat bw = textSize.width;
    CGFloat bh = textSize.height;
    UIImage*bm = [UIImage imageNamed:@"map_pos.png"];
    float radius = 10;
    if (bw<bh) {
        radius = bh/2;
    }else{
        radius = bw/2;
    }
    //radius+=5;
    
    int sm,cw,tw,th;
    sm = 1;
    cw = radius;
    tw = 40;
    th = 60;
    CGPoint A = CGPointMake(5, 5);
    CGPoint B = CGPointMake(35, 35);
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(tw,th), NO, 2.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    // drawing with a white stroke color
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    // drawing with a white fill color
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    //    CGContextFillRect(context, CGRectMake(0, cw, sm*2+dw, th));
    
    CGRect dst = CGRectMake(0,0,tw,th);
    [bm drawInRect:dst];
    
    if ([number intValue] >= 1) {
        CGRect circle_rect = CGRectMake(A.x, A.y, B.x-A.x, B.y-A.y);
        CGContextSetRGBFillColor(context, 0.29, 0.60, 0.85,1.0);
        CGContextFillEllipseInRect(context, circle_rect);
        
        CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
        NSDictionary* dict =  [NSDictionary dictionaryWithObjectsAndKeys:
                               font, NSFontAttributeName,
                               [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName, nil];
        
        CGRect text_rect = CGRectMake((circle_rect.size.width-bw)/2+circle_rect.origin.x,(circle_rect.size.height-bh)/2+circle_rect.origin.y,bw,bh);
        [number drawInRect:text_rect withAttributes:dict];
    }
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}
+(UIImage*)getColoredImage:(NSString*)imgName Color:(UIColor*)color{
    UIImage *image = [UIImage imageNamed:imgName];
    
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage
                                                scale:1.0 orientation: UIImageOrientationDownMirrored];
    
    return flippedImage;
}
+(UIImage*)getColoredImageFromImage:(UIImage*)image Color:(UIColor*)color{
    
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage
                                                scale:1.0 orientation: UIImageOrientationDownMirrored];
    
    return flippedImage;
}
+(void) setTerm:(TTTAttributedLabel*)attributedLabel{
    NSString *labelText = attributedLabel.text;
    
    NSRange r = [labelText rangeOfString:@"Terms of Use"];
    attributedLabel.linkAttributes = @{NSForegroundColorAttributeName: [CGlobal colorWithHexString:@"66cce2" Alpha:1.0],
                                       NSUnderlineStyleAttributeName: @(NSUnderlineStyleNone)};
    [attributedLabel addLinkToURL:[NSURL URLWithString:@"weinsahra.com/tos"] withRange:r];
}
+(BOOL) isValidEmail:(NSString*)email
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
+(NSString *) escapeString:(NSString *)string {
    NSRange range = NSMakeRange(0, [string length]);
    return [string stringByReplacingOccurrencesOfString:@"'" withString:@"''" options:NSCaseInsensitiveSearch range:range];
}
+(NSString*) getDateString:(NSInteger)offset{
    NSDate* date = [NSDate date];
    NSTimeInterval off_interval = 24*60*60 * offset;
    date = [date dateByAddingTimeInterval:off_interval];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone* sourceTimeZone = [NSTimeZone systemTimeZone];
    [dateFormat setTimeZone:sourceTimeZone];
    
    NSString *datestr = [dateFormat stringFromDate:date];
    return datestr;
}
+(int)getLastFileNumber{
    EnvVar* env = [CGlobal sharedId].env;
    NSString* prefix = [NSString stringWithFormat:@"quiz_%@",env.username];
    int max = 0;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*sourcePath = [paths objectAtIndex:0];
    sourcePath = [sourcePath stringByAppendingPathComponent:@"log"];
    NSArray* dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:sourcePath
                                                                        error:NULL];
    NSMutableArray *files = [[NSMutableArray alloc] init];
    [dirs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *filename = (NSString *)obj;
        NSString *extension = [[filename pathExtension] lowercaseString];
        
        if ([extension isEqualToString:@"csv"] && [filename hasPrefix:prefix]) {
            NSRange range = NSMakeRange([prefix length], [filename length] - 4 - [prefix length]);
            NSString*number = [filename substringWithRange:range];
            
            int num = [number intValue];
            [files addObject:[NSNumber numberWithInt:num]];
        }
    }];
    
    for (int i=0; i< files.count; i++) {
        NSNumber *number = files[i];
        if (max<[number intValue]){
            max = [number intValue];
        }
    }
    return max;
}
+(NSString*)getFileName:(int)max Mode:(int)mode{
    EnvVar* env = [CGlobal sharedId].env;
    NSString* uname = env.username;
    if (mode == 1) {
        NSString* name = [NSString stringWithFormat:@"quiz_%@%06d.csv",uname,max];
        NSString* zipfile = [self getFileFullPath:name];
        return zipfile;
    }else{
        NSString* name = [NSString stringWithFormat:@"quiz_%@%06d.csv",uname,max];
        return name;
    }
}
+(TblGraph*)getTblGraphFromQuizModel:(NSMutableArray*)quizResult DicResult:(NSMutableArray*)dicsResult{
    TblGraph* tblGraph = nil;
    @try {
        NSString* contents = @"";
        contents = [NSString stringWithFormat:@"%@\n",g_head1];
        
        for (int i=0; i< quizResult.count; i++) {
            QuizResult* result = quizResult[i];
            NSString* genresult = @"";
            if (result.result) {
                genresult = @"TRUE";
            }else{
                genresult = @"FALSE";
            }
            NSString* line = @"";
            if (i == quizResult.count-1) {
                line = [NSString stringWithFormat:@"%@,%@,%d,%@,%@,%@,%d,%@",result.GSR5,result.GSR7,result.selectedPos+1,result.GSR10,result.GSR12,result.GSR15,result.RandomPos+1,genresult];
                
                
            }else{
                line = [NSString stringWithFormat:@"%@,%@,%d,%@,%@,%@,%d,%@\n",result.GSR5,result.GSR7,result.selectedPos+1,result.GSR10,result.GSR12,result.GSR15,result.RandomPos+1,genresult];
            }
            contents = [contents stringByAppendingString:line];
        }
        if (dicsResult.count>0) {
            NSString* line = [NSString stringWithFormat:@"\n%@\n",g_head2];
            contents = [contents stringByAppendingString:line];
            
            for (int i=0; i< dicsResult.count; i++) {
                QuizResult* result = dicsResult[i];
                NSString* genresult = @"";
                if (result.result) {
                    genresult = @"TRUE";
                }else{
                    genresult = @"FALSE";
                }
                NSString* line = @"";
                if (i == dicsResult.count-1) {
                    line = [NSString stringWithFormat:@"%@,%@,%d,%@,%@,%@,%@,%@",result.GSR5,result.GSR7,result.selectedPos+1,result.GSR10,@"",@"",@"",@""];
                    
                    
                }else{
                    line = [NSString stringWithFormat:@"%@,%@,%d,%@,%@,%@,%@,%@\n",result.GSR5,result.GSR7,result.selectedPos+1,result.GSR10,@"",@"",@"",@""];
                }
                contents = [contents stringByAppendingString:line];
            }
        }
        
        NSArray* data = [CGlobal getGraphRowData:quizResult];
        NSNumber* score = data[2];
        QuizResult *data_f = data[0];
        QuizResult *data_t = data[1];
        
        TblGraph* temp = [[TblGraph alloc] init];
        temp.tg_content = contents;
        temp.tg_score = [NSString stringWithFormat:@"%.2f",[score floatValue]];
        
        if([CGlobal quizValid:data_f Data:data_t List:nil]){
            temp.tg_valid = @"yes";
        }else{
            temp.tg_valid = @"no";
        }
        
        
        tblGraph = temp;
    } @catch (NSException *exception) {
        tblGraph = tblGraph;
    }
    
    
    return tblGraph;
}
+(BOOL)saveExcelFile:(NSString*)fileName Result:(NSMutableArray*)quizResult DicResult:(NSMutableArray*)dicsResult{
    BOOL success = true;
    NSString* contents = @"";
    contents = [NSString stringWithFormat:@"%@\n",g_head1];
    
    for (int i=0; i< quizResult.count; i++) {
        QuizResult* result = quizResult[i];
        NSString* genresult = @"";
        if (result.result) {
            genresult = @"TRUE";
        }else{
            genresult = @"FALSE";
        }
        NSString* line = @"";
        if (i == quizResult.count-1) {
            line = [NSString stringWithFormat:@"%@,%@,%d,%@,%@,%@,%d,%@",result.GSR5,result.GSR7,result.selectedPos+1,result.GSR10,result.GSR12,result.GSR15,result.RandomPos+1,genresult];
            
            
        }else{
            line = [NSString stringWithFormat:@"%@,%@,%d,%@,%@,%@,%d,%@\n",result.GSR5,result.GSR7,result.selectedPos+1,result.GSR10,result.GSR12,result.GSR15,result.RandomPos+1,genresult];
        }
        contents = [contents stringByAppendingString:line];
    }
    if (dicsResult.count>0) {
        NSString* line = [NSString stringWithFormat:@"\n%@\n",g_head2];
        contents = [contents stringByAppendingString:line];
        
        for (int i=0; i< dicsResult.count; i++) {
            QuizResult* result = dicsResult[i];
            NSString* genresult = @"";
            if (result.result) {
                genresult = @"TRUE";
            }else{
                genresult = @"FALSE";
            }
            NSString* line = @"";
            if (i == dicsResult.count-1) {
                line = [NSString stringWithFormat:@"%@,%@,%d,%@,%@,%@,%@,%@",result.GSR5,result.GSR7,result.selectedPos+1,result.GSR10,@"",@"",@"",@""];
                
                
            }else{
                line = [NSString stringWithFormat:@"%@,%@,%d,%@,%@,%@,%@,%@\n",result.GSR5,result.GSR7,result.selectedPos+1,result.GSR10,@"",@"",@"",@""];
            }
            contents = [contents stringByAppendingString:line];
        }
    }
    NSError* err;
    
    NSString*filepath = [self getFileFullPath:fileName];
    
    NSData * data = [contents dataUsingEncoding:NSUTF8StringEncoding];
    [[NSFileManager defaultManager] createFileAtPath:filepath contents:data attributes:nil];
//    [contents writeToFile:fileName atomically:YES encoding:NSUnicodeStringEncoding error:&err];
    
    return success;
}
+(NSString*)getFileFullPath:(NSString*)filename{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*sourcePath = [paths objectAtIndex:0];
    NSString* zipfile = [sourcePath stringByAppendingPathComponent:@"log"];
    BOOL isDir = false;
    NSError* err;
    if([[NSFileManager defaultManager] fileExistsAtPath:zipfile isDirectory:&isDir]== false){
        [[NSFileManager defaultManager] createDirectoryAtPath:zipfile withIntermediateDirectories:YES attributes:nil error:&err];
    };
    zipfile = [zipfile stringByAppendingPathComponent:filename];
    return zipfile;
}
+(NSMutableDictionary*)readExcelFile:(NSString*)fileName{
    NSMutableDictionary* ret = nil;
    NSMutableArray* resultList= [[NSMutableArray alloc] init];
    NSMutableArray* dicList = [[NSMutableArray alloc] init];
    
    NSString* zipfile = [self getFileFullPath:fileName];
    
    NSError* err;
    NSString* contents = [NSString stringWithContentsOfFile:zipfile encoding:NSUTF8StringEncoding error:&err];
    NSMutableArray* data = [[contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] mutableCopy];
    int curHead = 1;
    
    for (int i=0; i<data.count; i++) {
        NSString*line = data[i];
        NSArray* pieces = [line componentsSeparatedByString:@","];
        int head = [self checkHead:line];
        if (head!=0) {
            curHead = head;
            continue;
        }
        @try {
            switch (curHead) {
                case 1:
                {
                    QuizResult* result = [[QuizResult alloc] init];
                    result.GSR5 = pieces[0];
                    result.GSR7 = pieces[1];
                    result.selectedPos = [pieces[2] intValue] -1;
                    result.GSR10 = pieces[3];
                    result.GSR12 = pieces[4];
                    result.GSR15 = pieces[5];
                    result.RandomPos = [pieces[6] intValue] - 1;
                    [result genResult];
                    [resultList addObject:result];
                    break;
                }
                case 2:
                {
                    QuizResult* result = [[QuizResult alloc] init];
                    result.GSR5 = pieces[0];
                    result.GSR7 = pieces[1];
                    result.selectedPos = [pieces[2] intValue] -1;
                    result.GSR10 = pieces[3];
                    [dicList addObject:result];
                    break;
                }
                default:
                    break;
            }
        } @catch (NSException *exception) {
            NSLog(@"Exception%@",@"err");
        }
        
    }
    NSURL* fileURL = [NSURL fileURLWithPath:zipfile];
    NSDate* lastModeDate;
    err = nil;
    [fileURL getResourceValue:&lastModeDate forKey:NSURLContentModificationDateKey error:&err];
    if (!err) {
        NSMutableArray* arrayList = [self getGraphRowData:resultList];
        if (arrayList!=nil) {
            [arrayList addObject:lastModeDate];
            [arrayList addObject:fileName];
            
            NSMutableDictionary* ret = [[NSMutableDictionary alloc] init];
            ret[@"incorrect"] = arrayList[0];
            ret[@"correct"] = arrayList[1];
            ret[@"date"] = lastModeDate;
            ret[@"filename"] = fileName;
            if (dicList.count > 0) {
                QuizResult* quizResult = [self getGraphRowDataDic:dicList];
                ret[@"dics"] = quizResult;
            }
//            QuizResult* data_f = arrayList[0];
//            QuizResult* data_t = arrayList[1];
            
//            if ([self quizValid:data_f Data:data_t]) {
//                NSLog(@"VVVVVVVVVVVVVALID%@",fileName);
//            }else{
//                NSLog(@"IIIIIIIIIIIIIVALID%@",fileName);
//            }
            return ret;
        }
    }
    
    return ret;
}
+(NSMutableDictionary*)readFromTblGraph:(TblGraph*)tblGraph{
    NSMutableDictionary* ret = nil;
    NSMutableArray* resultList= [[NSMutableArray alloc] init];
    NSMutableArray* dicList = [[NSMutableArray alloc] init];
    
    NSString* contents = tblGraph.tg_content;
    NSMutableArray* data = [[contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] mutableCopy];
    int curHead = 1;
    
    for (int i=0; i<data.count; i++) {
        NSString*line = data[i];
        NSArray* pieces = [line componentsSeparatedByString:@","];
        int head = [self checkHead:line];
        if (head!=0) {
            curHead = head;
            continue;
        }
        @try {
            switch (curHead) {
                case 1:
                {
                    QuizResult* result = [[QuizResult alloc] init];
                    result.GSR5 = pieces[0];
                    result.GSR7 = pieces[1];
                    result.selectedPos = [pieces[2] intValue] -1;
                    result.GSR10 = pieces[3];
                    result.GSR12 = pieces[4];
                    result.GSR15 = pieces[5];
                    result.RandomPos = [pieces[6] intValue] - 1;
                    [result genResult];
                    [resultList addObject:result];
                    break;
                }
                case 2:
                {
                    QuizResult* result = [[QuizResult alloc] init];
                    result.GSR5 = pieces[0];
                    result.GSR7 = pieces[1];
                    result.selectedPos = [pieces[2] intValue] -1;
                    result.GSR10 = pieces[3];
                    [dicList addObject:result];
                    break;
                }
                default:
                    break;
            }
        } @catch (NSException *exception) {
            NSLog(@"Exception%@",@"err");
        }
        
    }
    NSDate* lastModeDate = [CGlobal getDateFromDbString:tblGraph.create_datetime Gmt:true];
    NSMutableArray* arrayList = [self getGraphRowData:resultList];
    if (arrayList!=nil) {
        [arrayList addObject:lastModeDate];
        [arrayList addObject:tblGraph.tg_filename];
        
        NSMutableDictionary* ret = [[NSMutableDictionary alloc] init];
        ret[@"incorrect"] = arrayList[0];
        ret[@"correct"] = arrayList[1];
        ret[@"date"] = lastModeDate;
        ret[@"filename"] = tblGraph.tg_filename;
        ret[@"tblGraph"] = tblGraph;
        ret[@"resultList"] = resultList;
        if (dicList.count > 0) {
            QuizResult* quizResult = [self getGraphRowDataDic:dicList];
            ret[@"dics"] = quizResult;
        }
        return ret;
    }
    
    return ret;
}
+(BOOL)quizValid:(QuizResult*)data_f Data:(QuizResult*)data_t List:(NSMutableArray*)resultList{

    BOOL direction = true; //
    BOOL ret = true;
    //  true    f_value < t_value
    //  false
    
    NSArray* f_str = nil;
    NSArray* t_str = nil;
    
    @try {
        f_str = @[data_f.GSR5,data_f.GSR7,data_f.GSR10,data_f.GSR7,data_f.GSR7];
        t_str = @[data_t.GSR5,data_t.GSR7,data_t.GSR10,data_t.GSR7,data_t.GSR7];
    } @catch (NSException *exception) {
        return true;
    }
    
    
    for (int i=0; i<f_str.count; i++){
        double f_value = [f_str[i] doubleValue];
        double t_value = [t_str[i] doubleValue];
        if (i == 0){
            if (f_value < t_value){
                direction = true;
            }else{
                direction = false;
            }
        }else{
            if (direction){
                if (f_value > t_value){
                    ret = false;
                    break;
                }
            }else{
                if (f_value < t_value){
                    ret = false;
                    break;
                }
            }
        }
    }
    return ret;
    
//    NSArray* f_str = nil;
//    NSArray* t_str = nil;
//    
//    @try {
//        f_str = @[[NSNumber numberWithDouble:[data_f.GSR5 doubleValue]],
//                  [NSNumber numberWithDouble:[data_f.GSR7 doubleValue]],
//                  [NSNumber numberWithDouble:[data_f.GSR10 doubleValue]],
//                  [NSNumber numberWithDouble:[data_f.GSR12 doubleValue]],
//                  [NSNumber numberWithDouble:[data_f.GSR15 doubleValue]]];
//        t_str = @[[NSNumber numberWithDouble:[data_t.GSR5 doubleValue]],
//                  [NSNumber numberWithDouble:[data_t.GSR7 doubleValue]],
//                  [NSNumber numberWithDouble:[data_t.GSR10 doubleValue]],
//                  [NSNumber numberWithDouble:[data_t.GSR12 doubleValue]],
//                  [NSNumber numberWithDouble:[data_t.GSR15 doubleValue]]];
//        
//    } @catch (NSException *exception) {
//        return true;
//    }
//    Statistics *f_set = [[Statistics alloc] init];
//    f_set.dataSet = f_str;
//    
//    Statistics *t_set = [[Statistics alloc] init];
//    t_set.dataSet = t_str;
//    
//    double n1 = f_str.count;
//    double n2 = t_str.count;
//    
//    double x1 = [f_set getMean];
//    double x2 = [t_set getMean];
//    
//    double s1 = [f_set getVariance];
//    double s2 = [t_set getVariance];
//    
//    double temp1 =  sqrt(s1/n1 + s2/n2);
//    double t = (x1-x2)/temp1;
//    NSLog(@"t-test %f",t);
//    if (t<0.05){
//        return true;
//    }else{
//        return false;
//    }
    
}
+(QuizResult*)getGraphRowDataDic:(NSMutableArray*)resultList{
    @try {
        float gsr5_f = 0, gsr7_f = 0, gsr10_f = 0, gsr12_f = 0, gsr15_f = 0;
        float gsr5_t = 0, gsr7_t = 0, gsr10_t = 0, gsr12_t = 0, gsr15_t = 0;
        float cnt_f = 0;
        float cnt_t = 0;
        for (int i = 0; i < resultList.count; i++) {
            QuizResult *idata = resultList[i];
            gsr5_t = gsr5_t + [idata.GSR5 floatValue];
            gsr7_t = gsr7_t + [idata.GSR7 floatValue];
            gsr10_t = gsr10_t + [idata.GSR10 floatValue];
            gsr12_t = gsr12_t + [idata.GSR12 floatValue];
            gsr15_t = gsr15_t + [idata.GSR15 floatValue];
            cnt_t = cnt_t + 1;
        }
        QuizResult *data_t = [[QuizResult alloc] init];
        
        if (cnt_t > 0) {
            data_t.GSR5 = [NSString stringWithFormat:@"%.4f", gsr5_t / cnt_t];
            data_t.GSR7 = [NSString stringWithFormat:@"%.4f", gsr7_t / cnt_t];
            data_t.GSR10 = [NSString stringWithFormat:@"%.4f", gsr10_t / cnt_t];
            data_t.GSR12 = [NSString stringWithFormat:@"%.4f", gsr12_t / cnt_t];
            data_t.GSR15 = [NSString stringWithFormat:@"%.4f", gsr15_t / cnt_t];
        }
        
        data_t.nCount = cnt_t;
        return data_t;
    } @catch (NSException *exception) {
        
    }
    return nil;
}
+(NSMutableArray*)getGraphRowData:(NSMutableArray*)resultList{
    NSMutableArray*arrayList = [[NSMutableArray alloc] init];
    @try {
        float gsr5_f = 0, gsr7_f = 0, gsr10_f = 0, gsr12_f = 0, gsr15_f = 0;
        float gsr5_t = 0, gsr7_t = 0, gsr10_t = 0, gsr12_t = 0, gsr15_t = 0;
        float cnt_f = 0;
        float cnt_t = 0;
        for (int i = 0; i < resultList.count; i++) {
            QuizResult *idata = resultList[i];
            if (idata.result) {
                gsr5_t = gsr5_t +   [idata.GSR5 floatValue];
                gsr7_t = gsr7_t + [idata.GSR7 floatValue];
                gsr10_t = gsr10_t + [idata.GSR10 floatValue];
                gsr12_t = gsr12_t + [idata.GSR12 floatValue];
                gsr15_t = gsr15_t + [idata.GSR15 floatValue];
                cnt_t = cnt_t + 1;
            } else {
                gsr5_f = gsr5_f + [idata.GSR5 floatValue];
                gsr7_f = gsr7_f + [idata.GSR7 floatValue];
                gsr10_f = gsr10_f + [idata.GSR10 floatValue];
                gsr12_f = gsr12_f + [idata.GSR12 floatValue];
                gsr15_f = gsr15_f + [idata.GSR15 floatValue];
                cnt_f = cnt_f + 1;
            }
        }
        QuizResult *data_f = [[QuizResult alloc] init];
        QuizResult *data_t = [[QuizResult alloc] init];
        
        if (cnt_t > 0) {
            data_t.GSR5 = [NSString stringWithFormat:@"%.4f",gsr5_t / cnt_t];
            data_t.GSR7 = [NSString stringWithFormat:@"%.4f", gsr7_t / cnt_t];
            data_t.GSR10 = [NSString stringWithFormat:@"%.4f", gsr10_t / cnt_t];
            data_t.GSR12 = [NSString stringWithFormat:@"%.4f", gsr12_t / cnt_t];
            data_t.GSR15 = [NSString stringWithFormat:@"%.4f", gsr15_t / cnt_t];
        } else {
            //                data_t = null;
        }
        
        if (cnt_f > 0) {
            data_f.GSR5 = [NSString stringWithFormat:@"%.4f", gsr5_f / cnt_f];
            data_f.GSR7 = [NSString stringWithFormat:@"%.4f", gsr7_f / cnt_f];
            data_f.GSR10 = [NSString stringWithFormat:@"%.4f", gsr10_f / cnt_f];
            data_f.GSR12 = [NSString stringWithFormat:@"%.4f", gsr12_f / cnt_f];
            data_f.GSR15 = [NSString stringWithFormat:@"%.4f", gsr15_f / cnt_f];
        } else {
            //                data_f = null;
        }
        
        data_f.nCount = cnt_f;
        data_t.nCount = cnt_t;
        [arrayList addObject:data_f];
        [arrayList addObject:data_t];
        
        float score = fabsf([data_t.GSR5 floatValue] + [data_t.GSR7 floatValue] + [data_t.GSR10 floatValue] - [data_f.GSR5 floatValue] - [data_f.GSR7 floatValue] - [data_f.GSR10 floatValue])/3;
        [arrayList addObject:[NSNumber numberWithFloat:score]];
        
        return arrayList;
    } @catch (NSException *exception) {
        
    }
    
    return nil;
}
+(int)checkHead:(NSString*)line{
    if ([line isEqualToString:g_head1]) {
        return 1;
    }else if([line isEqualToString:g_head2]){
        return 2;
    }
    return 0;
}
+(BarChartDataSet*)getBarDataSet:(NSMutableArray*)list{
    NSMutableArray<ChartDataEntry*> *yVals1 = [[NSMutableArray alloc] init];
    int pos = 0;
    int length = g_length; // 15
    for (int j=0; j<length; j++) {
        BarChartDataEntry* val = [[BarChartDataEntry alloc] initWithX:pos y:0.0f];
        [yVals1 addObject:val];
        pos++;
    }
    for (int i=0; i< [list count]; i++) {
        TblGraph* graph = list[i];
        if ([graph.tg_valid isEqualToString:@"yes"]) {
            BarChartDataEntry* val = [[BarChartDataEntry alloc] initWithX:pos y:[graph.tg_score floatValue]];
            val.data = graph;
            [yVals1 addObject:val];
            pos++;
            
            if (i == list.count - 1) {
                break;
            }
            TblGraph* nextGraph = list[i+1];
            for (int j=0;j<g_scale;j++){
                BarChartDataEntry* val = [[BarChartDataEntry alloc] initWithX:pos y:0.0f];
                [yVals1 addObject:val];
                if (j<g_scale/2){
                    val.data = graph;
                }else{
                    val.data = nextGraph;
                }
                pos++;
            }
        }
//        else{
//            BarChartDataEntry* val = [[BarChartDataEntry alloc] initWithX:pos y:0.0f];
//            val.data = graph;
//            [yVals1 addObject:val];
//        }
        
    }
    for (int j=0; j<g_length; j++) {
        BarChartDataEntry* val = [[BarChartDataEntry alloc] initWithX:pos y:0.0f];
        [yVals1 addObject:val];
        pos++;
    }
    if (yVals1.count>0) {
        BarChartDataSet *set1;
        UIColor* clr_t = [CGlobal colorWithHexString:@"58b1f8" Alpha:1.0f];
        set1 = [[BarChartDataSet alloc] initWithValues:yVals1 label:@""];
        [set1 setColor:clr_t];
        [set1 setValueTextColor:[UIColor lightGrayColor]];
        
        
        
        [set1 setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:7.f]];
        
        MyAxisValueFormatter* formatter = [[MyAxisValueFormatter alloc] init];
        formatter.dataLength = list.count;
        [set1 setValueFormatter:formatter];
                
        return set1;
    }
    return nil;
}
+(NSArray*)drawGraph:(BarChartView*)mChart Result:(NSMutableArray*)list{
    long size = (list.count - 1)*(g_scale+1);
    if (size<9) {
        g_length = 6;
    }else{
        if (size%2 == 0) {
            g_length = (int)(size + 1);
        }else {
            g_length = (int)(size);
        }
    }
    NSMutableArray<id<IChartDataSet>>* temp_list = [[NSMutableArray alloc] init];
    NSArray<id<IChartDataSet>>* dataList =nil;
    ChartDataSet* set1 = [self getBarDataSet:list];
    if (set1!=nil) {        [temp_list addObject:set1];    }
    
    dataList = [[NSArray alloc] initWithArray:temp_list];
    
    // create a data object with the datasets
    BarChartData* data = [[BarChartData alloc] initWithDataSets:dataList];
    UIFont* font = [UIFont systemFontOfSize:10.0f];
    [data setValueFont:font];
    
    mChart.data = data;
    [mChart setBackgroundColor:[UIColor whiteColor]];
    [mChart.leftAxis setDrawGridLinesEnabled:false];
    [mChart.rightAxis setDrawGridLinesEnabled:false];
    [mChart.leftAxis setDrawLimitLinesBehindDataEnabled:false];
    [mChart.xAxis setDrawGridLinesEnabled:false];
    [mChart.leftAxis setDrawAxisLineEnabled:false]; //  true
    [mChart.rightAxis setDrawAxisLineEnabled:false];
    [mChart.leftAxis setAxisLineColor:[UIColor whiteColor]];
    
    ChartDescription * description = [[ChartDescription alloc] init];
    description.text = @"";
    mChart.chartDescription = description;
    [mChart.leftAxis setDrawLabelsEnabled:false];
    [mChart.rightAxis setDrawLabelsEnabled:false];
    [mChart.xAxis setDrawLabelsEnabled:false];
    [mChart.xAxis setLabelPosition:XAxisLabelPositionBottom];
    [mChart.xAxis setEnabled:false];        // true
    [mChart.xAxis setAxisLineColor:[UIColor whiteColor]];
    
    mChart.scaleXEnabled = false;
    mChart.scaleYEnabled = false;
    mChart.pinchZoomEnabled = false;
    mChart.backgroundColor = [UIColor clearColor];
    
    
    
//        mChart.setClickable(false);
    //    mChart.setFocusable(false);
    //    mChart.setTouchEnabled(false);
    //    mChart.setBackgroundColor(Color.TRANSPARENT);
    
//    [mChart.data setHighlightEnabled:false];
    //    [mChart moveViewToX:0.0f];
    //    [mChart.xAxis setLabelCount:10 force:false];
    
    [mChart.legend setPosition:ChartLegendPositionAboveChartRight];
    [mChart.legend setEnabled:false];
    
    [mChart setVisibleXRangeMinimum:(double)0];
    [mChart setVisibleXRangeMaximum:(double)(g_length*2+1)];
//    [mChart setExtraRightOffset:15];
    [mChart notifyDataSetChanged];
//    [mChart moveViewToX:(double)0];
    [mChart setDragEnabled:true];   //false
    
    [mChart setDragDecelerationEnabled:false];
//    [mChart setHighlightPerDragEnabled:true];
    
    
    
    return dataList;
    
    
}
+(LineChartDataSet*)getDataSet:(QuizResult*)data_t Mode:(int)mode{
    if (data_t != nil) {
        NSArray<ChartDataEntry*> *yVals1;
        if (mode == 2) {
            ChartDataEntry* val0 = [[ChartDataEntry alloc] initWithX:0.0f y:[data_t.GSR5 doubleValue]];
            ChartDataEntry* val1 = [[ChartDataEntry alloc] initWithX:5.0f y:[data_t.GSR5 doubleValue]];
            ChartDataEntry* val2 = [[ChartDataEntry alloc] initWithX:7.0f y:[data_t.GSR7 doubleValue]];
            ChartDataEntry* val3 = [[ChartDataEntry alloc] initWithX:10.0f y:[data_t.GSR10 doubleValue]];
            yVals1 = @[val0,val1,val2,val3];
        } else {
            ChartDataEntry* val0 = [[ChartDataEntry alloc] initWithX:0.0f y:[data_t.GSR5 doubleValue]];
            ChartDataEntry* val1 = [[ChartDataEntry alloc] initWithX:5.0f y:[data_t.GSR5 doubleValue]];
            ChartDataEntry* val2 = [[ChartDataEntry alloc] initWithX:7.0f y:[data_t.GSR7 doubleValue]];
            ChartDataEntry* val3 = [[ChartDataEntry alloc] initWithX:10.0f y:[data_t.GSR10 doubleValue]];
            ChartDataEntry* val4 = [[ChartDataEntry alloc] initWithX:12.0f y:[data_t.GSR12 doubleValue]];
            ChartDataEntry* val5 = [[ChartDataEntry alloc] initWithX:15.0f y:[data_t.GSR15 doubleValue]];
            
//            val0 = [[ChartDataEntry alloc] initWithX:0.0f y:6.862345f];
//            val1 = [[ChartDataEntry alloc] initWithX:5.0f y:6.862345f];
//            val2 = [[ChartDataEntry alloc] initWithX:7.0f y:6.831345f];
//            val3 = [[ChartDataEntry alloc] initWithX:10.0f y:6.756345f];
//            val4 = [[ChartDataEntry alloc] initWithX:12.0f y:6.726345f];
//            val5 = [[ChartDataEntry alloc] initWithX:15.0f y:6.679345f];
            
            yVals1 = @[val0,val1,val2,val3,val4,val5];
            
        }
        
        LineChartDataSet *set1;
        UIColor* clr_t = [CGlobal colorWithHexString:@"#4472c4" Alpha:1.0f];
        UIColor* clr_f = [CGlobal colorWithHexString:@"#ed7d31" Alpha:1.0f];
        UIColor* clr_d = COLOR_PRIMARY;
        
        if (mode == 1) {
            set1 = [[LineChartDataSet alloc] initWithValues:yVals1 label:@"Correct"];
            [set1 setCircleColor:clr_t];
            [set1 setColor:clr_t];
            
        } else if (mode == 2) {
            set1 = [[LineChartDataSet alloc] initWithValues:yVals1 label:@""];
            [set1 setCircleColor:clr_d];
            [set1 setColor:clr_d];
        } else {
            set1 = [[LineChartDataSet alloc] initWithValues:yVals1 label:@"Incorrect"];
            [set1 setCircleColor:clr_f];
            [set1 setColor:clr_f];
        }
        [set1 setMode:LineChartModeHorizontalBezier];
        [set1 setLineWidth:1.0f];
        [set1 setFillAlpha:100];
        [set1 setDrawCircleHoleEnabled:false];
        [set1 setDrawCirclesEnabled:true];
        [set1 setValueTextColor:[UIColor lightGrayColor]];
        
        set1.circleRadius = 4.5;
        
        
        return set1;
    }
    return nil;
}
+(void)drawGraph:(LineChartView*)mChart DataTrue:(QuizResult*)data_t DataFalse:(QuizResult*)data_f DataDecision:(QuizResult*)data_d{
    
    NSMutableArray<id<IChartDataSet>>* temp_list = [[NSMutableArray alloc] init];
    NSArray<id<IChartDataSet>>* dataList =nil;
    ChartDataSet* set1 = [self getDataSet:data_t Mode:1];
    ChartDataSet* set2 = [self getDataSet:data_f Mode:0];
    ChartDataSet* set3 = [self getDataSet:data_d Mode:2];
    if (set1!=nil) {        [temp_list addObject:set1];    }
    if (set2!=nil) {        [temp_list addObject:set2];    }
    if (set3!=nil) {        [temp_list addObject:set3];    }
    
    dataList = [[NSArray alloc] initWithArray:temp_list];
    
    
    
    // create a data object with the datasets
    LineChartData* data = [[LineChartData alloc] initWithDataSets:dataList];
    UIFont* font = [UIFont systemFontOfSize:10.0f];
    [data setValueFont:font];
    
    mChart.data = data;
    [mChart setBackgroundColor:[UIColor whiteColor]];
    [mChart.leftAxis setDrawGridLinesEnabled:false];
    [mChart.rightAxis setDrawGridLinesEnabled:false];
    [mChart.leftAxis setDrawLimitLinesBehindDataEnabled:false];
    [mChart.xAxis setDrawGridLinesEnabled:false];
    [mChart.leftAxis setDrawAxisLineEnabled:true]; //  true
    [mChart.rightAxis setDrawAxisLineEnabled:false];
    [mChart.leftAxis setAxisLineColor:[UIColor whiteColor]];
    
    ChartDescription * description = [[ChartDescription alloc] init];
    description.text = @"";
    mChart.chartDescription = description;
    [mChart.leftAxis setDrawLabelsEnabled:false];
    [mChart.rightAxis setDrawLabelsEnabled:false];
    [mChart.xAxis setDrawLabelsEnabled:false];
    [mChart.xAxis setLabelPosition:XAxisLabelPositionBottom];
    [mChart.xAxis setEnabled:false];        // true
    [mChart.xAxis setAxisLineColor:[UIColor whiteColor]];
    
    mChart.scaleXEnabled = false;
    mChart.scaleYEnabled = false;
    mChart.pinchZoomEnabled = false;
    mChart.backgroundColor = [UIColor clearColor];
    
    
    
//    mChart.setClickable(false);
//    mChart.setFocusable(false);
//    mChart.setTouchEnabled(false);
//    mChart.setBackgroundColor(Color.TRANSPARENT);
    
    [mChart.data setHighlightEnabled:false];
//    [mChart moveViewToX:0.0f];
//    [mChart.xAxis setLabelCount:10 force:false];
    
    [mChart.legend setPosition:ChartLegendPositionAboveChartRight];
    [mChart.legend setEnabled:false];
    
    [mChart setVisibleXRangeMinimum:(double)4.7];
    [mChart setVisibleXRangeMaximum:(double)11];
    [mChart setExtraRightOffset:15];
    [mChart notifyDataSetChanged];
    [mChart moveViewToX:(double)4.7];
    [mChart setDragEnabled:false];
    
    
}
+(NSString*)getCreationTime:(NSDate*)date GMT:(BOOL)isGmt MODE:(int)mode{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = @"HH:mm,dd/MM/yyyy";
    switch (mode) {
        case 1:
        {
            dateFormat.dateFormat = @"HH:mm,dd/MM/yyyy:";
            break;
        }
        case 2:
        {
            dateFormat.dateFormat = @"dd/MM/yyyy";
            break;
        }
        case 3:
        {
            dateFormat.dateFormat = @"HH:mm";
            break;
        }
        case 4:
        {
            dateFormat.dateFormat = @"dd/MM/yyyy, HH:mm";
            break;
        }
        default:{
            break;
        }
    }
    if (isGmt) {
        NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        [dateFormat setTimeZone:gmt];
    }else{
        [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    }
    NSString* pretty = [dateFormat stringFromDate:date];
    return pretty;
}
+(NSMutableArray*)getMyLogFiles:(int)mode{
    NSMutableArray* ret = [[NSMutableArray alloc] init];
    NSMutableArray* listData = [CGlobal getMyLogFiles];
    switch (mode) {
        case 0:
        {
            // all
            ret = listData;
            break;
        }
        case 1:
        {
            // training
            for (int i=0; i<listData.count; i++) {
                NSMutableDictionary* data = listData[i];
                if (data[@"dics"]!=nil) {
                   
                }else{
                    [ret addObject:data];
                }
            }
            break;
        }
        case 2:
        {
            // investment
            for (int i=0; i<listData.count; i++) {
                NSMutableDictionary* data = listData[i];
                if (data[@"dics"]!=nil) {
                    [ret addObject:data];
                }else{
                    
                }
            }
            break;
        }
        default:
            break;
    }
    return ret;
}
+(NSMutableArray*)getMyLogFiles:(int)mode Data:(LoginResponse*)resp{
    NSMutableArray* ret = [[NSMutableArray alloc] init];
    NSMutableArray* listData = [CGlobal getMyLogFiles_FromLogin:resp];
    switch (mode) {
        case 0:
        {
            // all
            ret = listData;
            break;
        }
        case 1:
        {
            // training
            for (int i=0; i<listData.count; i++) {
                NSMutableDictionary* data = listData[i];
                if (data[@"dics"]!=nil) {
                    
                }else{
                    [ret addObject:data];
                }
            }
            break;
        }
        case 2:
        {
            // investment
            for (int i=0; i<listData.count; i++) {
                NSMutableDictionary* data = listData[i];
                if (data[@"dics"]!=nil) {
                    [ret addObject:data];
                }else{
                    
                }
            }
            break;
        }
        default:
            break;
    }
    return ret;
}
+(NSMutableArray*)getMyLogFiles{
    EnvVar* env = [CGlobal sharedId].env;
    NSString* uname = env.username;
    NSString* prefix = [NSString stringWithFormat:@"quiz_%@",uname];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*sourcePath = [paths objectAtIndex:0];
    sourcePath = [sourcePath stringByAppendingPathComponent:@"log"];
    NSArray* dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:sourcePath
                                                                        error:NULL];
    NSMutableArray *tempList = [[NSMutableArray alloc] init];
    [dirs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *filename = (NSString *)obj;
        NSString *extension = [[filename pathExtension] lowercaseString];
        
        if ([extension isEqualToString:@"csv"] && [filename hasPrefix:prefix]) {
            NSRange range = NSMakeRange([prefix length], [filename length] - 4 - [prefix length]);
            NSString*number = [filename substringWithRange:range];
            
            int num = [number intValue];
            
            NSMutableDictionary* data = [CGlobal readExcelFile:filename];
            if (data!=nil) {
                
                data[@"number"] = [NSNumber numberWithInt:num];
                [tempList addObject:data];
            }
            
        }
    }];
    
    [tempList sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSMutableDictionary* first = obj1;
        NSMutableDictionary* second = obj2;
        NSNumber* num1 = first[@"number"] ;
        NSNumber* num2 = second[@"number"] ;
        return [num2 compare:num1];
    }];
    
    return tempList;
}
+(NSMutableArray*)getMyLogFiles_FromLogin:(LoginResponse*)resp{
    NSMutableArray *tempList = [[NSMutableArray alloc] init];
    for (int i=0; i<resp.tblGraph_list.count; i++) {
        TblGraph* tblGraph = resp.tblGraph_list[i];
        NSMutableDictionary* data = [CGlobal readFromTblGraph:tblGraph];
        if (data!=nil) {
            int num = [tblGraph.tg_id intValue];
            data[@"number"] = [NSNumber numberWithInt:num];
            [tempList addObject:data];
        }
    }
    [tempList sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSMutableDictionary* first = obj1;
        NSMutableDictionary* second = obj2;
        NSNumber* num1 = first[@"number"] ;
        NSNumber* num2 = second[@"number"] ;
        return [num2 compare:num1];
    }];
    
    return tempList;
}
+(NSMutableArray*)getRandomIndex:(int)pos Length:(int)n1 allIndex:(NSMutableArray*)allData TempSession:(NSMutableArray*)tempSession{
    NSMutableArray* ret = [[NSMutableArray alloc] init];
    if (tempSession.count >= n1*4/5) {
        NSRange range = NSMakeRange(0, 10);
        [tempSession removeObjectsInRange:range];
        
        NSLog(@"temp Cleared");
    }
    while (true) {
        ret = [[NSMutableArray alloc] init];
        while (true) {
            int offset1 = arc4random_uniform(100);
            NSString* num = [NSString stringWithFormat:@"%d",(pos + offset1)%n1 + 1];
            NSUInteger found = [ret indexOfObject:num];
            NSUInteger found_session = [tempSession indexOfObject:num];
            if (found == NSNotFound && found_session == NSNotFound) {
                [ret addObject:num];
            }
            if (ret.count == 4) {
                break;
            }
        }
        NSArray* rettemp = [ret sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            NSNumber* first = [NSNumber numberWithInt:[obj1 intValue]];
            NSNumber* second = [NSNumber numberWithInt:[obj2 intValue]];
            return [first compare:second];
        }];
        NSString* key = [NSString stringWithFormat:@"%@_%@_%@_%@",rettemp[0],rettemp[1],rettemp[2],rettemp[3]];
        NSUInteger global_found = [allData indexOfObject:key];
        if (global_found == NSNotFound) {
            [allData addObject:key];
            break;
        }
    }
    for (NSString* num in ret) {
        NSUInteger found_session = [tempSession indexOfObject:num];
        if (found_session == NSNotFound) {
            [tempSession addObject:num];
        }
    }
    NSString* key = [NSString stringWithFormat:@"%@_%@_%@_%@",ret[0],ret[1],ret[2],ret[3]];
    NSLog(@"combination  %@",key);
    
    return ret;
}
+(void)checkQuizResult:(QuizResult*)result{
    if ([result.GSR5 length]>0) {
        
    }else{
        result.GSR5 = @"0";
    }
    
    if ([result.GSR7 length]>0) {
        
    }else{
        result.GSR7 = @"0";
    }
    
    if ([result.GSR10 length]>0) {
        
    }else{
        result.GSR10 = @"0";
    }
    
    if ([result.GSR12 length]>0) {
        
    }else{
        result.GSR12 = @"0";
    }
    
    if ([result.GSR15 length]>0) {
        
    }else{
        result.GSR15 = @"0";
    }
    
}
@end
