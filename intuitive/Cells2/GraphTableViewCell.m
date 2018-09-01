//
//  GraphTableViewCell.m
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "GraphTableViewCell.h"
#import "CGlobal.h"
@implementation GraphTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.rightButtons = @[[MGSwipeButton buttonWithTitle:@"Delete" icon:nil backgroundColor:[CGlobal colorWithHexString:@"f61e00" Alpha:1.0f]]];
    
    self.rightSwipeSettings.transition = MGSwipeStateSwipingRightToLeft;
    self.rightSwipeSettings.bottomMargin = 5;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setData:(NSMutableDictionary *)data{
    _data = data;
    if (data!=nil) {
        TblGraph* tblGraph = data[@"tblGraph"];
        QuizResult *data_f = data[@"incorrect"];
        QuizResult *data_t = data[@"correct"];
        NSDate* date = data[@"date"];
        self.lblDate1.text = [CGlobal getCreationTime:date GMT:false MODE:2];
        self.lblDate2.text = [CGlobal getCreationTime:date GMT:false MODE:3];
        self.lblCorrect.text = [NSString stringWithFormat:@"%.0f",data_t.nCount];
        self.lblIncorrect.text = [NSString stringWithFormat:@"%.0f",data_f.nCount];
        
        int percent = (int) (data_t.nCount / (data_f.nCount + data_t.nCount) * 100);
        self.lblPercent.text = [NSString stringWithFormat:@"%d",percent];
        if ([CGlobal quizValid:data_f Data:data_t List:nil]) {
            self.lblInvalid.hidden = true;
            self.lblScore.text = tblGraph.tg_score;
        }else{
            self.lblInvalid.hidden = false;
            self.lblScore.text = @"NA";
        }
        
        if ([tblGraph.tg_name length]>0) {
            self.stackTitle.hidden = false;
            self.lblDecision.text = tblGraph.tg_name;
        }else{
            self.stackTitle.hidden = true;
        }
        
//        self.lblInvalid.hidden = false;
    }
}
@end
