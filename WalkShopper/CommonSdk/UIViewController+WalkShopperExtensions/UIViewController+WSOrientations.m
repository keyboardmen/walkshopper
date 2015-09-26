//
//  UIViewController+WSOrientations.m
//  WalkShopper
//
//  Created by 丁 一 on 15/9/26.
//  Copyright © 2015年 Ding Yi. All rights reserved.
//

#import "UIViewController+WSOrientations.h"
#import <objc/runtime.h>

void exchangeMethodImplementations(Class cls, SEL name1, SEL name2)
{
    Method m1 = class_getInstanceMethod(cls, name1);
    Method m2 = class_getInstanceMethod(cls, name2);
    
    if (m1 && m2) {
        method_exchangeImplementations(m1, m2);
    }
}

@interface UINavigationController  (WSOrientations)

+ (void)configDefaultInterfaceOrientations;

@end

@implementation UIViewController (WSOrientations)

+ (void)configDefaultInterfaceOrientations
{
    Class clazz = NSClassFromString(@"UIViewController");
    
    exchangeMethodImplementations(clazz, @selector(shouldAutorotate), @selector(ws_shouldAutorotate));
    exchangeMethodImplementations(clazz, @selector(supportedInterfaceOrientations), @selector(ws_supportedInterfaceOrientations));
    exchangeMethodImplementations(clazz, @selector(preferredInterfaceOrientationForPresentation), @selector(ws_preferredInterfaceOrientationForPresentation));
    exchangeMethodImplementations(clazz, @selector(shouldAutorotateToInterfaceOrientation:), @selector(ws_shouldAutorotateToInterfaceOrientation:));
    
    [UINavigationController configDefaultInterfaceOrientations];
}

- (BOOL)ws_shouldAutorotate
{
    return NO;
}

- (NSUInteger)ws_supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)ws_preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (BOOL)ws_shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

@implementation UINavigationController  (FaOrientations)

+ (void)configDefaultInterfaceOrientations
{
    Class clazz = NSClassFromString(@"UINavigationController");
    
    exchangeMethodImplementations(clazz, @selector(supportedInterfaceOrientations), @selector(ws_supportedInterfaceOrientations));
}

- (NSUInteger)ws_supportedInterfaceOrientations
{
    if ([self respondsToSelector:@selector(topViewController)]) {
        return [self.topViewController supportedInterfaceOrientations];
    } else {
        return [self ws_supportedInterfaceOrientations];
    }
}

@end

