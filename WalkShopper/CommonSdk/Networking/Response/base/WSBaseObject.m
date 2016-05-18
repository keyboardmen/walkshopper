//
//  WSBaseObject.m
//  WalkShopper
//
//  Created by ShawnDu on 16/5/18.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import "WSBaseObject.h"

@implementation WSBaseObject

+(BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

#pragma mark - NSCoding
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        unsigned int outCount;
        objc_property_t *properties = class_copyPropertyList([self class], &outCount);
        for (int i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            NSString *strPropertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            NSString *strPropertyPrivateName = [@"_" stringByAppendingString:strPropertyName];
            id idDecoderValue = [aDecoder decodeObjectForKey:strPropertyName];
            if (idDecoderValue) {
                //NSLog(@"%@:%@", strPropertyPrivateName, idDecoderValue);
                [self setValue:idDecoderValue forKeyPath:strPropertyPrivateName];
            }
        }
        
        free(properties);
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        
        NSString *strPropertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        id idValue = [self valueForKey:strPropertyName];
        if (idValue) {
            //NSLog(%@"%@:%@", strPropertyName, idValue);
            //            NSLog(@"%@",strPropertyName);
            [aCoder encodeObject:idValue forKey:strPropertyName];
        }
    }
    
    free(properties);
}

- (NSArray *)getAllProperties
{
    u_int count;
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++)
    {
        const char* propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return propertiesArray;
}

- (NSDictionary *)properties_aps:(BOOL)hasValue
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = nil;
        if (!hasValue) {
            propertyValue = [NSNull null];
        }else{
            propertyValue = [self valueForKey:(NSString *)propertyName];
            if (!propertyValue) {
                propertyValue = [NSNull null];
            }
        }
        [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}

@end
