//
//  NSString+Additions.m
//  WalkShopper
//
//  Created by 丁 一 on 16/1/9.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

- (NSString *)ws_URLEncodedString
{
    NSString *result = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                             (__bridge CFStringRef)self,
                                                                                             NULL,
                                                                                             CFSTR("!*'()^;:@&=+$,/?%#[]"),
                                                                                             kCFStringEncodingUTF8);
    return result;
}

- (NSString*)ws_URLDecodedString
{
    NSString *result = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                             (__bridge CFStringRef)self,
                                                                                                             CFSTR(""),
                                                                                                             kCFStringEncodingUTF8);
    return result;
}

- (NSDictionary *)ws_urlParamsDecodeDictionary
{
    NSArray *pairs = [self componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        if (kv.count == 2) {
            NSString *key = [kv objectAtIndex:0];
            NSString *value = [[kv objectAtIndex:1] ws_URLDecodedString];
            [params setObject:value forKey:key];
        }
    }
    return [NSDictionary dictionaryWithDictionary:params];
}

- (BOOL)ws_isEmptyOrWhitespace {
    return !self.length ||
    ![self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length;
}

@end
