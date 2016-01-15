//
//  WSViewControllerConfiguration.m
//  WalkShopper
//
//  Created by 丁 一 on 15/12/7.
//  Copyright © 2015年 Ding Yi. All rights reserved.
//

#import "WSViewControllerConfiguration.h"
#import "Aspects.h"
#import "UIViewController+WSHook.h"


@implementation WSViewControllerConfiguration

+ (void)hookViewLifeCircle
{
    [UIViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        UIViewController *instance = [aspectInfo instance];
        if (instance.ws_enableViewLifeCircleHook) {
            [instance ws_viewDidLoad];
        }
    } error:NULL];
}


@end
