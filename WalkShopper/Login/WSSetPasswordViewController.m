//
//  WSSetPasswordViewController.m
//  WalkShopper
//
//  Created by 丁 一 on 16/1/7.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import "WSSetPasswordViewController.h"

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
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (BOOL)isPasswdValid
{
    if (self.passwdTextField.text.length > 0 && self.confirmPasswdTextField.text.length > 0) {
        return YES;
    }
    
    return NO;
}

@end
