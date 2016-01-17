//
//  WSMineViewController.m
//  WalkShopper
//
//  Created by Ding Yi on 15/9/23.
//  Copyright (c) 2015年 Ding Yi. All rights reserved.
//

#import "WSMineViewController.h"
#import "WSMineHeaderView.h"
#import "WSUserInfoViewController.h"

@interface WSMineViewController () <UITableViewDataSource, UITableViewDelegate, WSMineHeaderViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet WSMineHeaderView *tableHeaderView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation WSMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的";
    
    self.tableHeaderView.headerViewDelegate = self;
    self.tableView.tableFooterView = [UIView new];
    self.dataSource = [NSMutableArray arrayWithObjects:@[@"我的订单"], @[@"设置", @"关于"], nil];
}


#pragma mark UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.section][indexPath.row];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - WSMineHeaderViewDelegate

- (void)showUserInfoViewController
{
    UIViewController *vc = [UIViewController ws_initViewControllerWithStoryBoard:@"Mine" withIdentifier:NSStringFromClass([WSUserInfoViewController class])];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
