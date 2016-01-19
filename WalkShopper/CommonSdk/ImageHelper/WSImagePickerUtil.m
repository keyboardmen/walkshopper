//
//  WSImagePickerUtil.m
//  WalkShopper
//
//  Created by 丁 一 on 16/1/19.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import "WSImagePickerUtil.h"


@implementation WSImagePickerUtil

+ (UIAlertController *)createImagePickerActionSheetWithController:(UIViewController *)viewController
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [viewController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"选择本地照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [actionSheet addAction:cancelAction];
    [actionSheet addAction:cameraAction];
    [actionSheet addAction:albumAction];
    
    return actionSheet;
}

+ (void)performCameraWithViewController:(UIViewController *)viewController
{
    __weak UIViewController *weakVC = viewController;
}

+ (void)performImagePickerWithViewController:(UIViewController *)viewController
{
    __weak UIViewController *weakVC = viewController;
    
}

+ (BOOL)isCameraAvailable
{
    BOOL isAvailable = YES;
    
    isAvailable = isAvailable && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    isAvailable = isAvailable && [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
    return isAvailable;
}

+ (BOOL)cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType
{
    __block BOOL result = NO;
    
    if ([paramMediaType length] == 0) {
        return NO;
    }
    
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        
        if ([mediaType isEqualToString:paramMediaType]) {
            result = YES;
            *stop = YES;
        }
    }];
    return result;
}

@end
