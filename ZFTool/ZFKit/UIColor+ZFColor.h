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
+(UIColor * (^)(void))navi_color;

/**
 导航栏颜色
 
 @return color
 */
+(UIColor *)mainColor;
/**
 普通背景色
 
 @return color
 */
+(UIColor *(^)(void))default_BG;

/**
 普通字体颜色
 */
+ (UIColor *(^)(void))text_color;
/**
 灰色
 */
+ (UIColor *(^)(void))dark_color;

/**
 淡灰色
 */
+ (UIColor *(^)(void))gray_color;

/**
 线条色
 */
+(UIColor *(^)(void))default_line;

/**
 遮罩色
 */
+ (UIColor *(^)(void))mask_color;

@end
