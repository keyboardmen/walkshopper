//
//  WSHomeProductCell.m
//  WalkShopper
//
//  Created by 丁 一 on 15/12/20.
//  Copyright © 2015年 Ding Yi. All rights reserved.
//

#import "WSHomeProductCell.h"

@interface WSHomeProductCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *creditLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *productInfoView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIView *imageSetsView;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end

@implementation WSHomeProductCell

+ (CGFloat)cellHeight
{
    return 170.0f;
}

- (void)awakeFromNib {
    self.avatarImageView.clipsToBounds = YES;
    self.avatarImageView.layer.cornerRadius = 23.0f;
    self.avatarImageView.layer.borderColor = [UIColor redColor].CGColor;
    self.avatarImageView.layer.borderWidth = 2.0f;
}

- (void)configCell
{
    CGFloat screenWidth = [UIDevice screenWidth];
    CGFloat margin = 13.0 + 13.0;
    CGFloat imageWidth = (screenWidth - margin)/3.0;
    
}

@end
