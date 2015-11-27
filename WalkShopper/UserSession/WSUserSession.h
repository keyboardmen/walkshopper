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

+ (WSUserSession *)sharedSession;

@end
