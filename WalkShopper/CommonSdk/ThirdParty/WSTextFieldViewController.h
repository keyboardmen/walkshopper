//
//  WSTextFieldViewController.h
//  WalkShopper
//
//  Created by 丁 一 on 16/1/30.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WSTextFieldViewControllerDelegate;

@interface WSTextFieldViewController : UIViewController

@property (strong, nonatomic) NSString *placeHolder;

@property (weak, nonatomic) id<WSTextFieldViewControllerDelegate>delegate;

@end


@protocol WSTextFieldViewControllerDelegate <NSObject>

- (void)ws_textField:(UITextField *)textField didSaveText:(NSString *)text;

@end