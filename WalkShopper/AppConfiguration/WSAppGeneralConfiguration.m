//
//  WSAppGeneralConfiguration.m
//  WalkShopper
//
//  Created by 丁 一 on 15/9/27.
//  Copyright © 2015年 Ding Yi. All rights reserved.
//

#import "WSAppGeneralConfiguration.h"
#import <AdSupport/ASIdentifierManager.h>

@interface WSAppGeneralConfiguration ()

@property (nonatomic, strong, readwrite) NSString *appId;
@property (nonatomic, strong, readwrite) NSString *aesKey;

@property (nonatomic, strong) NSString *appName;
@property (nonatomic, strong) NSString *uniqueID;
@property (nonatomic, strong) NSString *appVersion;
@property (nonatomic, strong) NSString *deviceType;
@property (nonatomic, strong) NSString *systemName;
@property (nonatomic, strong) NSString *systemVersion;

@end

@implementation WSAppGeneralConfiguration

+ (instancetype)sharedInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}


- (NSString *)uniqueID
{
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

@end
