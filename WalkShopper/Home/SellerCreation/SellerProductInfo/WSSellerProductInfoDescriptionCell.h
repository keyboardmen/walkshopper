//
//  WSSellerProductInfoDescriptionCell.h
//  WalkShopper
//
//  Created by 丁 一 on 16/1/24.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSSellerProductInfoDescriptionCell : WSTableViewCell

@property (weak, nonatomic) IBOutlet UITextView *textView;

+ (CGFloat)cellHeight;

@end
