//
//  WSUserSession.m
//  WalkShopper
//
//  Created by Ding Yi on 15/9/23.
//  Copyright (c) 2015年 Ding Yi. All rights reserved.
//

#import "WSUserSession.h"
#import "WSNetworkingResponseObject.h"

@interface WSUserSession ()

@property (nonatomic, strong, readwrite) NSString *loginUserName;
@property (nonatomic, strong, readwrite) NSString *loginToken;

@end

@implementation WSUserSession

+ (WSUserSession *)sharedSession
{
    static id instance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.loginUserName = [self readUsername];
        self.loginToken = [self readLoginToken];
    }
    
    return self;
}

- (void)autoLogin
{
    if ( _loginUserName.length == 0 || _loginToken.length == 0 ) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:@{@"username":_loginUserName, @"loginToken":_loginToken}];
    
    NSString *url = [[WSCommonWebUrls sharedInstance] autoLoginUrl];
    [[WSNetworkingUtilities sharedInstance] POST:url parameters:param success:^(AFHTTPRequestOperation *operation, WSNetworkingResponseObject *responseObject) {
        if (responseObject.retCode == WSNetworkingResponseSuccess) {
            weakSelf.isLogin = YES;
            NSString *loginToken = [responseObject.ret objectForKey:@"loginToken"];
            [weakSelf saveLoginToken:loginToken];
        } else {
            weakSelf.isLogin = NO;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        weakSelf.isLogin = NO;
    }];
    
}

- (void)logout
{
    
}

- (void)saveUsername:(NSString *)username
{
    if (username.length == 0) {
        return;
    }
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:username forKey:@"username"];
    [ud synchronize];
}

- (NSString *)readUsername
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *username = [ud objectForKey:@"username"];
    
    return username;
}

- (void)saveLoginToken:(NSString *)loginToken
{
    if (loginToken.length == 0) {
        return;
    }
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:loginToken forKey:@"loginToken"];
    [ud synchronize];
}

- (NSString *)readLoginToken
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *loginToken = [ud objectForKey:@"loginToken"];
    
    return loginToken;
}

@end
