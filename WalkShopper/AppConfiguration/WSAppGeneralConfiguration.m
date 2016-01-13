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
@property (nonatomic, strong, readwrite) NSString *APILevel;

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

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _APILevel = @"1";
    }
    
    return self;
}

- (void)registerAppInServer
{

}

- (NSString *)getUniqueID
{
    self.uniqueID = [SSKeychain passwordForService:@"com.jirong.walkshopper" account:@"uniqueID"];
    
    if (self.uniqueID == nil) {
        self.uniqueID = [self generateUniqueID];
        
        NSError *error = nil;
        [SSKeychain setPassword:self.uniqueID forService:@"com.jirong.walkshopper" account:@"uniqueID" error:&error];
        NSString *errorDesc = [NSString stringWithFormat:@"uniqueID error:%@", error.localizedDescription];
        NSAssert((error == nil), errorDesc);
    }
    
    return self.uniqueID;
}

- (NSString *)generateUniqueID
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

- (NSString *)deviceToken
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:@"kDeviceToken"];
    if (token == nil) {
        token = @"";
    }
    return token;
}


@end
