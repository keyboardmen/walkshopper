//
//  WSMineHeaderView.h
//  WalkShopper
//
//  Created by 丁 一 on 16/1/17.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WSMineHeaderViewDelegate;

@interface WSMineHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) id<WSMineHeaderViewDelegate> headerViewDelegate;

@end


@protocol WSMineHeaderViewDelegate <NSObject>

- (void)showUserInfoViewController;

@end