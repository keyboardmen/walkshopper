//
//  WSNetworkingResponseObject.h
//  WalkShopper
//
//  Created by 丁 一 on 16/1/16.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSNetworkingResponseObject : NSObject

@property (assign, nonatomic) NSUInteger retCode;
@property (strong, nonatomic) NSString *retDesc;
@property (strong, nonatomic) id ret;

+ (instancetype)initWithResponseObject:(id)rawResponseObject;

@end
