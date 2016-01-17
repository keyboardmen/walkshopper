//
//  NSString+Additions.h
//  WalkShopper
//
//  Created by 丁 一 on 16/1/9.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additions)

- (NSString *)ws_URLEncodedString;
- (NSString*)ws_URLDecodedString;
- (NSDictionary *)ws_urlParamsDecodeDictionary;
- (BOOL)ws_isEmptyOrWhitespace;

@end

#define EMPTY_STRING_IF_NIL(a) (((a) == nil) ? @"" : (a))