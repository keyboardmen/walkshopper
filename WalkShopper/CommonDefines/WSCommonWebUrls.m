//
//  WSCommonWebUrls.m
//  WalkShopper
//
//  Created by 丁 一 on 16/1/10.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import "WSCommonWebUrls.h"

static NSString * const domain = @"http://115.28.228.41";

@implementation WSCommonWebUrls

+ (instancetype)sharedInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

- (NSString *)registerUrl
{
    NSString *path = @"project/shop_service/basic/web/index.php?r=api/account/register";
    NSString *url = [NSString stringWithFormat:@"%@/%@", domain, path];
    return url;
}

- (NSString *)loginUrl
{
    NSString *url = [NSString stringWithFormat:@"%@/", domain];
    return url;
}

@end
