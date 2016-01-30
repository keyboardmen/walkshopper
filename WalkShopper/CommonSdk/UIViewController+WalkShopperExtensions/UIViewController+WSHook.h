//
//  UIViewController+WSHook.h
//  WalkShopper
//
//  Created by 丁 一 on 15/12/7.
//  Copyright © 2015年 Ding Yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (WSHook)

@property (nonatomic,strong) UIGestureRecognizer *ws_autoResignGesture;
@property (nonatomic) BOOL enableBackGroundTapToResignFirstResponder;
@property (nonatomic,assign) BOOL ws_enableViewLifeCircleHook;

- (void)ws_viewDidLoad;

@end
