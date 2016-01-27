//
//  MCCoderUtil.m
//  ModelCoder
//
//  Created by 丁 一 on 16/1/24.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ENCODE_BASIC_PROPERTY(property,type) [aCoder encode##type:self.property forKey:@#property]
#define ENCODE_OBJECT_PROPERTY(property) if(self.property) {[aCoder encodeObject:self.property forKey:@#property];}
#define DECODE_PROPERTY(property,type) self.property = (typeof(self.property))[aDecoder decode##type##ForKey:@#property]

@interface MCCoderUtil : NSObject

/**
 *  @param defaulValue 若key对应值为空, 则返回此默认值.
 *
 *  @return 返回key对应值的bool值, 如果值为nil或NSNull, 返回defaultValue.
 */
+ (BOOL)boolFromDictionary:(NSDictionary*)dict ofKey:(NSString *)key defaultValue:(BOOL)defaultValue;

/**
 *  @param defaulValue 若key对应值为空, 则返回此默认值.
 *
 *  @return 返回key对应值的integer值, 如果值为nil或NSNull, 返回defaultValue.
 */
+ (NSInteger)integerFromDictionary:(NSDictionary*)dict ofKey:(NSString *)key defaultValue:(NSInteger)defaultValue;

/**
 *  @param defaulValue 若key对应值为空, 则返回此默认值.
 *
 *  @return 返回key对应值的uinteger值, 如果值为nil或NSNull, 返回defaultValue.
 */
+ (NSUInteger)uintegerFromDictionary:(NSDictionary*)dict ofKey:(NSString *)key defaultValue:(NSUInteger)defaultValue;

/**
 *  @param defaulValue 若key对应值为空, 则返回此默认值.
 *
 *  @return 返回key对应值的long值, 如果值为nil或NSNull, 返回defaultValue.
 */
+ (long long)longFromDictionary:(NSDictionary*)dict ofKey:(NSString *)key defaultValue:(long long)defaultValue;

/**
 *  @param defaulValue 若key对应值为空, 则返回此默认值.
 *
 *  @return 返回key对应值的double值, 如果值为nil或NSNull, 返回defaultValue.
 */
+ (double)doubleFromDictionary:(NSDictionary*)dict ofKey:(NSString *)key defaultValue:(double)defaultValue;

/**
 *  @param defaulValue 若key对应值为空, 则返回此默认值.
 *
 *  @return 返回key对应值的float值, 如果值为nil或NSNull, 返回defaultValue.
 */
+ (float)floatFromDictionary:(NSDictionary*)dict ofKey:(NSString *)key defaultValue:(float)defaultValue;

/**
 *  @return 返回key对应值的字符串形式, 若值为nil或NSNull, 返回空字符串.
 */
+ (NSString *)stringFromDictionary:(NSDictionary*)dict ofKey:(NSString *)key defaultValue:(NSString*)defaultValue;


@end
