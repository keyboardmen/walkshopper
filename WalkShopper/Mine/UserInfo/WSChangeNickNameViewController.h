//
//  WSChangeNickNameViewController.h
//  WalkShopper
//
//  Created by 丁 一 on 16/1/22.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WSChangeNickNameDelegate;

@interface WSChangeNickNameViewController : UIViewController

@property (weak, nonatomic) id<WSChangeNickNameDelegate>delegate;

@end


@protocol WSChangeNickNameDelegate <NSObject>

- (void)changeNickNameSuccessfully:(NSString *)nickName;

@end