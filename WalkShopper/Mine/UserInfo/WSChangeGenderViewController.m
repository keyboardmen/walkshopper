//
//  WSChangeGenderViewController.m
//  WalkShopper
//
//  Created by 丁 一 on 16/1/22.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import "WSChangeGenderViewController.h"

@interface WSChangeGenderViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *genderTitles;

@end

@implementation WSChangeGenderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.genderTitles = @[@"女", @"男"];
    [self initTableView];
}

- (void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    WS(weakSelf)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.genderTitles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = self.genderTitles[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self saveGenderWithIndex:indexPath.row];
}

- (void)saveGenderWithIndex:(NSUInteger)index
{
    if ([self.delegate respondsToSelector:@selector(changeGenderSuccessfully:)]) {
        NSArray *tmp = @[@"f", @"m"];
        [self.delegate changeGenderSuccessfully:tmp[index]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
