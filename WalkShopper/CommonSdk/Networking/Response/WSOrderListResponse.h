//
//  WSOrderListResponse.h
//  WalkShopper
//
//  Created by ShawnDu on 16/5/18.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import "WSBaseResponse.h"

@interface WSOrderListData : WSBaseObject

@end

@interface WSOrderListResponse : WSBaseResponse
@property (nonatomic, strong) WSOrderListData *ret;
@end
