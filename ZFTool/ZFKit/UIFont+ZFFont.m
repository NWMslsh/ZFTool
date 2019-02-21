//
//  UIFont+ZFFont.m
//  ZFTool
//
//  Created by fengz on 2017/12/18.
//  Copyright © 2017年 FengZ. All rights reserved.
//

#import "UIFont+ZFFont.h"
#import "Define-header.h"
//UIFontWeightUltraLight  - 超细字体
//
//UIFontWeightThin  - 纤细字体
//
//UIFontWeightLight  - 亮字体
//
//UIFontWeightRegular  - 常规字体
//
//UIFontWeightMedium  - 介于Regular和Semibold之间
//
//UIFontWeightSemibold  - 半粗字体
//
//UIFontWeightBold  - 加粗字体
//
//UIFontWeightHeavy  - 介于Bold和Black之间
//
//UIFontWeightBlack  - 最粗字体(理解)

//    PingFangSC-Regular
//    PingFangSC-Medium
//    PingFangSC-Semibold
//中文字体
static NSString *FontFamily_PingFangSC = @"PingFangSC";
//英文字体
static NSString *FontFamily_SFUIText = @".SFUIText";
//英文字体(size>19)
static NSString *FontFamily_SFUIDisplay = @".SFUIDisplay";
//普通
static NSString *FontWeight_Regular = @"Regular";
//半黑体
static NSString *FontWeight_Medium = @"Medium";
//半粗体
static NSString *FontWeight_Semibold = @"Semibold";

@implementation UIFont (ZFFont)

/**
 字体大小
 */
+ (UIFont *)Size:(CGFloat)size{
    
    return [self getFontBy:FontFamily_PingFangSC andWeight:FontWeight_Regular andSize:size];
}

/**
 半粗字体
 */
+ (UIFont *)HBSize:(CGFloat)size{
    
    return [self getFontBy:FontFamily_PingFangSC andWeight:FontWeight_Medium andSize:size];
}

/**
 粗字体
 */
+ (UIFont *)BSize:(CGFloat)size{
    
    return [self getFontBy:FontFamily_PingFangSC andWeight:FontWeight_Semibold andSize:size];
}

/**
 普通字en
 */
+ (UIFont *)SizeEn:(CGFloat)size{
    
    
    if (size > 19) {
        return [self getFontBy:FontFamily_SFUIDisplay andWeight:nil andSize:size];
    }
    
    
    return [self getFontBy:FontFamily_SFUIText andWeight:nil andSize:size];
    
}

/**
 半粗字体
 */
+ (UIFont *)HBSizeEn:(CGFloat)size{
    if (size > 19) {
        return [self getFontBy:FontFamily_SFUIDisplay andWeight:FontWeight_Medium andSize:size];
    }
    
    return [self getFontBy:FontFamily_SFUIText andWeight:FontWeight_Medium andSize:size];
}

/**
 粗字体
 */
+ (UIFont *)BSizeEn:(CGFloat)size{
    
    if (size > 19) {
        return [self getFontBy:FontFamily_SFUIDisplay andWeight:FontWeight_Semibold andSize:size];
    }
    
    
    return [self getFontBy:FontFamily_SFUIText andWeight:FontWeight_Semibold andSize:size];
}
//获取字体
+ (UIFont *)getFontBy:(NSString *)familyStr andWeight:(NSString *)weight andSize:(CGFloat)size{
    
    NSString *fontName = [NSString stringWithFormat:@"%@-%@",familyStr,weight];
    if (weight == nil) {
        fontName = familyStr;
    }
    return [UIFont fontWithName:fontName size:size];
    
    
}

@end
