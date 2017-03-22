//
//  DDTableViewCell.h
//  UITableView键盘滚动
//
//  Created by 懂懂科技 on 2017/3/7.
//  Copyright © 2017年 DDKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DDTableViewCellDelegate <NSObject>

-(void)clickButton:(NSIndexPath *)indexPath;

@end


@interface DDTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;
@property (nonatomic, weak) id <DDTableViewCellDelegate> delegate;

@end
