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
+(UIColor * (^)(void))navi_color{
    
    return ^(void){
        return ZF_rgb_color(28, 169, 161);
    };
    
}
/**
 普通色
 
 @return color
 */
+(UIColor *(^)(void))default_BG{
    return ^(void){
       return ZF_rgb_color(246, 246, 246);
    };
    
}
/**
 普通字体颜色
 */
+ (UIColor *(^)(void))text_color{
    return ^(void){
        return ZF_rgb_color(51, 51, 51);
    };
    
}
/**
 灰色字体
 */
+(UIColor *(^)(void))dark_color{
    return ^(void){
        return ZF_rgb_color(102, 102, 102);
    };
    
}

/**
 淡灰色
 */
+ (UIColor *(^)(void))gray_color
{
    return ^(void){
        return ZF_rgb_color(153, 153, 153);
    };
    
}

/**
 线条色
 
 @return color
 */
+(UIColor *(^)(void))default_line{
    return ^(void){
        return ZF_rgb_color(230, 230, 230);
    };
    
}

/**
 遮罩色
 */
+ (UIColor *(^)(void))mask_color{
    return ^(void){
        return ZF_rgba_color(0, 0, 0, 0.8);
    };
    
}


@end
