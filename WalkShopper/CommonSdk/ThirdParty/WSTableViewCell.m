//
//  WSTableViewCell.m
//  WalkShopper
//
//  Created by 丁 一 on 16/1/24.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import "WSTableViewCell.h"

@implementation WSTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self creatSepLines];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self creatSepLines];
    }
    
    return self;
}

- (void)creatSepLines
{
    self.leftInsets = 10.0;
    
    self.topSepline = [UIView new];
    [self.contentView addSubview:self.topSepline];
    
    WS(weakSelf)
    [self.topSepline mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.top.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(0.5);
    }];
    self.topSepline.backgroundColor = [UIColor seplineColor];
    self.topSepline.hidden = YES;
    
    self.sepline = [UIView new];
    [self.contentView addSubview:self.sepline];
    [self.sepline mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.and.bottom.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.contentView.mas_left).with.offset(_leftInsets);
        make.height.mas_equalTo(0.5);
    }];
    self.sepline.backgroundColor = [UIColor seplineColor];
    
}

- (void)setLeftInsets:(CGFloat)leftInsets
{
    _leftInsets = leftInsets;
    WS(weakSelf)
    CGFloat constant = self.lastCell ? 0.0f : _leftInsets;
    [self.sepline mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView.mas_left).with.offset(constant);
    }];
}

- (void)setFirstCell:(BOOL)firstCell
{
    _firstCell = firstCell;
    self.topSepline.hidden = !firstCell;
}

- (void)setLastCell:(BOOL)lastCell
{
    _lastCell = lastCell;
    WS(weakSelf)
    CGFloat constant = self.lastCell ? 0.0f : _leftInsets;
    [self.sepline mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView.mas_left).with.offset(constant);
    }];
}

- (void)fillData:(id)item
{
    
}

@end
