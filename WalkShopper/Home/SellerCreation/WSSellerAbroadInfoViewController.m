//
//  WSSellerAbroadInfoViewController.m
//  WalkShopper
//
//  Created by 丁 一 on 16/1/24.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import "WSSellerAbroadInfoViewController.h"
#import "WSSelectCountryViewController.h"
#import <PDTSimpleCalendar/PDTSimpleCalendar.h>

static NSString * const kSelectCountryIdentifier = @"Select Country";
static NSString * const kSelectDateIdentifier = @"Select Date";

@interface WSSellerAbroadInfoViewController () <UITableViewDataSource, UITableViewDelegate, WSSelectCountryDelegate, PDTSimpleCalendarViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSString *countryName;
@property (strong, nonatomic) NSString *leaveDate;
@property (strong, nonatomic) NSString *backDate;
@property (strong, nonatomic) NSString *latestDeliveryDate;
@property (strong, nonatomic) NSIndexPath *curDatePickerIndexPath;
@end

@implementation WSSellerAbroadInfoViewController

- (void)viewDidLoad
{
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:kSelectCountryIdentifier forIndexPath:indexPath];
        cell.textLabel.text = self.countryName ? : @"请选择国家";
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    } else if (indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:kSelectDateIdentifier forIndexPath:indexPath];
        cell.textLabel.text = self.leaveDate ? : @"请选择出国时间";
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    } else if (indexPath.row == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:kSelectDateIdentifier forIndexPath:indexPath];
        cell.textLabel.text = self.backDate ? : @"请选择回国时间";
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    } else if (indexPath.row == 3) {
        cell = [tableView dequeueReusableCellWithIdentifier:kSelectDateIdentifier forIndexPath:indexPath];
        cell.textLabel.text = self.latestDeliveryDate ? : @"请选择最晚发货时间";
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
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
    } else {
        PDTSimpleCalendarViewController *vc = [self createCalendarViewControllerWithIndexPath:indexPath];
        //[self presentViewController:vc animated:YES completion:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - WSSelectCountryDelegate

- (void)updateCountryName:(NSString *)countryName
{
    self.countryName = countryName;
    [self.tableView reloadData];
}

#pragma mark - Date picker functions

- (PDTSimpleCalendarViewController *)createCalendarViewControllerWithIndexPath:(NSIndexPath *)indexPath
{
    PDTSimpleCalendarViewController *vc = [PDTSimpleCalendarViewController new];
    vc.delegate = self;
    self.curDatePickerIndexPath = indexPath;
    
    return vc;
}

#pragma mark - PDTSimpleCalendarViewDelegate

- (void)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller didSelectDate:(NSDate *)date
{
    if (self.curDatePickerIndexPath.row == 1) {
        self.leaveDate = [self stringFromDate:date];
    }
    if (self.curDatePickerIndexPath.row == 2) {
        self.backDate = [self stringFromDate:date];
    }
    if (self.curDatePickerIndexPath.row == 3) {
        self.latestDeliveryDate = [self stringFromDate:date];
    }
    [self.tableView reloadData];
    //[controller dismissViewControllerAnimated:YES completion:nil];
    [controller.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Help functions

- (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormat = [ [NSDateFormatter alloc] init];
    dateFormat.dateFormat = @"yyyy年MM月dd日";
    
    return [dateFormat stringFromDate:date];
}


@end
