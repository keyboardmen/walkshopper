
#import "UIImage+Additions.h"


@implementation UIImage(Additions)

+ (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage
{
    CGFloat kScreenWidth = [UIDevice screenWidth];
    
    if (sourceImage.size.width < kScreenWidth) return sourceImage;
    
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = kScreenWidth;
        btWidth = sourceImage.size.width * (kScreenWidth / sourceImage.size.height);
    } else {
        btWidth = kScreenWidth;
        btHeight = sourceImage.size.height * (kScreenWidth / sourceImage.size.width);
    }
    
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [UIImage imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

+ (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize
{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor) scaleFactor = widthFactor; // scale to fit height
        else scaleFactor = heightFactor;                           // scale to fit width
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if (newImage == nil) NSLog(@"could not scale image");
    
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)compressImage:(UIImage *)image constraintSize:(NSInteger)maxSize
{
    CGSize originalSize = CGSizeMake(image.size.width * image.scale, image.size.height * image.scale);
    CGFloat maxValue = MAX(originalSize.width, originalSize.height);
    
    if (maxValue <= maxSize) {
        return image;
    }
    
    CGFloat scaleFactor = maxSize * 1.0f / maxValue;
    NSInteger realWidth = originalSize.width * scaleFactor;
    NSInteger realHeight = originalSize.height * scaleFactor;
    CGSize realSize = CGSizeMake(realWidth, realHeight);
    
    UIGraphicsBeginImageContextWithOptions(realSize, YES, 1);
    [image drawInRect:CGRectMake(0, 0, realWidth, realHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)crop:(CGRect)rect
{
    rect = CGRectMake(rect.origin.x*self.scale,
                      rect.origin.y*self.scale,
                      rect.size.width*self.scale,
                      rect.size.height*self.scale);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage *result = [UIImage imageWithCGImage:imageRef
                                          scale:self.scale
                                    orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return result;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)resizedRoundImageWithRect:(CGRect)rect borderWidth:(CGFloat)borderWidth
{
    CGFloat diameter = rect.size.width - borderWidth * 2;
    //创建图片上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(rect.size.width, rect.size.width), NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, rect.size.width, rect.size.width));
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillPath(context);
    CGContextAddEllipseInRect(context, CGRectMake(borderWidth, borderWidth, diameter, diameter));
    CGContextClip(context);
    //绘制头像
    [self drawInRect:CGRectMake(borderWidth, borderWidth, diameter, diameter)];
    //取出整个图片上下文的图片
    UIImage *roundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return roundImage;
}

@end




