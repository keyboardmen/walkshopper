//
//  WSChangeGenderViewController.h
//  WalkShopper
//
//  Created by 丁 一 on 16/1/22.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WSChangeGenderDelegate;

@interface WSChangeGenderViewController : UIViewController

@property (weak, nonatomic) id<WSChangeGenderDelegate>delegate;

@end

@protocol WSChangeGenderDelegate <NSObject>

- (void)changeGenderSuccessfully:(NSString *)gender;

@end