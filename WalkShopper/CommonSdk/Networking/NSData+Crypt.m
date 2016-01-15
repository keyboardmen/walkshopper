//
//  NSData+Crypt.m
//  WalkShopper
//
//  Created by 丁 一 on 15/9/27.
//  Copyright © 2015年 Ding Yi. All rights reserved.
//

#import "NSData+Crypt.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import <Security/Security.h>

@implementation NSData (Crypt)

- (unichar)ws_StringToASCIIChar:(NSString *)str{
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

- (NSData *)ws_base16DataWithString:(NSString *)string
{
    if ([string length]%2 != 0) {
        return nil;
    }
    unsigned char key[[string length]/2+1];
    bzero(key, [string length]/2+1);
    for (int i=0; i<[string length]/2; i++) {
        NSString *str = [string substringWithRange:NSMakeRange(2*i, 2)];
        key[i] = [self ws_StringToASCIIChar:str];
    }
    return [NSData dataWithBytes:key length:[self length]/2];
}

- (NSString *)ws_base16String {
    NSMutableString *str = [NSMutableString string];
    const unsigned char  *chrs = (const unsigned char *)[self bytes];
    for (int i=0; i<[self length]; i++) {
        [str appendFormat:@"%02X",chrs[i]];
    }
    return str;
}

- (NSData *) ws_md5{
    const char* str = self.bytes;
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    //CC_MD5(str, strlen(str), result);   长度不能这么取，xugx
    CC_MD5(str, (CC_LONG)self.length, result);
    NSData *data = [NSData dataWithBytes:result length:CC_MD5_DIGEST_LENGTH];
    
    return data;
}

- (NSData *)ws_AES256EncryptWithKey:(NSString *)key {
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    unsigned char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    // fetch key data
    //[key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSData *keyData = [self ws_base16DataWithString:key];
    [keyData getBytes:keyPtr length:[keyData length]];
    
    NSUInteger dataLength = [self length];
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionECBMode + kCCOptionPKCS7Padding,keyPtr, kCCKeySizeAES128,
                                          NULL /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
}

- (NSData *)ws_AES256DecryptWithKey:(NSString *)key {
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    unsigned char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    NSData *keyData = [self ws_base16DataWithString:key];
    [keyData getBytes:keyPtr length:[keyData length]];
    
    NSUInteger dataLength = [self length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionECBMode + kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES128,
                                          NULL /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
}

//- (NSData *)Encode3DESWithKey:(NSString *)key; {
//
//	char keyPtr[kCCKeySize3DES+1]; // room for terminator (unused)
//	bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
//
//	// fetch key data
//	[key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
//
//	NSUInteger dataLength = [self length];
//
//	//See the doc: For block ciphers, the output size will always be less than or
//	//equal to the input size plus the size of one block.
//	//That's why we need to add the size of one block here
//	size_t bufferSize = dataLength + kCCBlockSize3DES;
//	void *buffer = malloc(bufferSize);
//
//	size_t numBytesDecrypted = 0;
//
//	CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithm3DES, kCCOptionPKCS7Padding|kCCOptionECBMode,
//                                          keyPtr, kCCKeySize3DES,
//                                          NULL /* initialization vector (optional) */,
//                                          [self bytes], dataLength, /* input */
//                                          buffer, bufferSize, /* output */
//                                          &numBytesDecrypted);
//
//	if (cryptStatus == kCCSuccess) {
//		//the returned NSData takes ownership of the buffer and will free it on deallocation
//        return [NSData dataWithBytes:(const void *)buffer length:(NSUInteger)numBytesDecrypted];
//
//	}
//	free(buffer); //free the buffer;
//	return nil;
//}
//
//- (NSData *)Decode3DESWithKey:(NSString *)key {
//	// 'key' should be 32 bytes for AES256, will be null-padded otherwise
//	char keyPtr[kCCKeySize3DES+1]; // room for terminator (unused)
//	bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
//
//	// fetch key data
//	[key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
//
//	NSUInteger dataLength = [self length];
//
//	//See the doc: For block ciphers, the output size will always be less than or
//	//equal to the input size plus the size of one block.
//	//That's why we need to add the size of one block here
//	size_t bufferSize = dataLength + kCCBlockSize3DES;
//	void *buffer = malloc(bufferSize);
//
//	size_t numBytesDecrypted = 0;
//
//	CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithm3DES, kCCOptionPKCS7Padding|kCCOptionECBMode,
//                                          keyPtr, kCCKeySize3DES,
//                                          NULL /* initialization vector (optional) */,
//                                          [self bytes], dataLength, /* input */
//                                          buffer, bufferSize, /* output */
//                                          &numBytesDecrypted);
//
//	if (cryptStatus == kCCSuccess) {
//		//the returned NSData takes ownership of the buffer and will free it on deallocation
//		return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
//	}
//
//	free(buffer); //free the buffer;
//	return nil;
//}
//
//
//
//
//-(NSData *)EncodeRsa:(SecKeyRef)publicKey
//{
//
//    OSStatus sanityCheck = noErr;
//	size_t cipherBufferSize = 0;
//	size_t keyBufferSize = 0;
//
//
//	NSData * cipher = nil;
//	uint8_t * cipherBuffer = NULL;
//
//	// Calculate the buffer sizes.
//	cipherBufferSize = SecKeyGetBlockSize(publicKey);
//	keyBufferSize = [self length];
//
//    /*
//     if (kTypeOfWrapPadding == kSecPaddingNone) {
//     LOGGING_FACILITY( keyBufferSize <= cipherBufferSize, @"Nonce integer is too large and falls outside multiplicative group." );
//     } else {
//     LOGGING_FACILITY( keyBufferSize <= (cipherBufferSize - 11), @"Nonce integer is too large and falls outside multiplicative group." );
//     }
//     */
//
//	// Allocate some buffer space. I don't trust calloc.
//	cipherBuffer = malloc( cipherBufferSize * sizeof(uint8_t) );
//	memset((void *)cipherBuffer, 0x0, cipherBufferSize);
//
//	// Encrypt using the public key.
//	sanityCheck = SecKeyEncrypt(publicKey,
//                                kSecPaddingPKCS1,
//                                (const uint8_t *)[self bytes],
//                                keyBufferSize,
//                                cipherBuffer,
//                                &cipherBufferSize
//								);
//
//	//LOGGING_FACILITY1( sanityCheck == noErr, @"Error encrypting, OSStatus == %d.", sanityCheck );
//	// Build up cipher text blob.
//	cipher = [NSData dataWithBytes:(const void *)cipherBuffer length:(NSUInteger)cipherBufferSize];
//
//	if (cipherBuffer)
//    {
//        free(cipherBuffer);
//    }
//	return cipher;
//
//
//}
//
//
//
//- (NSData *)DecodeRsa:(SecKeyRef)privateKey
//{
//	OSStatus sanityCheck = noErr;
//	size_t cipherBufferSize = 0;
//	size_t keyBufferSize = 0;
//
//	NSData * key = nil;
//	uint8_t * keyBuffer = NULL;
//
//	//LOGGING_FACILITY( privateKey != NULL, @"No private key found in the keychain." );
//
//	// Calculate the buffer sizes.
//	cipherBufferSize = SecKeyGetBlockSize(privateKey);
//	keyBufferSize = [self length];
//
//	//LOGGING_FACILITY( keyBufferSize <= cipherBufferSize, @"Encrypted nonce is too large and falls outside multiplicative group." );
//
//	// Allocate some buffer space. I don't trust calloc.
//	keyBuffer = malloc( keyBufferSize * sizeof(uint8_t) );
//	memset((void *)keyBuffer, 0x0, keyBufferSize);
//
//	// Decrypt using the private key.
//	sanityCheck = SecKeyDecrypt(privateKey,
//                                kSecPaddingPKCS1,
//                                (const uint8_t *) [self bytes],
//                                cipherBufferSize,
//                                keyBuffer,
//                                &keyBufferSize
//								);
//
//	//LOGGING_FACILITY1( sanityCheck == noErr, @"Error decrypting, OSStatus == %d.", sanityCheck );
//
//	// Build up plain text blob.
//	key = [NSData dataWithBytes:(const void *)keyBuffer length:(NSUInteger)keyBufferSize];
//
//	if (keyBuffer)
//    {
//        free(keyBuffer);
//    }
//
//	return key;
//}
//
//
//
//
//
//- (NSData *)getSignatureBytes:(SecKeyRef)prikey {
//
//
//	OSStatus sanityCheck = noErr;
//	NSData * signedHash = nil;
//
//	uint8_t * signedHashBytes = NULL;
//	size_t signedHashBytesSize = 0;
//
//
//	signedHashBytesSize = SecKeyGetBlockSize(prikey);
//
//	// Malloc a buffer to hold signature.
//	signedHashBytes = malloc( signedHashBytesSize * sizeof(uint8_t) );
//	memset((void *)signedHashBytes, 0x0, signedHashBytesSize);
//
//	// Sign the SHA1 hash.
//	sanityCheck = SecKeyRawSign(	prikey,
//                                kSecPaddingPKCS1,
//                                (const uint8_t *)[[self md5] bytes],
//                                CC_MD5_DIGEST_LENGTH,
//                                (uint8_t *)signedHashBytes,
//                                &signedHashBytesSize
//								);
//
//	//LOGGING_FACILITY1( sanityCheck == noErr, @"Problem signing the SHA1 hash, OSStatus == %d.", sanityCheck );
//
//	// Build up signed SHA1 blob.
//	signedHash = [NSData dataWithBytes:(const void *)signedHashBytes length:(NSUInteger)signedHashBytesSize];
//
//	if (signedHashBytes) free(signedHashBytes);
//
//	return signedHash;
//}
//
//
//- (BOOL)verifySignature:(SecKeyRef)publicKey signature:(NSData *)sig {
//	size_t signedHashBytesSize = 0;
//	OSStatus sanityCheck = noErr;
//
//	// Get the size of the assymetric block.
//	signedHashBytesSize = SecKeyGetBlockSize(publicKey);
//
//	sanityCheck = SecKeyRawVerify(	publicKey,
//                                  kSecPaddingPKCS1, 
//                                  (const uint8_t *)[[self md5] bytes],
//                                  CC_MD5_DIGEST_LENGTH, 
//                                  (const uint8_t *)[sig bytes],
//                                  signedHashBytesSize
//								  );
//	
//	return (sanityCheck == noErr) ? YES : NO;
//}
//



@end
