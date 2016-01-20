//
//  WSImageCropperViewController.h
//  WalkShopper
//
//  Created by 丁 一 on 16/1/20.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WSImageCropperViewControllerDelegate;

@interface WSImageCropperViewController : UIViewController

@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, weak) id<WSImageCropperViewControllerDelegate> delegate;
@property (nonatomic, assign) CGRect cropFrame;

- (instancetype)initWithImage:(UIImage *)originalImage cropFrame:(CGRect)cropFrame limitScaleRatio:(NSInteger)limitRatio;

@end


@protocol WSImageCropperViewControllerDelegate <NSObject>

- (void)imageCropper:(WSImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage;
- (void)imageCropperDidCancel:(WSImageCropperViewController *)cropperViewController;

@end