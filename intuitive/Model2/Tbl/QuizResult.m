//
//  QuizResult.m
//  intuitive
//
//  Created by BoHuang on 4/25/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "QuizResult.h"

@implementation QuizResult
-(void)genResult{
    if (_selectedPos == _RandomPos) {
        _result = true;
    }else{
        _result = false;
    }
}
@end
