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
    NSString *url = [[WSCommonWebUrls sharedInstance] userInfoUrl];
    //NSString *username = [WSUserSession sharedSession].loginUserName;
    NSString *loginToken = [WSUserSession sharedSession].loginToken;
    NSArray *tmp = @[@"f", @"m"];
    NSDictionary *param = @{@"loginToken":loginToken, @"gender":tmp[index]};
    
    WS(weakSelf)
    [self startActivity:@"正在保存..."];
    [[WSNetworkingUtilities sharedInstance] POST:url parameters:param success:^(AFHTTPRequestOperation *operation, WSNetworkingResponseObject *responseObject) {
        [weakSelf stopActivity];
        if (responseObject.retCode == WSNetworkingResponseSuccess) {
            if ([weakSelf.delegate respondsToSelector:@selector(changeGenderSuccessfully:)]) {
                [weakSelf.delegate changeGenderSuccessfully:tmp[index]];
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } else {
            [weakSelf showToast:responseObject.retDesc];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weakSelf stopActivity];
        [weakSelf showToast:error.localizedDescription];
    }];
}

@end
