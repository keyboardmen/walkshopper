//
//  WSLoginAction.m
//  WalkShopper
//
//  Created by 丁 一 on 15/12/14.
//  Copyright © 2015年 Ding Yi. All rights reserved.
//

#import "WSLoginAction.h"
#import "WSLoginViewController.h"

@interface WSLoginActionCallback: NSObject

@property (nonatomic,copy) SimpleCompletionBlock successBlock;
@property (nonatomic,copy) SimpleCompletionBlock failureBlock;

@property (nonatomic,assign) BOOL hasRun;

@end

@implementation WSLoginActionCallback

@end

@interface WSLoginAction () <WSLoginViewControllerDelegate>

@property (nonatomic, strong) UIViewController *loginViewController;
@property (nonatomic, strong) NSMutableArray *callBacks;

@end

@implementation WSLoginAction

+ (instancetype)sharedInstance
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

+ (void)loginWithSuccessBlock:(SimpleCompletionBlock)successBlock andFailureBlock:(SimpleCompletionBlock)failureBlock
{
    WSLoginActionCallback *callBack = [WSLoginActionCallback new];
    callBack.successBlock = successBlock;
    callBack.failureBlock = failureBlock;
    [[[self sharedInstance] callBacks] addObject:callBack];
    [[self sharedInstance] show];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _callBacks = [NSMutableArray new];
    }
    return self;
}

- (void)doneWithSuccess
{
    for (WSLoginActionCallback *callBack in self.callBacks) {
        if (callBack.successBlock && !callBack.hasRun) {
            callBack.hasRun = YES;
            callBack.successBlock();
        }
    }
    
    [self destroy];
}

- (void)doneWithFailure
{
    for (WSLoginActionCallback *callBack in self.callBacks) {
        if (callBack.failureBlock && !callBack.hasRun) {
            callBack.hasRun = YES;
            callBack.failureBlock();
        }
    }
    
    [self destroy];
}

- (void)show
{
    if (self.loginViewController) {
        return;
    }
    
    if ([WSUserSession sharedSession].hasLogin) {
        [self doneWithSuccess];
    } else {
        WSLoginViewController *loginViewController = [WSLoginViewController initLoginViewController];
        loginViewController.loginDelegate = self;

        UINavigationController *naviViewController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
        [[UIViewController topmostViewController] presentViewController:naviViewController animated:YES completion:nil];
        self.loginViewController = naviViewController;
    }
}

- (void)destroy
{
    self.loginViewController = nil;
    [self.callBacks removeAllObjects];
}

#pragma mark - LoginControllerDelegate

- (void)loginController:(WSLoginViewController *)controller completeWithResult:(BOOL)sucess
{
    __weak typeof (self) weakSelf = self;
    self.loginViewController = nil;
    [controller dismissViewControllerAnimated:YES completion:^{
        if (sucess) {
            [weakSelf doneWithSuccess];
        } else {
            [weakSelf doneWithFailure];
        }
    }];
}

@end
