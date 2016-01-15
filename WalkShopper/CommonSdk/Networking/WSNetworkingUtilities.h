//
//  WSNetworkingUtilities.h
//  WalkShopper
//
//  Created by 丁 一 on 15/9/27.
//  Copyright © 2015年 Ding Yi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSNetworkingUtilities : NSObject


+ (instancetype)sharedInstance;
- (NSDictionary *)commonHttpParameters;

- (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
- (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
