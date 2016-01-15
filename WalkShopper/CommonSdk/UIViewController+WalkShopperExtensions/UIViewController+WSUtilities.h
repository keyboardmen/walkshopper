//
//  UIViewController+WSUtilities.h
//  WalkShopper
//
//  Created by 丁 一 on 15/12/14.
//  Copyright © 2015年 Ding Yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (WSUtilities)

+ (UIViewController *)ws_topmostViewController;
+ (UIViewController *)ws_initViewControllerWithStoryBoard:(NSString *)storyBoardName withIdentifier:(NSString *)identifier;

@end
