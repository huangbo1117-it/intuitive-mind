//
//  LoginResponse.m
//  Wordpress News App
//
//  Created by BoHuang on 5/25/16.
//  Copyright © 2016 Nikolay Yanev. All rights reserved.
//

#import "LoginResponse.h"
#import "BaseModel.h"
@implementation LoginResponse

-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        
        [BaseModel parseResponse:self Dict:dict];
        
        id obj = [dict objectForKey:@"tblUser"];
        if (obj!=nil && obj!= [NSNull null]) {
            self.tblUser = [[TblUser alloc] initWithDictionary:obj];
        }
        
        obj = [dict objectForKey:@"tblGraph"];
        if (obj!=nil && obj!= [NSNull null]) {
            self.tblGraph = [[TblGraph alloc] initWithDictionary:obj];
        }
        
        obj = [dict objectForKey:@"tblGraph_list"];
        if (obj!=nil && obj!= [NSNull null]) {
            if ([obj isKindOfClass:[NSArray class]]) {
                self.tblGraph_list = [[NSMutableArray alloc] init];
                NSArray* array = obj;
                for (int i=0; i<array.count; i++) {
                    TblGraph* igraph = [[TblGraph alloc] initWithDictionary:array[i]];
                    [self.tblGraph_list addObject:igraph];
                }
            }
        }
        
    }
    return self;
}

@end
