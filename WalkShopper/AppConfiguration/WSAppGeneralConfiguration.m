//
//  WSAppGeneralConfiguration.m
//  WalkShopper
//
//  Created by 丁 一 on 15/9/27.
//  Copyright © 2015年 Ding Yi. All rights reserved.
//

#import "WSAppGeneralConfiguration.h"
#import <AdSupport/ASIdentifierManager.h>
#import "SSKeychain.h"

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

- (void)registerAppInServer
{
    NSLog(@"%@", self.uniqueID);
}

- (NSString *)uniqueID
{
    NSString *uId = nil;
    
    if ([[self appleIFA] length] > 0) {
        uId = [self appleIFA];
    } else if ([[self appleIFV] length] > 0) {
        uId = [self appleIFV];
    } else {
        uId = [self randomUUID];
    }
 

    return uId;
}

- (NSString *)appleIFA
{
    NSString *ifa = nil;
    Class ASIdentifierManagerClass = NSClassFromString(@"ASIdentifierManager");
    // a dynamic way of checking if AdSupport.framework is available
    if (ASIdentifierManagerClass) {
        ifa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }
    return ifa;
}

- (NSString *)appleIFV
{
    if(NSClassFromString(@"UIDevice") && [UIDevice instancesRespondToSelector:@selector(identifierForVendor)]) {
        // only available in iOS >= 6.0
        return [[UIDevice currentDevice].identifierForVendor UUIDString];
    }
    return nil;
}

- (NSString *)randomUUID
{
    // only available in iOS >= 6.0
    if(NSClassFromString(@"NSUUID")) {
        return [[NSUUID UUID] UUIDString];
    }
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef cfuuid = CFUUIDCreateString(kCFAllocatorDefault, uuidRef);
    CFRelease(uuidRef);
    NSString *uuid = [((__bridge NSString *) cfuuid) copy];
    CFRelease(cfuuid);
    return uuid;
}

@end
