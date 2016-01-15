//
//  LDPMPopoverMenu.h
//  PreciousMetals
//  Origin https://github.com/kolyvan/kxmenu/
//  Created by wangchao on 10/30/15.
//  Copyright © 2015 NetEase. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LDPMMenuDismissNotification @"LDPMMenuDismissNotification"

@interface LDPMPopoverMenuItem : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *highlightedColor;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (strong, nonatomic) UIFont *titleFont;
@property (weak, nonatomic) id target;
@property (assign, nonatomic) SEL action;
@property (assign, nonatomic) NSTextAlignment titleAlignment;

- (instancetype) initWithTitle:(NSString *)title
                        target:(id)target
                        action:(SEL)action;

- (instancetype) initWithTitle:(NSString *) title
                    titleColor:(UIColor *)titleColor
                     titleFont:(UIFont *)titleFont
                titleAlignment:(NSTextAlignment)titleAlignment
                         image:(UIImage *)image
                        target:(id)target
                        action:(SEL)action;

@end

@interface LDPMPopoverMenu : NSObject

- (instancetype)init;

- (instancetype)initWithTintColor:(UIColor *)tintColor
                        maskColor:(UIColor *)maskColor
             itemHorizontalMargin:(CGFloat)itemHorizontalMargin
               itemVerticalMargin:(CGFloat)itemVerticalMargin
               leftInsetOfSepline:(CGFloat)leftInsetOfSepline
                     seplineColor:(UIColor *)seplineColor
                        arrowSize:(CGFloat)arrowSize;

- (void) showMenuInView:(UIView *)inView
               fromView:(UIView *)fromView
              menuItems:(NSArray *)menuItems;

- (void) showMenuInView:(UIView *)view
               fromRect:(CGRect)rect
              menuItems:(NSArray *)menuItems;


- (void) dismissMenu;

@property (strong, nonatomic) UIColor *tintColor;
@property (assign, nonatomic) CGFloat leftInsetOfSepline;
@property (strong, nonatomic) UIColor *seplineColor;
@property (assign, nonatomic) CGFloat itemHorizontalMargin;
@property (assign, nonatomic) CGFloat itemVerticalMargin;
@property (assign, nonatomic) CGFloat arrowSize;
@property (strong, nonatomic) UIColor *maskColor;
@property (assign, nonatomic) CGFloat rightMargin;//距右边界的距离。默认5.f

@end
