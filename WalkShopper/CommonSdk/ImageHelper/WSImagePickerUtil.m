//
//  WSImagePickerUtil.m
//  WalkShopper
//
//  Created by 丁 一 on 16/1/19.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import "WSImagePickerUtil.h"
#import "LGAlertView.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

@implementation WSImagePickerUtil

+ (void)showSystemImagePickerActionSheetWithController:(UIViewController *)viewController
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [actionSheet dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [WSImagePickerUtil performCameraWithViewController:viewController];
    }];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"选择本地照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [WSImagePickerUtil performImagePickerWithViewController:viewController];
    }];
    
    [actionSheet addAction:cancelAction];
    [actionSheet addAction:cameraAction];
    [actionSheet addAction:albumAction];
    
    [viewController presentViewController:actionSheet animated:YES completion:nil];
}

+ (void)performCameraWithViewController:(UIViewController *)viewController
{
    if (![WSImagePickerUtil isCameraAvailable]) {
        LGAlertView *alertView = [[LGAlertView alloc] initWithTitle:@"提醒" message:@"无法启动相机，请确认设备相机可以使用且未被占用" style:LGAlertViewStyleAlert buttonTitles:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil];
        [alertView showAnimated:YES completionHandler:nil];
    } else if (![WSImagePickerUtil doesCameraAccessable]) {
        [WSImagePickerUtil authorizationAlertWithMessage:@"请在iPhone的“设置-隐私-照片”选项中，允许访问您的相机。"];
    } else {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        controller.mediaTypes = mediaTypes;
        controller.delegate = (id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>)viewController;
        [viewController presentViewController:controller animated:YES completion:nil];
    }
}

+ (void)performImagePickerWithViewController:(UIViewController *)viewController
{
    if (![WSImagePickerUtil isPhotoLibraryAvailable]) {
        [WSImagePickerUtil authorizationAlertWithMessage:@"请在iPhone的“设置-隐私-照片”选项中，允许访问您的相册。"];
    } else {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        controller.mediaTypes = mediaTypes;
        controller.delegate = (id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>)viewController;
        [viewController presentViewController:controller animated:YES completion:nil];
    }
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

+ (BOOL)doesCameraAccessable
{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied) {
        return NO;
    }
    
    return YES;
}

+ (void)authorizationAlertWithMessage:(NSString *)message
{
    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        LGAlertView *alertView = [[LGAlertView alloc] initWithTitle:@"提醒" message:message style:LGAlertViewStyleAlert buttonTitles:@[@"设置"] cancelButtonTitle:@"取消" destructiveButtonTitle:nil actionHandler:^(LGAlertView *alertView, NSString *title, NSUInteger index) {
            [[UIApplication sharedApplication] openURL:url];
        } cancelHandler:nil destructiveHandler:nil];
        alertView.cancelOnTouch = NO;
        [alertView showAnimated:YES completionHandler:nil];
    } else {
        LGAlertView *alertView = [[LGAlertView alloc] initWithTitle:@"提醒" message:message style:LGAlertViewStyleAlert buttonTitles:nil cancelButtonTitle:@"确定" destructiveButtonTitle:nil actionHandler:nil cancelHandler:nil destructiveHandler:nil];
        alertView.cancelOnTouch = NO;
        [alertView showAnimated:YES completionHandler:nil];
    }
}

+ (BOOL)isPhotoLibraryAvailable
{
    BOOL allowAccess = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if (status == PHAuthorizationStatusDenied) {
        return NO;
    }else if (status == PHAuthorizationStatusRestricted){
        return NO;
    }else if (status == PHAuthorizationStatusNotDetermined){
        return allowAccess && YES;
    }else if (status == PHAuthorizationStatusAuthorized){
        return allowAccess && YES;
    }

    return allowAccess;
}

@end
