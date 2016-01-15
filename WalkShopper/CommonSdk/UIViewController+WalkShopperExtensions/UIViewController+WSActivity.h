//
//  UIViewController+WSActivity.h
//  WalkShopper
//
//  Created by 丁 一 on 15/9/26.
//  Copyright © 2015年 Ding Yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (WSActivity)

@property (nonatomic,weak) NSMutableArray *ws_progressHUBArray;

- (void)startActivity:(NSString *)text;
- (void)startMaskActivity:(NSString *)text;
- (void)startMaskActivity:(NSString *)text inView:(UIView *)parentView;
- (void)startActivity:(NSString *)text withFontSize:(NSInteger)fontSize immediate:(BOOL)immediate offset:(CGPoint)offset;
- (void)startMaskActivity:(NSString *)text withFontSize:(NSInteger)fontSize immediate:(BOOL)immediate offset:(CGPoint)offset;
- (void)stopActivity;
- (void)stopMaskActivity;

@end
