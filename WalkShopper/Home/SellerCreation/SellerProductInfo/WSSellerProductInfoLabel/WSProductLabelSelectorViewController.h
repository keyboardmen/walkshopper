//
//  WSProductLabelSelectorViewController.h
//  WalkShopper
//
//  Created by 丁 一 on 16/1/30.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WSProductLabelSelectorViewControllerDelegate;

@interface WSProductLabelSelectorViewController : UIViewController

@property (weak, nonatomic) id<WSProductLabelSelectorViewControllerDelegate>delegate;
- (void)initDataSource:(NSArray *)selectedLabels;

@end


@protocol WSProductLabelSelectorViewControllerDelegate <NSObject>

- (void)showProductLabels:(NSArray *)labels;

@end