//
//  TblGraph.h
//  intuitive
//
//  Created by BoHuang on 7/5/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BaseModel.h"

@interface TblGraph : NSObject
@property (nonatomic,copy) NSString* tg_id;
@property (nonatomic,copy) NSString* tg_filename;
@property (nonatomic,copy) NSString* tg_delete;
@property (nonatomic,copy) NSString* create_datetime;
@property (nonatomic,copy) NSString* modify_datetime;
@property (nonatomic,copy) NSString* tg_content;
@property (nonatomic,copy) NSString* tu_id;
@property (nonatomic,copy) NSString* tg_score;
@property (nonatomic,copy) NSString* tg_valid;

@property (nonatomic,copy) NSString* tg_name;

@property (nonatomic,copy) NSString* action;

-(instancetype)initWithDictionary:(NSDictionary*) dict;

-(NSString*)getLatestScoreStr;
@end
