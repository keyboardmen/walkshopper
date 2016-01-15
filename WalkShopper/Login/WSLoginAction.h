//
//  WSLoginAction.h
//  WalkShopper
//
//  Created by 丁 一 on 15/12/14.
//  Copyright © 2015年 Ding Yi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SimpleCompletionBlock)(void);

@interface WSLoginAction : NSObject

+ (instancetype)sharedInstance;
+ (void)loginWithSuccessBlock:(SimpleCompletionBlock)successBlock andFailureBlock:(SimpleCompletionBlock)failureBlock;

@end
