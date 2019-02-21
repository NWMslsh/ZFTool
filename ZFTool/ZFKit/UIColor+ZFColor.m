//
//  UIColor+ZFColor.m
//  ZFTool
//
//  Created by fengz on 2017/12/15.
//  Copyright © 2017年 FengZ. All rights reserved.
//

#import "UIColor+ZFColor.h"
#import "Define-header.h"


@implementation UIColor (ZFColor)
/**
 导航栏
 
 @return color
 */
+(UIColor *)navi_color{
    return k_rgb_color(100, 191, 138);
}
/**
 普通色
 
 @return color
 */
+(UIColor *)default_BG{
    return k_rgb_color(246, 246, 246);
}
/**
 普通字体颜色
 */
+ (UIColor *)text_color{
    return k_rgb_color(51, 51, 51);
}
/**
 灰色字体
 */
+(UIColor *)dark_color{
    return k_rgb_color(102, 102, 102);
}

/**
 淡灰色
 */
+ (UIColor *)gray_color
{
    return k_rgb_color(153, 153, 153);
}

/**
 线条色
 
 @return color
 */
+(UIColor *)default_line{
    return k_rgb_color(230, 230, 230);
}

/**
 遮罩色
 */
+ (UIColor *)mask_color{
    return k_rgba_color(0, 0, 0, 0.8);
}

/**
 白色
 */
+ (UIColor *)white_color{
    return k_rgb_color(255, 255, 255);
}
@end
