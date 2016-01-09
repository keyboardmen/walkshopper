//
//  WSAppGeneralConfiguration.h
//  WalkShopper
//
//  Created by 丁 一 on 15/9/27.
//  Copyright © 2015年 Ding Yi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSAppGeneralConfiguration : NSObject

@property (nonatomic, strong, readonly) NSString *appId;
@property (nonatomic, strong, readonly) NSString *aesKey;
@property (nonatomic, strong, readonly) NSString *APILevel;

+ (instancetype)sharedInstance;
- (void)registerAppInServer;
- (NSString *)getUniqueID;

@end
