//
//  BluTableViewCell.h
//  intuitive
//
//  Created by BoHuang on 5/30/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColoredLabel.h"

@interface BluTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet ColoredLabel *deviceLabel;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;

@end
