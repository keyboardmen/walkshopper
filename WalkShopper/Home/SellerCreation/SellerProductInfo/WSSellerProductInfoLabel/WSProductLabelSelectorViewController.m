//
//  WSProductLabelSelectorViewController.m
//  WalkShopper
//
//  Created by 丁 一 on 16/1/30.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import "WSProductLabelSelectorViewController.h"
#import "WSProductLabelSelectorCell.h"
#import "WSTextFieldViewController.h"

static NSString *kSupplementaryViewIdentifier = @"Supplementary View";
static NSString *kProductLabelItemIdentifier = @"Product Label Item";
static NSString *kEmptyItemIdentifier = @"Empty Item";
static NSString *kAddItemIdentifier = @"Add Item";

@interface WSProductLabelSelectorViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, WSTextFieldViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation WSProductLabelSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self initNavigationBar];
}

- (void)initDataSource:(NSArray *)selectedLabels
{
    self.dataSource = [NSMutableArray new];
    
    NSArray *fullLabels = @[@"电子产品",@"iPhone",@"MacBook",@"iPad",@"化妆品",@"名牌包包",@"手机",@"香奈儿",@"Gucci",@"Salvatore Ferragamo",@"香水",@"面膜",@"保养品",@"首饰"];
    //section分为选中和未选中
    for (int i = 0; i < 2; i++) {
        NSMutableArray *tmp = [NSMutableArray new];
        if (i == 0) {
            if (selectedLabels.count > 0) {
                tmp = [NSMutableArray arrayWithArray:selectedLabels];
            }
        } else {
            for (NSString *label in fullLabels) {
                BOOL flag = YES;
                for (NSString *selected in selectedLabels) {
                    if ([label isEqualToString:selected]) {
                        flag = NO;
                        break;
                    }
                }
                if (flag) {
                    [tmp addObject:label];
                }
            }
        }
        [self.dataSource addObject:tmp];
    }
}

- (void)initNavigationBar
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveLabels:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0 && [self.dataSource[section] count] == 0) {
        return 1;
    } else if (section == 1) {
        return [self.dataSource[section] count] + 1;
    }
    return [self.dataSource[section] count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(0, 20);
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
    if ([self.dataSource[0] count] == 0 && indexPath.section == 0) {
        return CGSizeMake(150, 40);
    }
    
    return CGSizeMake(80, 40);
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSupplementaryViewIdentifier forIndexPath:indexPath];
    
    return view;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    if (indexPath.section == 0 && [self.dataSource[indexPath.section] count] == 0) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kEmptyItemIdentifier forIndexPath:indexPath];
    } else if (indexPath.section == 1 && [self.dataSource[indexPath.section] count] == indexPath.row) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAddItemIdentifier forIndexPath:indexPath];
    }else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kProductLabelItemIdentifier forIndexPath:indexPath];
        WSProductLabelSelectorCell *localCell = (WSProductLabelSelectorCell *)cell;
        localCell.label.text = [NSString stringWithFormat:@"%@", self.dataSource[indexPath.section][indexPath.row]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataSource[0] count] == 0 && indexPath.section == 0) {
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
        return;
    }
    
    if (indexPath.section == 1 && indexPath.row == [self.dataSource[1] count]) {
        WSTextFieldViewController *vc = [WSTextFieldViewController new];
        vc.delegate = self;
        vc.placeHolder = @"请输入标签";
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    NSIndexPath *sourceIndexPath;
    NSIndexPath *destinationIndexPath;
    
    BOOL deleteFlag = ([self.dataSource[0] count] == 0 && indexPath.section == 1);
    BOOL addFlag = ([self.dataSource[0] count] == 1 && indexPath.section == 0);
    
    if (indexPath.section == 0) {
        NSMutableArray *tmp = self.dataSource[indexPath.section];
        id obj = self.dataSource[indexPath.section][indexPath.row];
        [self.dataSource[1] addObject:obj];
        [tmp removeObjectAtIndex:indexPath.row];
        
        sourceIndexPath = [NSIndexPath indexPathForItem:indexPath.row inSection:indexPath.section];
        destinationIndexPath = [NSIndexPath indexPathForItem:[self.dataSource[1] count] - 1 inSection:1];
    } else if (indexPath.section == 1) {
        NSMutableArray *tmp = self.dataSource[indexPath.section];
        id obj = self.dataSource[indexPath.section][indexPath.row];
        [self.dataSource[0] addObject:obj];
        [tmp removeObjectAtIndex:indexPath.row];
        
        sourceIndexPath = [NSIndexPath indexPathForItem:indexPath.row inSection:indexPath.section];
        destinationIndexPath = [NSIndexPath indexPathForItem:[self.dataSource[0] count] - 1 inSection:0];
    }
    
    if (deleteFlag) {
        [collectionView performBatchUpdates:^{
            [collectionView deleteItemsAtIndexPaths:@[destinationIndexPath]];
            [collectionView moveItemAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
        } completion:^(BOOL finished) {
            
        }];
    } else if (addFlag) {
        [collectionView performBatchUpdates:^{
            [collectionView moveItemAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
            [collectionView insertItemsAtIndexPaths:@[sourceIndexPath]];
        } completion:^(BOOL finished) {
            
        }];
    } else {
        [collectionView moveItemAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    }
}

#pragma mark - Handle actions

- (void)saveLabels:(id)sender
{
    NSArray *array = [self.dataSource firstObject];
    if (array.count == 0) {
        LGAlertView *alert = [LGAlertView alertViewWithTitle:@"请至少选择一个商品" message:nil style:LGAlertViewStyleAlert buttonTitles:nil cancelButtonTitle:@"确定" destructiveButtonTitle:nil];
        [alert showAnimated:YES completionHandler:nil];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(showProductLabels:)]) {
        [self.delegate showProductLabels:array];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - WSTextFieldViewControllerDelegate

- (void)ws_textField:(UITextField *)textField didSaveText:(NSString *)text
{
    NSMutableArray *array = self.dataSource[1];
    [array addObject:text];
    [self.collectionView reloadData];
}

@end
