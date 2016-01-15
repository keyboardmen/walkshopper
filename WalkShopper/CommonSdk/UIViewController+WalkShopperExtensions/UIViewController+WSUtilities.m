//
//  UIViewController+WSUtilities.m
//  WalkShopper
//
//  Created by 丁 一 on 15/12/14.
//  Copyright © 2015年 Ding Yi. All rights reserved.
//

#import "UIViewController+WSUtilities.h"

@implementation UIViewController (WSUtilities)

+ (UIViewController *)ws_topmostViewController
{
    //rootViewController需要是TabBarController,排除正在显示FirstPage的情况
    UIViewController *rootViewContoller = [UIApplication sharedApplication].delegate.window.rootViewController;
    if (!rootViewContoller || ![rootViewContoller isKindOfClass:[UITabBarController class]]) {
        return nil;
    }
    
    //当前显示哪个tab页
    UINavigationController *rootNavController = (UINavigationController *) [(UITabBarController*)rootViewContoller selectedViewController];
    if (!rootNavController) {
        return nil;
    }
    
    UINavigationController *navController = rootNavController;
    while ([navController isKindOfClass:[UINavigationController class]]) {
        UIViewController *topViewController = [navController topViewController];
        if ([topViewController isKindOfClass:[UINavigationController class]]) { //顶层是个导航控制器，继续循环
            navController = (UINavigationController *) topViewController;
        } else {
            //是否有弹出presentViewControllr;
            UIViewController *presentedViewController = topViewController.presentedViewController;
            while (presentedViewController) {
                topViewController = presentedViewController;
                if ([topViewController isKindOfClass:[UINavigationController class]]) {
                    break;
                } else {
                    presentedViewController = topViewController.presentedViewController;
                }
            }
            navController = (UINavigationController *) topViewController;
        }
    }
    return (UIViewController *) navController;
}

+ (UIViewController *)ws_initViewControllerWithStoryBoard:(NSString *)storyBoardName withIdentifier:(NSString *)identifier
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:storyBoardName bundle:nil];
    UIViewController *viewController = [storyBoard instantiateViewControllerWithIdentifier:identifier];
    
    return viewController;
}

@end
