//
//  AppDelegate.m
//  WalkShopper
//
//  Created by 丁 一 on 15/9/23.
//  Copyright © 2015年 Ding Yi. All rights reserved.
//

#import "AppDelegate.h"
#import <SMS_SDK/SMSSDK.h>
#import "UIViewController+WSOrientations.h"
#import "WSAppGeneralConfiguration.h"
#import "WSViewControllerConfiguration.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UIViewController configDefaultInterfaceOrientations];
    [WSViewControllerConfiguration hookViewLifeCircle];
    [SMSSDK registerApp:@"9cfb8e7d0120" withSecret:@"c3d1ff0fd893b2f14ded0cba9876a18d"];
    
//    [AVOSCloud setApplicationId:@"gOlx63dQcu3e10WQA4FPAk2u-gzGzoHsz" clientKey:@"v30e1pFaOY23IeeET2JKRoqm"];
    
    [self registerRemoteNotification];
    [[WSAppGeneralConfiguration sharedInstance] registerAppInServer];
    
    return YES;
}

#pragma mark - Register remote notification

- (void)registerRemoteNotification
{
    UIApplication *application = [UIApplication sharedApplication];
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
    [application registerUserNotificationSettings:settings];
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"deviceToken:%@", deviceToken);
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (token) {
        [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"kDeviceToken"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"%@", userInfo);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"%@", error);
}

#pragma mark - System delegate

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

}

@end
