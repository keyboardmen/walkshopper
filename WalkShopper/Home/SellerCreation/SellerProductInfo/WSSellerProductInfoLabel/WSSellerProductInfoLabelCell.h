//
//  WSSellerProductInfoLabelCell.h
//  WalkShopper
//
//  Created by 丁 一 on 16/1/24.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSSellerProductInfoLabelCell : WSTableViewCell

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

+ (CGFloat)cellHeight;
- (void)configureProductInfoLabelCell:(NSArray *)data;

@end
