//
//  BluTableViewCell.m
//  intuitive
//
//  Created by BoHuang on 5/30/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BluTableViewCell.h"

@implementation BluTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
