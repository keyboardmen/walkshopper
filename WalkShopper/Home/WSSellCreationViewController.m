//
//  WSSellCreationViewController.m
//  WalkShopper
//
//  Created by 丁 一 on 16/1/8.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import "WSSellCreationViewController.h"
#import "WSSelectCountryViewController.h"

static NSString * const kSelectCountryIdentifier = @"Select Country";

@interface WSSellCreationViewController () <UITableViewDataSource, UITableViewDelegate, WSSelectCountryDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSString *countryName;

@end

@implementation WSSellCreationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];

}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:kSelectCountryIdentifier forIndexPath:indexPath];
        cell.textLabel.text = self.countryName ? : @"请选择国家";
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    } else {
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        UIViewController *vc = [UIViewController ws_initViewControllerWithStoryBoard:@"Home" withIdentifier:NSStringFromClass([WSSelectCountryViewController class])];
        WSSelectCountryViewController *selectCountryVC = (WSSelectCountryViewController *)vc;
        selectCountryVC.delegate = self;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - WSSelectCountryDelegate

- (void)updateCountryName:(NSString *)countryName
{
    self.countryName = countryName;
    [self.tableView reloadData];
}

@end
