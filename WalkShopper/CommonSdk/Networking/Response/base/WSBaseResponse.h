//
//  WSBaseResponse.h
//  WalkShopper
//
//  Created by ShawnDu on 16/5/18.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import "WSBaseObject.h"

@interface WSBaseResponse : WSBaseObject

@property(nonatomic, copy)  NSString        *retCode;
@property(nonatomic, copy)  NSString        *retDesc;
@end
