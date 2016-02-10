//
//  WSSellerProductInfoCommissionCell.m
//  WalkShopper
//
//  Created by 丁 一 on 16/1/24.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import "WSSellerProductInfoCommissionCell.h"

@implementation WSSellerProductInfoCommissionCell

+ (CGFloat)cellHeight
{
    return 44.0f;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.textField.placeholder = @"请输入佣金，例如300或1%";
    self.textField.font = [UIFont systemFontOfSize:14];
}

@end
