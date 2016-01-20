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

@interface WSUserInfoViewController () <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate>

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
        [WSImagePickerUtil showImagePickerActionSheetWithController:self];
    }
    
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
