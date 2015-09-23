//
//  WSUserSession.m
//  WalkShopper
//
//  Created by Ding Yi on 15/9/23.
//  Copyright (c) 2015年 Ding Yi. All rights reserved.
//

#import "WSUserSession.h"

@interface WSUserSession ()

@end

@implementation WSUserSession

+ (WSUserSession *)sharedSession
{
    static WSUserSession *instance;
    
    if (instance == nil) {
        @synchronized(self) {
            if (instance == nil) {
                instance = [[WSUserSession alloc] init];
            }
        }
    }
    
    return instance;
}

@end
