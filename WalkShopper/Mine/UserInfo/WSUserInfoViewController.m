//
//  WSUserInfoViewController.m
//  WalkShopper
//
//  Created by 丁 一 on 16/1/17.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import "WSUserInfoViewController.h"
#import "WSUserInfoCell.h"
#import "WSImagePickerUtil.h"
#import "UIImage+Additions.h"
#import "WSImageCropperViewController.h"
#import "WSChangeNickNameViewController.h"
#import "WSChangeGenderViewController.h"

NSString * const WSUserChangeNickNameNotification = @"WSUserChangeNickNameNotification";
NSString * const WSUserChangeHeadImageNotification = @"WSUserChangeHeadImageNotification";
NSString * const WSUserChangeGenderNotification = @"WSUserChangeGenderNotification";

@interface WSUserInfoViewController () <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, WSImageCropperViewControllerDelegate, WSChangeNickNameDelegate, WSChangeGenderDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *identifierArray;

@end

@implementation WSUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.identifierArray = @[@[@"Username Cell", @"Head Image Cell", @"Nickname Cell", @"Gender Cell"], @[@"Company Cell", @"Company Verification Cell"]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.identifierArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.identifierArray[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:self.identifierArray[indexPath.section][indexPath.row] forIndexPath:indexPath];
    
    if (!(indexPath.section == 0 && indexPath.row == 0)) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ( indexPath.section == 0 && indexPath.row == 1 ) {
        [WSImagePickerUtil showSystemImagePickerActionSheetWithController:self];
    } else if (indexPath.section == 0 && indexPath.row == 2) {
        WSChangeNickNameViewController *vc = [WSChangeNickNameViewController new];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.section == 0 && indexPath.row == 3) {
        WSChangeGenderViewController *vc = [WSChangeGenderViewController new];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    portraitImg = [UIImage imageByScalingToMaxSize:portraitImg];
    WSImageCropperViewController *imgEditor = [[WSImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
    imgEditor.delegate = (id<WSImageCropperViewControllerDelegate>)self;
    [picker pushViewController:imgEditor animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - WSImageCropperViewController

- (void)imageCropper:(WSImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage
{
    WS(weakSelf)
    NSInteger MaxAvatarUploadSize = 1020;
    CGFloat MaxAvatarUploadQuality = 0.8;
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        
        NSString *username = [WSUserSession sharedSession].loginUserName;
        NSString *loginToken = [WSUserSession sharedSession].loginToken;
        NSString *url = [[WSCommonWebUrls sharedInstance] userAvatarImageUrl];
        
        NSDictionary *param = @{@"username":username, @"loginToken":loginToken};
        [weakSelf startActivity:@"正在上传头像..."];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            UIImage *newImage = [UIImage compressImage:editedImage constraintSize:MaxAvatarUploadSize];
            NSData *imageData = UIImageJPEGRepresentation(newImage, MaxAvatarUploadQuality);
            NSString *name = @"avatarImageFile";
            if (imageData) {
                [formData appendPartWithFileData:imageData name:name fileName:@"" mimeType:@"image/jpeg"];
            }
        } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            [weakSelf stopActivity];
            WSNetworkingResponseObject *response = [WSNetworkingResponseObject initWithResponseObject:responseObject];
            if (response.retCode == WSNetworkingResponseSuccess) {
                
            } else {
            
            }
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            [weakSelf stopActivity];
        }];
    }];
}

- (void)imageCropperDidCancel:(WSImageCropperViewController *)cropperViewController
{
    [cropperViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - WSChangeNickNameDelegate

- (void)changeNickNameSuccessfully:(NSString *)nickName
{
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:WSUserChangeNickNameNotification object:nil];
}

#pragma mark - WSChangeGenderDelegate

- (void)changeGenderSuccessfully:(NSString *)gender
{
    
}

@end
