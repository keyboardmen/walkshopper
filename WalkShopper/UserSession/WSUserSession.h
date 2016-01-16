//
//  WSUserSession.h
//  WalkShopper
//
//  Created by Ding Yi on 15/9/23.
//  Copyright (c) 2015年 Ding Yi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSUserSession : NSObject

@property (assign, nonatomic) BOOL isLogin;

@property (nonatomic, strong, readonly) NSString *appId;
@property (nonatomic, strong, readonly) NSString *aesKey;
@property (nonatomic, strong, readonly) NSString *loginUserName;
@property (nonatomic, strong, readonly) NSString *loginToken;

@property (assign, nonatomic) BOOL hasLogin;

+ (WSUserSession *)sharedSession;
- (void)autoLogin;
- (void)logout;
- (void)saveLoginToken:(NSString *)loginToken;
- (NSString *)readLoginToken;

@end
