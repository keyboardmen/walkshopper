//
//  WSMineHeaderView.m
//  WalkShopper
//
//  Created by 丁 一 on 16/1/17.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import "WSMineHeaderView.h"
#import "UIImage+Additions.h"

@interface WSMineHeaderView ()



@end

@implementation WSMineHeaderView

- (void)awakeFromNib
{
    self.imageView.userInteractionEnabled = YES;
    self.nameLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapImageViewGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
    [self.imageView addGestureRecognizer:tapImageViewGR];
    UITapGestureRecognizer *tapLabelGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
    [self.nameLabel addGestureRecognizer:tapLabelGR];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLoginStatus:) name:WSUserSessionLoginStatusChangeNotification object:nil];
    [self handleLoginStatus:nil];
}

- (void)handleTapGestureRecognizer:(UITapGestureRecognizer *)tapGestureRecognizer
{
    if ([WSUserSession sharedSession].hasLogin) {
        if ([self.headerViewDelegate respondsToSelector:@selector(showUserInfoViewController)]) {
            [self.headerViewDelegate showUserInfoViewController];
        }
    } else {
        [WSLoginAction loginWithSuccessBlock:^{
            if ([self.headerViewDelegate respondsToSelector:@selector(showUserInfoViewController)]) {
                [self.headerViewDelegate showUserInfoViewController];
            }
        } andFailureBlock:^{
            
        }];
    }
}

- (void)handleLoginStatus:(NSNotification *)notification
{
    UIImage *image = [UIImage imageNamed:@"defaultAvatar"];
    image = [image resizedRoundImageWithRect:self.imageView.frame borderWidth:2.0];
    if ([WSUserSession sharedSession].hasLogin) {
        NSString *username = [[WSUserSession sharedSession] readUsername];
        self.nameLabel.text = username;
        self.imageView.image = image;
    } else {
        self.nameLabel.text = @"请登录";
        self.imageView.image = image;
    }
}

@end
