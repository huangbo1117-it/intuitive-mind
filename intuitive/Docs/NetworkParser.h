//
//  NetworkParser.h
//  SchoolApp
//
//  Created by TwinkleStar on 11/27/15.
//  Copyright © 2015 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGlobal.h"

typedef void (^NetworkCompletionBlock)(NSDictionary*dict, NSError* error);


@interface NetworkParser : NSObject
+ (instancetype)sharedManager;

- (void)uploadImage:(UIImage*)image FileName:(NSString*)fileName withCompletionBlock:(NetworkCompletionBlock)completionBlock;

-(void)ontemplateGeneralRequest:(id) data Path:(NSString*)url withCompletionBlock:(NetworkCompletionBlock)completionBlock method:(NSString*)method;
-(void)ontemplateRequestWithNoCheck:(id) data Path:(NSString*)url withCompletionBlock:(NetworkCompletionBlock)completionBlock;

-(void)ontemplateGeneralRequestWithRawUrl:(id) data Path:(NSString*)url withCompletionBlock:(NetworkCompletionBlock)completionBlock;
-(void)ontemplateGeneralRequestWithRawUrlNoCheck:(id) data Path:(NSString*)url withCompletionBlock:(NetworkCompletionBlock)completionBlock;

-(void)generalNetwork:(NSString*)serverurl Data:(NSDictionary*)questionDict withCompletionBlock:(NetworkCompletionBlock)completionBlock method:(NSString*)method;
-(void)generalNetworkWithNoCheck:(NSString*)serverurl Data:(NSDictionary*)questionDict withCompletionBlock:(NetworkCompletionBlock)completionBlock;
@end
