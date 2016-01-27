//
//  WSUserAccount.h
//  WalkShopper
//
//  Created by 丁 一 on 16/1/28.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSUserAccount : NSObject

@property (copy, nonatomic, readonly) NSString *username;
@property (copy, nonatomic, readonly) NSString *nickname;
@property (copy, nonatomic, readonly) NSString *gender;
@property (copy, nonatomic, readonly) NSString *avatarImageThumbnailsUrl;
@property (copy, nonatomic, readonly) NSString *avatarImageOriginalUrl;
@property (copy, nonatomic, readonly) NSString *company;
@property (assign, nonatomic, readonly) BOOL companyVerification;

- (id)initWithJson:(NSDictionary *)json;

- (void)changeUsername:(NSString *)username;
- (void)changeNickname:(NSString *)nickname;
- (void)changeGender:(NSString *)gender;
- (void)changeCompany:(NSString *)company;
- (void)changeCompanyVerification:(BOOL)companyVerification;

@end
