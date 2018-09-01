//
//  TblUser.h
//  Wordpress News App
//
//  Created by BoHuang on 5/25/16.
//  Copyright © 2016 Nikolay Yanev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TblUser : NSObject

@property (nonatomic,copy) NSString* tu_id;
@property (nonatomic,copy) NSString* tu_username;
@property (nonatomic,copy) NSString* tu_email;
@property (nonatomic,copy) NSString* tu_password;
@property (nonatomic,copy) NSString* tu_birth;
@property (nonatomic,copy) NSString* tu_gender;
@property (nonatomic,copy) NSString* create_datetime;
@property (nonatomic,copy) NSString* modify_datetime;

@property (nonatomic,assign) long temp;


-(instancetype)initWithDictionary:(NSDictionary*) dict;
@end
