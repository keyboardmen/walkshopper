//
//  WSUserInfoCell.m
//  WalkShopper
//
//  Created by 丁 一 on 16/1/18.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import "WSUserInfoCell.h"

@implementation WSUserInfoCell

- (void)awakeFromNib {
    // Initialization code
}

@end

@implementation WSUserInfoUsernameCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)configureCell
{
    
}

@end

@implementation WSUserInfoHeadImageCell

- (void)awakeFromNib {
    // Initialization code
}

@end

@implementation WSUserInfoNickNameCell

- (void)awakeFromNib {
    // Initialization code
}

@end

@implementation WSUserInfoGenderCell

- (void)awakeFromNib {
    // Initialization code
}

@end

@implementation WSUserInfoCompanyNameCell

- (void)awakeFromNib {
    // Initialization code
}

@end

@implementation WSUserInfoCompanyVerificationCell

- (void)awakeFromNib {
    // Initialization code
}

@end

@implementation WSUserInfoLogoutCell

- (void)awakeFromNib
{
    [self.logoutBtn addTarget:self action:@selector(logoutBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)logoutBtnTapped
{
    if ([self.delegate respondsToSelector:@selector(userLogoutAction)]) {
        [self.delegate userLogoutAction];
    }
}

@end

