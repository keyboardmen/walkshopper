//
//  WSUserAccount.m
//  WalkShopper
//
//  Created by 丁 一 on 16/1/28.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import "WSUserAccount.h"

@interface WSUserAccount ()

@property (copy, nonatomic, readwrite) NSString *username;
@property (copy, nonatomic, readwrite) NSString *nickname;
@property (copy, nonatomic, readwrite) NSString *gender;
@property (copy, nonatomic, readwrite) NSString *avatarImageThumbnailsUrl;
@property (copy, nonatomic, readwrite) NSString *avatarImageOriginalUrl;
@property (copy, nonatomic, readwrite) NSString *company;
@property (assign, nonatomic, readwrite) BOOL companyVerification;

@end

@implementation WSUserAccount

- (id)initWithJson:(NSDictionary *)json
{
    if (self = [super init]) {
        self.username = [MCCoderUtil stringFromDictionary:json ofKey:@"username" defaultValue:@""];
        self.nickname = [MCCoderUtil stringFromDictionary:json ofKey:@"nickname" defaultValue:@""];
        self.gender = [MCCoderUtil stringFromDictionary:json ofKey:@"gender" defaultValue:@""];
        self.avatarImageThumbnailsUrl = [MCCoderUtil stringFromDictionary:json ofKey:@"avatarImageThumbnailsUrl" defaultValue:@""];
        self.avatarImageOriginalUrl = [MCCoderUtil stringFromDictionary:json ofKey:@"avatarImageOriginalUrl" defaultValue:@""];
        self.company = [MCCoderUtil stringFromDictionary:json ofKey:@"company" defaultValue:@""];
        self.companyVerification = [MCCoderUtil boolFromDictionary:json ofKey:@"companyVerification" defaultValue:NO];
    }
    
    return self;
}

- (void)changeUsername:(NSString *)username
{
    _username = username;
}

- (void)changeNickname:(NSString *)nickname
{
    _nickname = nickname;
}

- (void)changeGender:(NSString *)gender
{
    _gender = gender;
}

- (void)changeCompany:(NSString *)company
{
    _company = company;
}

- (void)changeCompanyVerification:(BOOL)companyVerification
{
    _companyVerification = companyVerification;
}

@end
