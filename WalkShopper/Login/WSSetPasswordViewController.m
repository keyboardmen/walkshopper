//
//  WSSetPasswordViewController.m
//  WalkShopper
//
//  Created by 丁 一 on 16/1/7.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import "WSSetPasswordViewController.h"
#import "NSString+Crypt.h"
#import "WSNetworkingResponseObject.h"

@interface WSSetPasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *passwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswdTextField;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end

@implementation WSSetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.registerBtn addTarget:self action:@selector(handleRegisterAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)handleRegisterAction:(id)sender
{
    if ([self isPasswdValid] == NO) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:@{@"username":self.username, @"passwd":[self.passwdTextField.text ws_md5String]}];
    
    NSString *url = [[WSCommonWebUrls sharedInstance] registerUrl];
    
    [self startMaskActivity:@"正在加载中..."];
    [[WSNetworkingUtilities sharedInstance] POST:url parameters:param success:^(AFHTTPRequestOperation *operation, WSNetworkingResponseObject *responseObject) {
        [weakSelf stopMaskActivity];
        if (responseObject.retCode == WSNetworkingResponseSuccess) {
            [weakSelf showOkToast:@"注册成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            });
        } else {
            [weakSelf showToast:responseObject.retDesc];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weakSelf stopMaskActivity];
    }];
    
}

- (BOOL)isPasswdValid
{
    if (self.passwdTextField.text.length == 0 && self.confirmPasswdTextField.text.length == 0) {
        [self showToast:@"密码不能为空"];
        return NO;
    }
    if ([self.passwdTextField.text isEqualToString:self.confirmPasswdTextField.text] == NO) {
        [self showToast:@"两次密码不一致"];
        return NO;
    }
    
    return YES;
}

@end
