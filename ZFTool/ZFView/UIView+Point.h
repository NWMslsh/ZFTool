//
//  UIView+Point.h
//  ZFTool
//
//  Created by hk on 2019/3/16.
//  Copyright © 2019年 fengz. All rights reserved.
//
//  copy from https://github.com/chenfengxiaoxixi/TextSpecLib

#import <UIKit/UIKit.h>

@interface UIView (Point)
/**
 初始化
 */
+ (UIView *(^)(void))zf_init;

/**
 frame
 */
- (UIView *(^)(CGFloat x,CGFloat y,CGFloat width,CGFloat height))zf_frame;

/**
 背景颜色
 */
- (UIView *(^)(UIColor *color))zf_bgColor;
@end


@interface UIButton (Point)
/**
 按钮初始化
 */
+ (UIButton *(^)(void))zf_init;

/**
 title font
 */
- (UIButton *(^)(UIFont *font))zf_Font;

/**
 title color
 */
- (UIButton *(^)(UIColor *color,UIControlState state))zf_textColor;

/**
 title
 */
- (UIButton *(^)(NSString *title,UIControlState state))zf_text;

/**
 bgColor
 */
- (UIButton *(^)(UIColor *color))zf_bgColor;
/**
 image
 */
- (UIButton *(^)(UIImage *img,UIControlState state))zf_img;
/**
 bg image
 */
- (UIButton *(^)(UIImage *img,UIControlState state))zf_bgImg;
@end
@interface UILabel (Point)

/**
 初始化
 */
+ (UILabel *(^)(void))zf_init;

/**
 font
 */
- (UILabel *(^)(UIFont *font))zf_Font;

/**
 title Color
 */
- (UILabel *(^)(UIColor *color))zf_textColor;

/**
 bg Color
 */
- (UILabel *(^)(UIColor *color))zf_bgColor;

@end
