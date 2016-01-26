//
//  WSUserInfoCell.h
//  WalkShopper
//
//  Created by 丁 一 on 16/1/18.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WSUserInfoCellDelegate;

@interface WSUserInfoCell : UITableViewCell

@property (weak, nonatomic) id<WSUserInfoCellDelegate>delegate;

@end

@protocol WSUserInfoCellDelegate <NSObject>

@optional

- (void)userLogoutAction;

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

@interface WSUserInfoLogoutCell : WSUserInfoCell

@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;

@end
