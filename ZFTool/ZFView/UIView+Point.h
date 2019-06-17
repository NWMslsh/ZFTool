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
+ (UIButton *(^)(void))zf_init;
/**
 title font
 */
- (UIButton *(^)(UIFont *font))zf_Font;

/**
 title color
 */
- (UIButton *(^)(UIColor *color))zf_textColor;
- (UIButton *(^)(UIColor *color,UIControlState state))zf_textColorByState;


// 设置文字
- (UIButton *(^)(NSString *title))zf_text;
- (UIButton *(^)(NSString *title,UIControlState state))zf_textByState;

/**
 bgColor
 */
- (UIButton *(^)(UIColor *color))zf_bgColor;
/**
 image
 */
- (UIButton *(^)(UIImage *img))zf_img;
- (UIButton *(^)(UIImage *img,UIControlState state))zf_imgByState;
/**
 bg image
 */
- (UIButton *(^)(UIImage *img))zf_bgImg;
- (UIButton *(^)(UIImage *img,UIControlState state))zf_bgImgByState;
@end
@interface UILabel (Point)

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
