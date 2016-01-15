//
//  UIViewController+WSToast.h
//  WalkShopper
//
//  Created by 丁 一 on 15/9/26.
//  Copyright © 2015年 Ding Yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (WSToast)

- (void)showOkToast:(NSString *)text;
- (void)showOkToast:(NSString *)text okImage:(UIImage *)image;
- (void)showToast:(NSString *)text offset:(CGFloat)yOffset;
- (void)showToast:(NSString *)text;

@end
