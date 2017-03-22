//
//  DDTableViewCell.m
//  UITableView键盘滚动
//
//  Created by 懂懂科技 on 2017/3/7.
//  Copyright © 2017年 DDKJ. All rights reserved.
//

#import "DDTableViewCell.h"

@implementation DDTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)buttonClick {
    if ([self.delegate respondsToSelector:@selector(clickButton:)]) {
        [self.delegate clickButton:self.currentIndexPath];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
