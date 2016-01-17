//
//  WSNetworkingUtilities.m
//  WalkShopper
//
//  Created by 丁 一 on 15/9/27.
//  Copyright © 2015年 Ding Yi. All rights reserved.
//

#import "WSNetworkingUtilities.h"
#import "WSAppGeneralConfiguration.h"
#import "WSNetworkingResponseObject.h"
#import "NSString+Additions.h"

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
    NSDictionary *params = @{ @"uniqueId":EMPTY_STRING_IF_NIL([[WSAppGeneralConfiguration sharedInstance] getUniqueID]),
                              @"systemName":EMPTY_STRING_IF_NIL([[UIDevice currentDevice] systemName]),
                              @"systemVersion":EMPTY_STRING_IF_NIL([[UIDevice currentDevice] systemVersion]),
                              @"deviceType":EMPTY_STRING_IF_NIL([[UIDevice currentDevice] model]),
                              @"apiLevel":EMPTY_STRING_IF_NIL([[WSAppGeneralConfiguration sharedInstance] APILevel]), 
                              };
    
    return params;
}

- (void)GET:(NSString *)URLString
        parameters:(id)parameters
        success:(void (^)(AFHTTPRequestOperation *operation, WSNetworkingResponseObject *responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param addEntriesFromDictionary:parameters];
    [param addEntriesFromDictionary:[self commonHttpParameters]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:URLString parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        WSNetworkingResponseObject *response = [WSNetworkingResponseObject initWithResponseObject:responseObject];
        success(operation, response);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(operation, error);
    }];
}

- (void)POST:(NSString *)URLString
        parameters:(id)parameters
        success:(void (^)(AFHTTPRequestOperation *operation, WSNetworkingResponseObject *responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param addEntriesFromDictionary:parameters];
    [param addEntriesFromDictionary:[self commonHttpParameters]];
    
//    NSDictionary *paramters = @{@"data":param};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:URLString parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        WSNetworkingResponseObject *response = [WSNetworkingResponseObject initWithResponseObject:responseObject];
        success(operation, response);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(operation, error);
    }];
}



@end
