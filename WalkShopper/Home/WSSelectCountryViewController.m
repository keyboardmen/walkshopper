//
//  WSSelectCountryViewController.m
//  WalkShopper
//
//  Created by 丁 一 on 15/12/22.
//  Copyright © 2015年 Ding Yi. All rights reserved.
//

#import "WSSelectCountryViewController.h"
#import "WSSelectCountryFlowLayout.h"
#import "WSSelectCountryCell.h"
#import "WSContinentCollectionReusableView.h"


static NSString * const kCountryCellIdentifier = @"Country Cell";
static NSString * const kContinentViewIdentifier = @"Continent View";

@interface WSSelectCountryViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSArray *continentSections;
@property (strong, nonatomic) NSMutableArray *countryRows;

@end

@implementation WSSelectCountryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WSSelectCountryFlowLayout *layout = [[WSSelectCountryFlowLayout alloc] init];
    [self.collectionView setCollectionViewLayout:layout animated:NO];
    
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.continentSections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.countryRows[section] count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    WSContinentCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kContinentViewIdentifier forIndexPath:indexPath];
    view.continentNameLabel.text = self.continentSections[indexPath.section];
    
    return view;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WSSelectCountryCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCountryCellIdentifier forIndexPath:indexPath];
    
    cell.countryName.text = self.countryRows[indexPath.section][indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(updateCountryName:)]) {
        [self.delegate updateCountryName:self.countryRows[indexPath.section][indexPath.row]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - setter & getter

- (NSArray *)continentSections
{
    if (_continentSections == nil) {
        _continentSections = @[@"亚洲", @"美洲", @"欧洲", @"大洋洲"];
    }
    
    return _continentSections;
}

- (NSMutableArray *)countryRows
{
    if (_countryRows == nil) {
        _countryRows = [NSMutableArray new];
        
        NSArray *asia = @[@"中国香港", @"中国台湾", @"日本", @"韩国", @"新加坡", @"马来西亚", @"泰国", @"印度尼西亚", @"马尔代夫", @"菲律宾"];
        NSArray *america = @[@"美国", @"加拿大", @"墨西哥", @"巴西", @"阿根廷", @"智力", @"秘鲁", @"乌拉圭", @"巴拉圭", @"牙买加"];
        NSArray *euro = @[@"比利时", @"保加利亚", @"捷克", @"丹麦", @"德国", @"西班牙", @"希腊", @"克罗地亚", @"爱尔兰", @"意大利", @"荷兰", @"挪威", @"葡萄牙", @"罗马尼亚", @"斯洛文尼亚", @"波兰", @"瑞士", @"瑞典", @"土耳其", @"英国"];
        NSArray *oceania = @[@"澳大利亚", @"新西兰"];
        
        [_countryRows addObject:asia];
        [_countryRows addObject:america];
        [_countryRows addObject:euro];
        [_countryRows addObject:oceania];
    }
    
    return _countryRows;
}
@end
