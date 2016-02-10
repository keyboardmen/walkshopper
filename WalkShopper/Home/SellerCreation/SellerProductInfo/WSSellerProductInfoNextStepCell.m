//
//  WSSellerProductInfoNextStepCell.m
//  WalkShopper
//
//  Created by 丁 一 on 16/1/24.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import "WSSellerProductInfoNextStepCell.h"

@implementation WSSellerProductInfoNextStepCell

+ (CGFloat)cellHeight
{
    return 60.0f;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.nextStepBtn addTarget:self action:@selector(handleNextStepAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)handleNextStepAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(showNextViewController)]) {
        [self.delegate showNextViewController];
    }
}


@end
