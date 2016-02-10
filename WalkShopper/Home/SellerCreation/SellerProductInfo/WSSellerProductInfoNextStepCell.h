//
//  WSSellerProductInfoNextStepCell.h
//  WalkShopper
//
//  Created by 丁 一 on 16/1/24.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WSSellerProductInfoNextStepDelegate;

@interface WSSellerProductInfoNextStepCell : WSTableViewCell

@property (weak, nonatomic) IBOutlet UIButton *nextStepBtn;
@property (weak, nonatomic) id<WSSellerProductInfoNextStepDelegate>delegate;

+ (CGFloat)cellHeight;

@end


@protocol WSSellerProductInfoNextStepDelegate <NSObject>

- (void)showNextViewController;

@end