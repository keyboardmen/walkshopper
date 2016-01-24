//
//  WSChangeNickNameViewController.m
//  WalkShopper
//
//  Created by 丁 一 on 16/1/22.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import "WSChangeNickNameViewController.h"

@interface WSChangeNickNameViewController ()

@property (strong, nonatomic) UITextField *nameTextField;

@end

@implementation WSChangeNickNameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"修改昵称";
    [self initNavigationBar];
    [self initTextField];
}

- (void)initNavigationBar
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveName) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)initTextField
{
    self.nameTextField = [[UITextField alloc] init];
    [self.view addSubview:self.nameTextField];
    self.nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.nameTextField.placeholder = @"请输入你的昵称";
    self.nameTextField.font = [UIFont systemFontOfSize:14];
    
    WS(weakSelf)
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).with.offset(20);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(20);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-20);
        make.height.mas_equalTo(40);
    }];
}

- (void)saveName
{
    NSString *url = [[WSCommonWebUrls sharedInstance] userInfoUrl];
    //NSString *username = [WSUserSession sharedSession].loginUserName;
    NSString *loginToken = [WSUserSession sharedSession].loginToken;
    NSDictionary *param = @{@"loginToken":loginToken, @"nickname":self.nameTextField.text};
    
    WS(weakSelf)
    [self startActivity:@"正在保存..."];
    [[WSNetworkingUtilities sharedInstance] POST:url parameters:param success:^(AFHTTPRequestOperation *operation, WSNetworkingResponseObject *responseObject) {
        [weakSelf stopActivity];
        if (responseObject.retCode == WSNetworkingResponseSuccess) {
            if ([weakSelf.delegate respondsToSelector:@selector(changeNickNameSuccessfully:)]) {
                [weakSelf.delegate changeNickNameSuccessfully:weakSelf.nameTextField.text];
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } else {
            [weakSelf showToast:responseObject.retDesc];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weakSelf stopActivity];
        [RKDropdownAlert title:@"错误" message:error.localizedDescription];
    }];
}

@end
