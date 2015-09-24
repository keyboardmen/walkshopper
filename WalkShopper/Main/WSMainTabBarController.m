//
//  WSMainTabBarController.m
//  WalkShopper
//
//  Created by Ding Yi on 15/9/23.
//  Copyright (c) 2015年 Ding Yi. All rights reserved.
//

#import "WSMainTabBarController.h"
#import "WSMineViewController.h"
#import "WSLoginViewController.h"

@interface WSMainTabBarController () <UITabBarControllerDelegate>



@end

@implementation WSMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    UINavigationController *nav = (UINavigationController *)viewController;
    if ([nav.viewControllers.firstObject isKindOfClass:[WSMineViewController class]]) {
        if ([WSUserSession sharedSession].isLogin == NO) {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
            WSLoginViewController *loginVC = [storyBoard instantiateViewControllerWithIdentifier:@"WSLoginViewController"];
            nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
            [self presentViewController:nav animated:YES completion:nil];
            return NO;
        }
    }

    return YES;
}

@end
