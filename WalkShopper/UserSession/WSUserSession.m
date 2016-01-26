//
//  WSUserSession.m
//  WalkShopper
//
//  Created by Ding Yi on 15/9/23.
//  Copyright (c) 2015年 Ding Yi. All rights reserved.
//

#import "WSUserSession.h"
#import "WSNetworkingResponseObject.h"
#import "NSString+Additions.h"
#import <WalkShopper-Swift.h>

static NSString * const WSLoginActionDomain = @"WSLoginActionDomain";
NSString * const WSUserSessionLoginStatusChangeNotification = @"WSUserSessionLoginStatusChangeNotification";

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

- (void)loginWithParamters:(NSDictionary *)parameters completionBlock:(void(^)(BOOL success, NSError *error))completionBlk
{
    NSString *username = [parameters objectForKey:@"username"];
    NSString *url = [[WSCommonWebUrls sharedInstance] loginUrl];
    
    __weak typeof(self) weakSelf = self;
    
    [[WSNetworkingUtilities sharedInstance] POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, WSNetworkingResponseObject *responseObject) {
        if (responseObject.retCode == WSNetworkingResponseSuccess) {
            weakSelf.hasLogin = YES;
            NSString *loginToken = [responseObject.ret objectForKey:@"loginToken"];
            [weakSelf saveUsername:username];
            [weakSelf saveLoginToken:loginToken];
            if (completionBlk) {
                [WSChatRegister autoRegister:username];
                completionBlk(YES, nil);
            }
        } else {
            //weakSelf.hasLogin = NO;
            if (completionBlk) {
                NSDictionary *userInfo = @{NSLocalizedDescriptionKey:EMPTY_STRING_IF_NIL(responseObject.retDesc)};
                NSError *error = [NSError errorWithDomain:WSLoginActionDomain code:responseObject.retCode userInfo:userInfo];
                completionBlk(NO, error);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //weakSelf.hasLogin = NO;
        if (completionBlk) {
            completionBlk(NO, error);
        }
    }];
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
            weakSelf.hasLogin = YES;
            NSString *loginToken = [responseObject.ret objectForKey:@"loginToken"];
            [weakSelf saveLoginToken:loginToken];
            [WSChatRegister autoRegister:_loginUserName];
        } else {
            //weakSelf.hasLogin = NO;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //weakSelf.hasLogin = NO;
    }];
    
}

- (void)logoutWithSuccessBLk:(void(^)(void))successBlk withFailureBlk:(void(^)(void))failureBlk
{
    WS(weakSelf)
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:@{@"loginToken":_loginToken}];
    NSString *url = [[WSCommonWebUrls sharedInstance] loginUrl];
    [[WSNetworkingUtilities sharedInstance] POST:url parameters:param success:^(AFHTTPRequestOperation *operation, WSNetworkingResponseObject *responseObject) {
        if (responseObject.retCode == WSNetworkingResponseSuccess) {
            weakSelf.hasLogin = NO;
            [weakSelf removeUsername];
            [weakSelf removeLoginToken];
            if (successBlk) {
                successBlk();
            }
        } else {
            [RKDropdownAlert title:WSNetworkErrorGeneralHint];
            if (failureBlk) {
                failureBlk();
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [RKDropdownAlert title:WSNetworkErrorGeneralHint];
        if (failureBlk) {
            failureBlk();
        }
    }];
    
}

- (void)saveUsername:(NSString *)username
{
    if (username.length == 0) {
        return;
    }
    
    self.loginUserName = username;
    
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

- (void)removeUsername
{
    self.loginUserName = nil;
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:@"username"];
    [ud synchronize];
}

- (void)saveLoginToken:(NSString *)loginToken
{
    if (loginToken.length == 0) {
        return;
    }
    
    self.loginToken = loginToken;
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:loginToken forKey:@"loginToken"];
    [ud synchronize];
}

- (NSString *)readLoginToken
{
    self.loginToken = nil;
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *loginToken = [ud objectForKey:@"loginToken"];
    
    return loginToken;
}

- (void)removeLoginToken
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:@"loginToken"];
    [ud synchronize];
}

#pragma mark - getter & setter

- (void)setHasLogin:(BOOL)hasLogin
{
    _hasLogin = hasLogin;
    [[NSNotificationCenter defaultCenter] postNotificationName:WSUserSessionLoginStatusChangeNotification object:nil];
}

@end
