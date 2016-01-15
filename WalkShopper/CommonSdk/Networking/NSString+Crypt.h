//
//  NSString+Crypt.h
//  WalkShopper
//
//  Created by 丁 一 on 16/1/9.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Crypt)

- (unichar)StringToASCIIChar:(NSString *)str;
- (NSData *)base16Data;
- (NSString *)ws_md5String;

@end
