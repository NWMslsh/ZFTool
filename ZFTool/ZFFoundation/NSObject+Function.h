//
//  NSObject+Function.h
//  ZFTool
//
//  Created by fengz on 2019/9/25.
//  Copyright © 2019 fengz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSObject (Function)
+ (instancetype(^)(void))zf_init;
@end

typedef void (^ViewCallBackBlock)(id data);
@interface UIView (Point)

@property (copy , nonatomic)ViewCallBackBlock clickBlock;


+ (UIView *(^)(void))zf_init;
/**
 frame
 */
- (UIView *(^)(CGFloat x,CGFloat y,CGFloat width,CGFloat height))zf_frame;

/**
 背景颜色
 */
- (UIView *(^)(UIColor *color))zf_bgColor;
/**
 设置圆角
 */
- (UIView *(^)(CGFloat radius))zf_radius;
/**
 添加到View上
 */
- (UIView *(^)(UIView *superV))zf_addToView;

/**
 添加点击方法
 */
- (UIView *(^)(ViewCallBackBlock clickblock))zf_addClick;

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


