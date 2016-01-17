//
//  WSUserInfoCell.h
//  WalkShopper
//
//  Created by 丁 一 on 16/1/18.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSUserInfoCell : UITableViewCell

@end

@interface WSUserInfoUsernameCell : WSUserInfoCell
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@end

@interface WSUserInfoHeadImageCell : WSUserInfoCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@end

@interface WSUserInfoNickNameCell : WSUserInfoCell
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;

@end

@interface WSUserInfoGenderCell : WSUserInfoCell
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;

@end

@interface WSUserInfoCompanyNameCell : WSUserInfoCell
@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;

@end

@interface WSUserInfoCompanyVerificationCell : WSUserInfoCell

@property (weak, nonatomic) IBOutlet UILabel *companyVerificationLabel;

@end