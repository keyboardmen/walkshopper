//
//  WSSellerPublishInfo.h
//  WalkShopper
//
//  Created by 丁 一 on 16/2/8.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSSellerPublishInfo : NSObject

@property (strong, nonatomic) NSString *publishTitle;
@property (strong, nonatomic) NSArray *labels;
@property (strong, nonatomic) NSString *commission;
@property (strong, nonatomic) NSString *publishDesc;
@property (strong, nonatomic) NSArray *imageArray;

@end
