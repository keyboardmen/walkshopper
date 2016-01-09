//
//  WSSetPasswordViewController.m
//  WalkShopper
//
//  Created by 丁 一 on 16/1/7.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import "WSSetPasswordViewController.h"
#import "NSString+Crypt.h"

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
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:@{@"username":self.username, @"passwd":[self.passwdTextField.text ws_md5String]}];
    
    NSString *url = [[WSCommonWebUrls sharedInstance] registerUrl];
    [[WSNetworkingUtilities sharedInstance] POST:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    [self.navigationController popToRootViewControllerAnimated:YES];
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
