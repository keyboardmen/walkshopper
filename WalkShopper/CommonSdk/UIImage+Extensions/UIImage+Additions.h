// UIImageAddtions.h
// Created by Trevor Harmon on 9/20/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.
//
// Helper methods for adding an alpha layer to an image

/**
 *  UIImage NTUIAddtion_Create
 */
#import <UIKit/UIKit.h>

@interface UIImage(Additions)

+ (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage;
+ (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize;
+ (UIImage *)compressImage:(UIImage *)image constraintSize:(NSInteger)maxSize;
- (UIImage *)crop:(CGRect)rect;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
- (UIImage *)resizedRoundImageWithRect:(CGRect)rect borderWidth:(CGFloat)borderWidth;

@end

