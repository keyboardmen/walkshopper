//
//  WSTextFieldViewController.m
//  WalkShopper
//
//  Created by 丁 一 on 16/1/30.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import "WSTextFieldViewController.h"

@interface WSTextFieldViewController ()

@property (strong, nonatomic) UITextField *textField;

@end

@implementation WSTextFieldViewController

- (void)initTextField
{
    WS(weakSelf)
    self.textField = [[UITextField alloc] init];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.placeholder = self.placeHolder ? :@"";
    [self.view addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).with.offset(20);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(20);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-20);
    }];
    
}

- (void)initNavigationBar
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveText:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.enableBackGroundTapToResignFirstResponder = YES;
    [self initNavigationBar];
    [self initTextField];
}

- (void)saveText:(UITextField *)textField
{
    NSString *tmp = [self.textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (tmp.length == 0) {
        LGAlertView *alertView = [LGAlertView alertViewWithTitle:@"文字不能为空" message:nil style:LGAlertViewStyleAlert buttonTitles:nil cancelButtonTitle:@"确定" destructiveButtonTitle:nil];
        [alertView showAnimated:YES completionHandler:nil];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(ws_textField:didSaveText:)]) {
        NSString *text = [self.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [self.delegate ws_textField:textField didSaveText:text];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
