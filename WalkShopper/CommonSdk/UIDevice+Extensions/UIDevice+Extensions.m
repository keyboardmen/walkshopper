//
//  UIDevice+Extensions.m
//  WalkShopper
//
//  Created by 丁 一 on 15/9/26.
//  Copyright © 2015年 Ding Yi. All rights reserved.
//

#import "UIDevice+Extensions.h"

@implementation UIDevice (Extensions)

+ (CGFloat)screenScale
{
    return [UIScreen mainScreen].scale;
}

+ (CGFloat)screenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)screenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

+ (BOOL)isIphone4Screen
{
    return [UIScreen mainScreen].bounds.size.height == 480.0f;
}

+ (BOOL)isIphone5Screen
{
    return [UIScreen mainScreen].bounds.size.height == 568.0f;
}

+ (BOOL)isIphone6Screen
{
    return [UIScreen mainScreen].bounds.size.height == 667.0f;
}

+ (BOOL)isIphone6PlusScreen
{
    return [UIScreen mainScreen].bounds.size.height == 736.0f;
}


@end
