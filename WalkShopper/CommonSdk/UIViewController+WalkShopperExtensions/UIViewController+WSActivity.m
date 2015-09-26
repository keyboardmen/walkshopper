//
//  UIViewController+WSActivity.m
//  WalkShopper
//
//  Created by 丁 一 on 15/9/26.
//  Copyright © 2015年 Ding Yi. All rights reserved.
//

#import "UIViewController+WSActivity.h"
#import <objc/runtime.h>
#import "MBProgressHUD.h"

@implementation UIViewController (WSActivity)

@dynamic ws_progressHUBArray;

- (void)setWs_progressHUBArray:(id)object
{
    objc_setAssociatedObject(self, @selector(ws_progressHUBArray), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)ws_progressHUBArray
{
    NSMutableArray *array = objc_getAssociatedObject(self, @selector(ws_progressHUBArray));
    if (!array) {
        array = [NSMutableArray new];
        self.ws_progressHUBArray = array;
    }
    return array;
}

- (void)startActivity:(NSString *)text
{
    CGPoint offset = CGPointZero;
    
    offset.y =  -64;
    
    [self startActivity:text withFontSize:14 immediate:YES offset:offset];
}

- (void)startMaskActivity:(NSString *)text
{
    CGPoint offset = CGPointZero;
    
    offset.y =  -64;
    
    [self startMaskActivity:text withFontSize:14 immediate:YES offset:offset];
}

- (void)startMaskActivity:(NSString *)text inView:(UIView *)parentView
{
    CGPoint offset = CGPointZero;
    
    offset.y =  -64;
    
    [self startMaskActivity:text withFontSize:14 immediate:YES offset:offset showInView:parentView];
}

- (void)startActivity:(NSString *)text withFontSize:(NSInteger)fontSize immediate:(BOOL)immediate offset:(CGPoint)offset
{
    [self startMaskActivity:text withFontSize:fontSize immediate:immediate offset:offset showInView:self.view]; //fix me，可能导致部分页面等待期间无法返回。
}

- (void)startMaskActivity:(NSString *)text withFontSize:(NSInteger)fontSize immediate:(BOOL)immediate offset:(CGPoint)offset showInView:(UIView *)parentView
{
    if (![self isViewLoaded]) {
        return;
    }
    
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:parentView];
    progressHUD.labelFont = [UIFont systemFontOfSize:fontSize];
    progressHUD.labelText = text;
    progressHUD.xOffset = offset.x;
    progressHUD.yOffset = offset.y;
    progressHUD.removeFromSuperViewOnHide = YES;
    
    if (!immediate) {
        progressHUD.graceTime = 1;
        progressHUD.taskInProgress = YES;
    }
    
    [self.ws_progressHUBArray addObject:progressHUD];
    
    [parentView addSubview:progressHUD];
    [progressHUD show:YES];
}

- (void)startMaskActivity:(NSString *)text withFontSize:(NSInteger)fontSize immediate:(BOOL)immediate offset:(CGPoint)offset
{
    [self startMaskActivity:text withFontSize:fontSize immediate:immediate offset:offset showInView:self.view];
}

- (void)stopActivity
{
    NSArray *progressHUBArray = [self.ws_progressHUBArray copy];
    
    for (MBProgressHUD *progressHUD in progressHUBArray) {
        [self.ws_progressHUBArray removeObject:progressHUD];
        [progressHUD hide:YES];
    }
}

- (void)stopMaskActivity
{
    [self stopActivity];
}


@end
