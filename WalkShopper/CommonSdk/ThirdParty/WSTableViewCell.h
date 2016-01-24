//
//  WSTableViewCell.h
//  WalkShopper
//
//  Created by 丁 一 on 16/1/24.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSTableViewCell : UITableViewCell

@property (nonatomic) CGFloat leftInsets;
@property (nonatomic) BOOL firstCell;
@property (nonatomic) BOOL lastCell;
@property (nonatomic, assign) BOOL expanded;

@property (strong, nonatomic) UIView *sepline;
@property (strong, nonatomic) UIView *topSepline;

- (void)fillData:(id)item;

@end
