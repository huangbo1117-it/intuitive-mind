//
//  GraphTableViewCell.h
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"
#import "ColoredLabel.h"
@interface GraphTableViewCell : MGSwipeTableCell
@property (weak, nonatomic) IBOutlet UILabel *lblDate1;
@property (weak, nonatomic) IBOutlet UILabel *lblDate2;

@property (weak, nonatomic) IBOutlet UILabel *lblCorrect;
@property (weak, nonatomic) IBOutlet UILabel *lblInvalid;
@property (weak, nonatomic) IBOutlet UILabel *lblIncorrect;
@property (weak, nonatomic) IBOutlet UILabel *lblPercent;
@property (weak, nonatomic) IBOutlet ColoredLabel *lblDecision;
@property (weak, nonatomic) IBOutlet UIStackView *stackTitle;
@property (weak, nonatomic) IBOutlet ColoredLabel *lblScore;


@property (strong, nonatomic) NSMutableDictionary*data;

@end
