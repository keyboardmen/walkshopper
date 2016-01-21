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

@interface WSUserInfoViewController () <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, WSImageCropperViewControllerDelegate>

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
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ( indexPath.section == 0 && indexPath.row == 1 ) {
        [WSImagePickerUtil showSystemImagePickerActionSheetWithController:self];
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
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)imageCropperDidCancel:(WSImageCropperViewController *)cropperViewController
{
    [cropperViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
