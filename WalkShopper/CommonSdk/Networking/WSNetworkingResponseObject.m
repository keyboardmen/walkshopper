//
//  WSNetworkingResponseObject.m
//  WalkShopper
//
//  Created by 丁 一 on 16/1/16.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import "WSNetworkingResponseObject.h"

@implementation WSNetworkingResponseObject

+ (instancetype)initWithResponseObject:(id)rawResponseObject
{
    WSNetworkingResponseObject *response = [WSNetworkingResponseObject new];
    response.retCode = [[rawResponseObject objectForKey:@"retCode"] integerValue];
    response.retDesc = [rawResponseObject objectForKey:@"retDesc"];
    response.ret = [rawResponseObject objectForKey:@"ret"];
    
    return response;
}

@end
