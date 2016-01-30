//
//  UIViewController+WSHook.m
//  WalkShopper
//
//  Created by 丁 一 on 15/12/7.
//  Copyright © 2015年 Ding Yi. All rights reserved.
//

#import "UIViewController+WSHook.h"
#import "Aspects.h"

@implementation UIViewController (WSHook)

- (void)setWs_enableViewLifeCircleHook:(BOOL)ws_enableViewLifeCircleHook
{
    objc_setAssociatedObject(self, @selector(ws_enableViewLifeCircleHook), @(ws_enableViewLifeCircleHook), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setWs_autoResignGesture:(UIGestureRecognizer *)gesture
{
    objc_setAssociatedObject(self, @selector(ws_autoResignGesture), gesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIGestureRecognizer *)ws_autoResignGesture
{
    return objc_getAssociatedObject(self, @selector(ws_autoResignGesture));
}

- (BOOL)enableBackGroundTapToResignFirstResponder
{
    NSNumber *value = objc_getAssociatedObject(self, @selector(enableBackGroundTapToResignFirstResponder));
    return [value boolValue];
}

- (void)setEnableBackGroundTapToResignFirstResponder:(BOOL)enable
{
    objc_setAssociatedObject(self, @selector(enableBackGroundTapToResignFirstResponder), @(enable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (enable && !self.ws_autoResignGesture) {
        self.ws_autoResignGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ws_backgroundTapped:)];
        self.ws_autoResignGesture.cancelsTouchesInView = NO;
        [self.view addGestureRecognizer:self.ws_autoResignGesture];
    } else {
        [self.view removeGestureRecognizer:self.ws_autoResignGesture];
    }
}

- (void)ws_backgroundTapped:(id)sender
{
    [self.view endEditing:YES];
}

- (BOOL)ws_enableViewLifeCircleHook
{
    NSNumber *value = objc_getAssociatedObject(self, @selector(ws_enableViewLifeCircleHook));
    
    if (!value) {
        NSString *classText = NSStringFromClass(self.class);
        if (![classText hasPrefix:@"_"] && ![classText hasPrefix:@"UI"]) { //默认仅对应用派生出的ViewController做修改 对系统内部Viewcontroller不做修改。
            self.ws_enableViewLifeCircleHook = YES;
            value = @(YES);
        }
    }
    return [value boolValue];
}

- (void)ws_viewDidLoad
{
    self.navigationController.navigationBar.translucent = NO;// iOS7使用appearance设置translucent会crash
//    self.view.backgroundColor = [NPMColor mainBackgroundColor];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
//    if (self.navigationController.viewControllers.count > 1) {
//        UIButton *navButton = [NPMUIFactory naviBackButtonWithTarget:self selector:@selector(ldpm_backButtonPressed:)];
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navButton];
//        
//        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
//            self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan = NO;
//        }
//    }
}

- (void)ws_backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
