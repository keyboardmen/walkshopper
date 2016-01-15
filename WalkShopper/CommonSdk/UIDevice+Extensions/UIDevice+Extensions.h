//
//  UIDevice+Extensions.h
//  WalkShopper
//
//  Created by 丁 一 on 15/9/26.
//  Copyright © 2015年 Ding Yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Extensions)

+ (CGFloat)screenScale;
+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;
+ (BOOL)isIphone4Screen;
+ (BOOL)isIphone5Screen;
+ (BOOL)isIphone6Screen;
+ (BOOL)isIphone6PlusScreen;

@end
