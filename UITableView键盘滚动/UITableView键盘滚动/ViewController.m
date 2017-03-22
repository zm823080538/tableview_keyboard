//
//  ViewController.m
//  UITableView键盘滚动
//
//  Created by 懂懂科技 on 2017/3/7.
//  Copyright © 2017年 DDKJ. All rights reserved.
//

#import "ViewController.h"
#import "DDTableViewCell.h"

CGFloat textFieldHeight = 44;
@interface ViewController () <DDTableViewCellDelegate,UITableViewDelegate, UITableViewDataSource>
{
    UITextField *_textField; //键盘上方的输入框
    NSIndexPath *_indexPath; // 当前点击的cell的indexPath
    UITableView *_tableView;
    CGFloat _totalKeybordHeight;  //键盘的高度 + 键盘上面输入框的高度
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, textFieldHeight)];
    _textField.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_textField];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}


- (void)keyboardNotification:(NSNotification *)noti {
    NSDictionary *dict = noti.userInfo;
    CGRect rect = [dict[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGRect textFieldRect = CGRectMake(0, rect.origin.y - textFieldHeight, [UIScreen mainScreen].bounds.size.width, textFieldHeight);
    if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
        textFieldRect = rect;
    }
    [UIView animateWithDuration:0.25 animations:^{
        _textField.frame = textFieldRect;
    }];
    CGFloat h = rect.size.height + textFieldHeight;
    if (_totalKeybordHeight != h) {
        _totalKeybordHeight = h;
        NSLog(@"---%lf",_totalKeybordHeight);
        [self adjustTableViewToFitKeyboard];
    }
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"DDTableViewCell";
    DDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
   
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DDTableViewCell" owner:self options:nil].firstObject;
    }
    [cell.button setTitle:[NSString stringWithFormat:@"评论sunny%ld的说说",indexPath.row] forState:UIControlStateNormal];
    cell.button.layer.cornerRadius = 5;
    cell.button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.button.layer.borderWidth = 1.f;
    cell.button.layer.masksToBounds = YES;
    cell.currentIndexPath = indexPath;
    cell.delegate = self;
    return cell;
}

- (void)clickButton:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    DDTableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    _textField.placeholder = cell.button.currentTitle;
    [_textField becomeFirstResponder];
    [self adjustTableViewToFitKeyboard];
}

- (void)adjustTableViewToFitKeyboard {
    DDTableViewCell *cell = [_tableView cellForRowAtIndexPath:_indexPath];
    CGRect rect = [cell.superview convertRect:cell.frame toView:self.view];
    [self adjustTableViewToFitKeyboardWithRect:rect];
}

#pragma mark -- 滚动tableView，位于当前的交互的cell位置
- (void)adjustTableViewToFitKeyboardWithRect:(CGRect)rect {
    CGFloat delta = CGRectGetMaxY(rect) - (self.view.bounds.size.height - _totalKeybordHeight);
    CGPoint offSet = _tableView.contentOffset;
    offSet.y += delta;
    if (offSet.y < 0) {
        offSet.y = 0;
    }
    [_tableView setContentOffset:offSet animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
