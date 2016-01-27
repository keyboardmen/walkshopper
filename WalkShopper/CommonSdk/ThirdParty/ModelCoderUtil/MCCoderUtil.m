//
//  MCCoderUtil.h
//  ModelCoder
//
//  Created by 丁 一 on 16/1/24.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import "MCCoderUtil.h"

@implementation  MCCoderUtil

+ (BOOL)boolFromDictionary:(NSDictionary*)dict ofKey:(NSString *)key defaultValue:(BOOL)defaultValue
{
    NSObject *object = [dict valueForKey:key];
    
    if (object == nil || object == [NSNull null]) {
        return defaultValue;
    }
    
    if ([object respondsToSelector:@selector(boolValue)]) {
        return [(id)object boolValue];
    }
    return defaultValue;
}

+ (NSInteger)integerFromDictionary:(NSDictionary*)dict ofKey:(NSString *)key defaultValue:(NSInteger)defaultValue
{
    NSObject *object = [dict valueForKey:key];
    
    if (object == nil || object == [NSNull null]) {
        return defaultValue;
    }
    
    if ([object respondsToSelector:@selector(integerValue)]) {
        return [(id)object integerValue];
    }
    return defaultValue;
}

+ (NSUInteger)uintegerFromDictionary:(NSDictionary*)dict ofKey:(NSString *)key defaultValue:(NSUInteger)defaultValue {
    NSObject *object = [dict valueForKey:key];
    
    if (object == nil || object == [NSNull null]) {
        return defaultValue;
    }
    
    if ([object respondsToSelector:@selector(unsignedIntegerValue)]) {
        return [(id)object unsignedIntegerValue];
    }
    return defaultValue;
}

+ (long long)longFromDictionary:(NSDictionary*)dict ofKey:(NSString *)key defaultValue:(long long)defaultValue
{
    NSObject *object = [dict valueForKey:key];
    
    if (object == nil || object == [NSNull null]) {
        return defaultValue;
    }
    
    if ([object respondsToSelector:@selector(longLongValue)]) {
        return [(id)object longLongValue];
    }
    return defaultValue;
}

+ (double)doubleFromDictionary:(NSDictionary*)dict ofKey:(NSString *)key defaultValue:(double)defaultValue
{
    NSObject *object = [dict valueForKey:key];
    
    if (object == nil || object == [NSNull null]) {
        return defaultValue;
    }
    
    if ([object respondsToSelector:@selector(doubleValue)]) {
        return [(id)object doubleValue];
    }
    return defaultValue;
}

+ (float)floatFromDictionary:(NSDictionary*)dict ofKey:(NSString *)key defaultValue:(float)defaultValue
{
    NSObject *object = [dict valueForKey:key];
    
    if (object == nil || object == [NSNull null]) {
        return defaultValue;
    }
    
    if ([object respondsToSelector:@selector(floatValue)]) {
        return [(id)object floatValue];
    }
    return defaultValue;
}

+ (NSString *)stringFromDictionary:(NSDictionary*)dict ofKey:(NSString *)key  defaultValue:(NSString*)defaultValue;
{
    NSObject *object = [dict valueForKey:key];
    
    if (object == nil || object == [NSNull null]) {
        return defaultValue;
    }
    
    if ([object isKindOfClass:[NSString class]]) {
        return (NSString *)object;
    }
    
    if ([object isKindOfClass:[NSNumber class]]) {
        static NSNumberFormatter *MCCoderUtilNumberFormatter = nil;
        if (!MCCoderUtilNumberFormatter) {
            MCCoderUtilNumberFormatter = [[NSNumberFormatter alloc]init];
        }
        MCCoderUtilNumberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        MCCoderUtilNumberFormatter.groupingSeparator = @"";
        return [MCCoderUtilNumberFormatter stringFromNumber:(NSNumber *)object];
    }
    
    return [NSString stringWithFormat:@"%@",object];
}

@end


