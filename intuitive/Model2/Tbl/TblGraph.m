//
//  TblGraph.m
//  intuitive
//
//  Created by BoHuang on 7/5/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "TblGraph.h"

@implementation TblGraph
-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        
        [BaseModel parseResponse:self Dict:dict];
        if (!([_tg_score length]>0)) {
            _tg_score = @"0.00";
        }
    }
    return self;
}
-(NSString*)getLatestScoreStr{
    @try {
        NSString* str = [NSString stringWithFormat:@"%.2f", [self.tg_score doubleValue]];
        return str;
    } @catch (NSException *exception) {
        return @"0.00";
    }
}
@end
