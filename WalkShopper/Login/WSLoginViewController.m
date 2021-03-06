//
//  WSLoginViewController.m
//  WalkShopper
//
//  Created by Ding Yi on 15/9/23.
//  Copyright (c) 2015年 Ding Yi. All rights reserved.
//

#import "WSLoginViewController.h"
#import "NSString+Crypt.h"
#import "WSAppGeneralConfiguration.h"
#import "WSNetworkingResponseObject.h"

@interface WSLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetPassword;

@end

@implementation WSLoginViewController

+ (instancetype)initLoginViewController
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    WSLoginViewController *loginVC = [storyBoard instantiateViewControllerWithIdentifier:@"WSLoginViewController"];
    
    return loginVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [self.loginBtn addTarget:self action:@selector(loginBtnTapped) forControlEvents:UIControlEventTouchUpInside];
}

- (void)backBtnTapped
{
    if ([self.loginDelegate respondsToSelector:@selector(loginController:completeWithResult:)]) {
        [self.loginDelegate loginController:self completeWithResult:NO];
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)loginBtnTapped
{
    if ([self isInputValid] == NO) {
        return;
    }
    
    NSString *deviceToken = [[WSAppGeneralConfiguration sharedInstance] deviceToken];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:@{@"username":self.usernameTextField.text, @"passwd":[self.passwordTextField.text ws_md5String], @"deviceToken":deviceToken}];
    
    __weak typeof(self) weakSelf = self;
    [self startMaskActivity:@"正在加载中..."];
    [[WSUserSession sharedSession] loginWithParamters:param completionBlock:^(BOOL success, NSError *error) {
        [weakSelf stopMaskActivity];
        if (success) {
            if ([weakSelf.loginDelegate respondsToSelector:@selector(loginController:completeWithResult:)]) {
                [weakSelf.loginDelegate loginController:weakSelf completeWithResult:YES];
            }
        } else {
            [weakSelf showToast:error.localizedDescription];
        }
    }];
}

- (BOOL)isInputValid
{
    if (self.usernameTextField.text.length == 0) {
        [self showToast:@"请输入用户名" offset:-80];
        return NO;
    }
    if (self.passwordTextField.text.length == 0) {
        [self showToast:@"请输入密码" offset:-80];
        return NO;
    }
    return YES;
}

@end
