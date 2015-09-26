//
//  UIViewController+WSToast.m
//  WalkShopper
//
//  Created by 丁 一 on 15/9/26.
//  Copyright © 2015年 Ding Yi. All rights reserved.
//

#import "UIViewController+WSToast.h"
#import "MBProgressHUD.h"

@implementation UIViewController (WSToast)

- (void)showOkToast:(NSString *)text
{
    [self showToastWithText:text image:[UIImage imageNamed:@"toast_icon_ok"] offset:CGPointZero];
}

- (void)showOkToast:(NSString *)text okImage:(UIImage *)image
{
    [self showToastWithText:text image:image offset:CGPointZero];
}

- (void)showToast:(NSString *)text
{
    if (text.length == 0) {
        return;
    }
    
    [self showToastWithText:text image:nil offset:CGPointZero];
}

- (void)showToast:(NSString *)text offset:(CGFloat)yOffset
{
    CGPoint offset = CGPointZero;
    offset.y = yOffset;
    
    [self showToastWithText:text image:nil offset:offset];
}

- (void)showToastWithText:(NSString *)text image:(UIImage *)image offset:(CGPoint)offset
{
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    if (image) {
        progressHUD.customView = [[UIImageView alloc] initWithImage:image];
        progressHUD.mode = MBProgressHUDModeCustomView;
    } else {
        progressHUD.mode = MBProgressHUDModeText;
    }
    
    progressHUD.labelFont = [UIFont systemFontOfSize:14];
    progressHUD.labelText = text;
    progressHUD.xOffset = offset.x;
    progressHUD.yOffset = offset.y;
    progressHUD.removeFromSuperViewOnHide = YES;
    
    [self.view addSubview:progressHUD];
    
    [progressHUD show:YES];
    
    [progressHUD hide:YES afterDelay:1];
}

@end
