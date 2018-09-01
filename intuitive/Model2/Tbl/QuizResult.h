//
//  QuizResult.h
//  intuitive
//
//  Created by BoHuang on 4/25/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuizResult : NSObject
@property (nonatomic,copy) NSString* GSR7;
@property (nonatomic,copy) NSString* GSR5;
@property (nonatomic,copy) NSString* GSR10;
@property (nonatomic,copy) NSString* GSR12;
@property (nonatomic,copy) NSString* GSR15;

@property (nonatomic,assign) float nCount;
@property (nonatomic,assign) int selectedPos,RandomPos;
@property (nonatomic,assign) BOOL result;

-(void)genResult;
@end
