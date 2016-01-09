//
//  NSString+Crypt.m
//  WalkShopper
//
//  Created by 丁 一 on 16/1/9.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import "NSString+Crypt.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Crypt)

- (unichar)StringToASCIIChar:(NSString *)str
{
    if ([str length] < 2) {
        return 0;
    }
    unichar one = [str characterAtIndex:0];
    unichar two = [str characterAtIndex:1];
    if(('0'<=one) && (one<='9')) {
        one=one-'0';
    }
    if(('a'<=one) && (one<='z')) {
        one=one-'a'+10;
    }
    if(('A'<=one) && (one<='Z')) {
        one=one-'A'+10;
    }
    if(('0'<=two) && (two<='9')) {
        two=two-'0';
    }
    if(('a'<=two) && (two<='z')) {
        two=two-'a'+10;
    }
    if(('A'<=two) && (two<='Z')) {
        two=two-'A'+10;
    }
    return one*16+two;
}

- (NSData *)base16Data
{
    if ([self length]%2 != 0) {
        return nil;
    }
    unsigned char key[[self length]/2+1];
    bzero(key, [self length]/2+1);
    for (int i=0; i<[self length]/2; i++) {
        NSString *str = [self substringWithRange:NSMakeRange(2*i, 2)];
        key[i] = [self StringToASCIIChar:str];
    }
    return [NSData dataWithBytes:key length:[self length]/2];
}

- (NSString *)ws_md5String
{
    if ([self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++) {
        [outputString appendFormat:@"%02x", outputBuffer[count]];
    }
    
    return outputString;
}





@end
