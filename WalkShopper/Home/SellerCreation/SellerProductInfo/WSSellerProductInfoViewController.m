//
//  WSSellerProductInfoViewController.m
//  WalkShopper
//
//  Created by 丁 一 on 16/1/24.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import "WSSellerProductInfoViewController.h"
#import "WSProductLabelSelectorViewController.h"

@interface WSSellerProductInfoViewController () <UITableViewDataSource, UITableViewDelegate, WSProductLabelSelectorViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *identifierArray;

@end

@implementation WSSellerProductInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.identifierArray = @[@"Product Title Cell", @"Product Label Cell", @"Commission Cell", @"Product Description Cell", @"Next Step Cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.identifierArray[indexPath.row] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == self.identifierArray.count - 1) {
        cell.sepline.hidden = YES;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        UIViewController *vc = [UIViewController ws_initViewControllerWithStoryBoard:@"Home" withIdentifier:NSStringFromClass([WSProductLabelSelectorViewController class])];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - WSProductLabelSelectorViewControllerDelegate

- (void)showProductLabels:(NSArray *)labels
{
    
}

@end
