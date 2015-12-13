//
//  WSLoginViewController.h
//  WalkShopper
//
//  Created by Ding Yi on 15/9/23.
//  Copyright (c) 2015年 Ding Yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WSLoginViewControllerDelegate;

@interface WSLoginViewController : UIViewController

@property (weak, nonatomic) id<WSLoginViewControllerDelegate>loginDelegate;

+ (instancetype)initLoginViewController;

@end


@protocol WSLoginViewControllerDelegate <NSObject>

- (void)loginController:(id)controller completeWithResult:(BOOL)sucess;

@end