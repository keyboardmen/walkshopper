//
//  WSSelectCountryViewController.h
//  WalkShopper
//
//  Created by 丁 一 on 15/12/22.
//  Copyright © 2015年 Ding Yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WSSelectCountryDelegate;

@interface WSSelectCountryViewController : UIViewController

@property (weak, nonatomic) id<WSSelectCountryDelegate>delegate;

@end


@protocol WSSelectCountryDelegate <NSObject>

- (void)updateCountryName:(NSString *)countryName;

@end