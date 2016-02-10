//
//  WSSellerProductInfoViewController.m
//  WalkShopper
//
//  Created by 丁 一 on 16/1/24.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import "WSSellerProductInfoViewController.h"
#import "WSProductLabelSelectorViewController.h"
#import "WSSellerProductInfoLabelCell.h"
#import "WSSellerProductInfoTitleCell.h"
#import "WSSellerProductInfoCommissionCell.h"
#import "WSSellerProductInfoDescriptionCell.h"
#import "WSSellerProductInfoNextStepCell.h"
#import "WSSellerProductImageViewController.h"
#import "WSSellerPublishInfo.h"

@interface WSSellerProductInfoViewController () <UITableViewDataSource, UITableViewDelegate, WSProductLabelSelectorViewControllerDelegate, WSSellerProductInfoNextStepDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *identifierArray;
@property (strong, nonatomic) NSArray *labelArray;

@end

@implementation WSSellerProductInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.identifierArray = @[@"Product Title Cell", @"Product Label Cell", @"Commission Cell", @"Product Description Cell", @"Next Step Cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.enableBackGroundTapToResignFirstResponder = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.identifierArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [WSSellerProductInfoTitleCell cellHeight];
    } else if (indexPath.row == 1) {
        return [WSSellerProductInfoLabelCell cellHeight];
    } else if (indexPath.row == 2) {
        return [WSSellerProductInfoCommissionCell cellHeight];
    } else if (indexPath.row == 3) {
        return [WSSellerProductInfoDescriptionCell cellHeight];
    } else if (indexPath.row == 4) {
        return [WSSellerProductInfoNextStepCell cellHeight];
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.identifierArray[indexPath.row] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 1) {
        WSSellerProductInfoLabelCell *localCell = (WSSellerProductInfoLabelCell *)cell;
        [localCell configureProductInfoLabelCell:self.labelArray];
    }
    if (indexPath.row == self.identifierArray.count - 1) {
        cell.sepline.hidden = YES;
        WSSellerProductInfoNextStepCell *localCell = (WSSellerProductInfoNextStepCell *)cell;
        localCell.delegate = self;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        UIViewController *vc = [UIViewController ws_initViewControllerWithStoryBoard:@"Home" withIdentifier:NSStringFromClass([WSProductLabelSelectorViewController class])];
        ((WSProductLabelSelectorViewController *)vc).delegate = self;
        [((WSProductLabelSelectorViewController *)vc) initDataSource:self.labelArray];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - TableViewCell Helper

- (NSString *)getProductTitle
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    WSSellerProductInfoTitleCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    return cell.textView.text;
}

- (NSArray *)getProductLabels
{
    return [self.labelArray copy];
}

- (NSString *)getProductCommission
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    WSSellerProductInfoCommissionCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    return cell.textField.text;
}

- (NSString *)getProductDesc
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    WSSellerProductInfoDescriptionCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    return cell.textView.text;
}

#pragma mark - WSProductLabelSelectorViewControllerDelegate

- (void)showProductLabels:(NSArray *)labels
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    self.labelArray = [NSArray arrayWithArray:labels];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - WSSellerProductInfoNextStepDelegate

- (void)showNextViewController
{
    WSSellerProductImageViewController *vc = (WSSellerProductImageViewController *)[UIViewController ws_initViewControllerWithStoryBoard:@"Home" withIdentifier:NSStringFromClass([WSSellerProductImageViewController class])];
    WSSellerPublishInfo *publishInfo = [WSSellerPublishInfo new];
    publishInfo.publishTitle = [self getProductTitle];
    publishInfo.labels = [self getProductLabels];
    publishInfo.commission = [self getProductCommission];
    publishInfo.publishDesc = [self getProductDesc];
    vc.publishInfo = publishInfo;
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
