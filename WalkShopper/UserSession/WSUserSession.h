//
//  WSUserSession.h
//  WalkShopper
//
//  Created by Ding Yi on 15/9/23.
//  Copyright (c) 2015年 Ding Yi. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const WSUserSessionLoginStatusChangeNotification;


@interface WSUserSession : NSObject

@property (assign, nonatomic) BOOL isLoginning;

@property (nonatomic, strong, readonly) NSString *appId;
@property (nonatomic, strong, readonly) NSString *aesKey;
@property (nonatomic, strong, readonly) NSString *loginUserName;
@property (nonatomic, strong, readonly) NSString *loginToken;

@property (assign, nonatomic) BOOL hasLogin;

+ (WSUserSession *)sharedSession;
- (void)loginWithParamters:(NSDictionary *)parameters completionBlock:(void(^)(BOOL success, NSError *error))completionBlk;
- (void)autoLogin;
- (void)logout;
- (void)saveUsername:(NSString *)username;
- (NSString *)readUsername;
- (void)saveLoginToken:(NSString *)loginToken;
- (NSString *)readLoginToken;

@end
