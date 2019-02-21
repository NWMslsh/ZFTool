//
//  UIColor+ZFColor.h
//  ZFTool
//
//  Created by fengz on 2017/12/15.
//  Copyright © 2017年 FengZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZFColor)

/**
 导航栏颜色
 
 @return color
 */
+(UIColor *)navi_color;
/**
 普通背景色
 
 @return color
 */
+(UIColor *)default_BG;

/**
 普通字体颜色
 */
+ (UIColor *)text_color;
/**
 灰色
 */
+ (UIColor *)dark_color;

/**
 淡灰色
 */
+ (UIColor *)gray_color;

/**
 线条色
 */
+(UIColor *)default_line;

/**
 遮罩色
 */
+ (UIColor *)mask_color;
/**
 白色
 */
+ (UIColor *)white_color;
@end
