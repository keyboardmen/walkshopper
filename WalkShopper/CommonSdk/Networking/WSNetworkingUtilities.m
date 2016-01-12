//
//  WSNetworkingUtilities.m
//  WalkShopper
//
//  Created by 丁 一 on 15/9/27.
//  Copyright © 2015年 Ding Yi. All rights reserved.
//

#import "WSNetworkingUtilities.h"
#import "WSAppGeneralConfiguration.h"

@implementation WSNetworkingUtilities

+ (instancetype)sharedInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

- (NSDictionary *)commonHttpParameters
{
    NSDictionary *params = @{ @"uniqueId":[[WSAppGeneralConfiguration sharedInstance] getUniqueID]
                              , @"systemName":[[UIDevice currentDevice] systemName]
                              , @"systemVersion":[[UIDevice currentDevice] systemVersion]
                              , @"deviceType":[[UIDevice currentDevice] model]
                              , @"apiLevel":[[WSAppGeneralConfiguration sharedInstance] APILevel] };
    
    return params;
}

- (void)GET:(NSString *)URLString
        parameters:(id)parameters
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param addEntriesFromDictionary:parameters];
    [param addEntriesFromDictionary:[self commonHttpParameters]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:URLString parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        success(operation, responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(operation, error);
    }];
}

- (void)POST:(NSString *)URLString
        parameters:(id)parameters
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param addEntriesFromDictionary:parameters];
    [param addEntriesFromDictionary:[self commonHttpParameters]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:URLString parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        success(operation, responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(operation, error);
    }];
}



@end
