//
//  NSData+Crypt.h
//  WalkShopper
//
//  Created by 丁 一 on 15/9/27.
//  Copyright © 2015年 Ding Yi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Crypt)

- (NSData *)ws_md5;
- (NSString *)ws_base16String;
- (NSData *)ws_AES256EncryptWithKey:(NSString *)key;
- (NSData *)ws_AES256DecryptWithKey:(NSString *)key;



//- (NSData *)EncodeRsa:(SecKeyRef)publicKey;
//- (NSData *)DecodeRsa:(SecKeyRef)privateKey;
//
//
//- (NSData *)getSignatureBytes:(SecKeyRef)prikey;
//- (BOOL)verifySignature:(SecKeyRef)publicKey signature:(NSData *)sign ;

@end
