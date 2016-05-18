//
//  WSBaseObject.h
//  WalkShopper
//
//  Created by ShawnDu on 16/5/18.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface WSBaseObject : JSONModel

- (NSArray *)getAllProperties;
- (NSDictionary *)properties_aps:(BOOL)hasValue;
@end
