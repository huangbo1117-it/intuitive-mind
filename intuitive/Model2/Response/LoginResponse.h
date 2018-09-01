//
//  LoginResponse.h
//  Wordpress News App
//
//  Created by BoHuang on 5/25/16.
//  Copyright © 2016 Nikolay Yanev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TblUser.h"
#import "TblGraph.h"

@interface LoginResponse : NSObject

@property (copy, nonatomic) NSString* response;
@property (copy, nonatomic) NSString* message;

@property (strong, nonatomic) TblUser* tblUser ;
@property (strong, nonatomic) TblGraph* tblGraph ;

@property (strong, nonatomic) NSMutableArray* tblGraph_list ;



-(instancetype)initWithDictionary:(NSDictionary*) dict;
@end
