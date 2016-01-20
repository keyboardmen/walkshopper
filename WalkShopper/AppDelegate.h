//
//  AppDelegate.h
//  WalkShopper
//
//  Created by 丁 一 on 15/9/23.
//  Copyright © 2015年 Ding Yi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "ApplyViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, IChatManagerDelegate> {
    EMConnectionState _connectionState;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainViewController *mainController;

@end

