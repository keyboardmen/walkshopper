//
//  WSSellerProductInfoLabelCell.m
//  WalkShopper
//
//  Created by 丁 一 on 16/1/24.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import "WSSellerProductInfoLabelCell.h"
#import "WSProductLabelDisplayerCell.h"

static NSString * const kProductLabelDisplayerCellIdentifier = @"Product Label Displayer";

@interface WSSellerProductInfoLabelCell() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation WSSellerProductInfoLabelCell

+ (CGFloat)cellHeight
{
    return 200;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.userInteractionEnabled = NO;
}

- (void)configureProductInfoLabelCell:(NSArray *)data
{
    if (data.count > 0) {
        self.dataSource = [data copy];
    }
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{    
    return CGSizeMake(80, 40);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WSProductLabelDisplayerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kProductLabelDisplayerCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    cell.label.text = self.dataSource[indexPath.row];
    
    return cell;
}


@end
