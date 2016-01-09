//
//  WSLoginViewController.m
//  WalkShopper
//
//  Created by Ding Yi on 15/9/23.
//  Copyright (c) 2015年 Ding Yi. All rights reserved.
//

#import "WSLoginViewController.h"
#import "NSString+Crypt.h"

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
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)loginBtnTapped
{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:@{@"username":self.usernameTextField.text, @"passwd":[self.passwordTextField.text ws_md5String]}];
    
    NSString *url = [[WSCommonWebUrls sharedInstance] loginUrl];
    __weak typeof(self) weakSelf = self;
    [[WSNetworkingUtilities sharedInstance] POST:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [WSUserSession sharedSession].isLogin = YES;
        if ([weakSelf.loginDelegate respondsToSelector:@selector(loginController:completeWithResult:)]) {
            [weakSelf.loginDelegate loginController:weakSelf completeWithResult:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [WSUserSession sharedSession].isLogin = NO;
        if ([weakSelf.loginDelegate respondsToSelector:@selector(loginController:completeWithResult:)]) {
            [weakSelf.loginDelegate loginController:weakSelf completeWithResult:NO];
        }
    }];
}

@end
