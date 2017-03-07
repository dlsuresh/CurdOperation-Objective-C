//
//  TableViewCell.m
//  CurdOperations
//
//  Created by Suresh on 2/22/17.
//  Copyright © 2017 Suresh. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.editOutlet.hidden = YES;
    self.deleteOutlet.hidden = YES;
    // Configure the view for the selected state
}


@end
