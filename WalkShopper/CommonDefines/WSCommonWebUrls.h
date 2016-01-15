//
//  WSCommonWebUrls.h
//  WalkShopper
//
//  Created by 丁 一 on 16/1/10.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSCommonWebUrls : NSObject

+ (instancetype)sharedInstance;

//注册接口
- (NSString *)registerUrl;
//登录接口
- (NSString *)loginUrl;

@end
