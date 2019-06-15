//
//  UIFont+ZFFont.h
//  ZFTool
//
//  Created by fengz on 2017/12/18.
//  Copyright © 2017年 FengZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (ZFFont)


/**
 字体大小
 */
+ (UIFont *)Size:(CGFloat)size;


/**
 半粗字体
 */
+ (UIFont *)HBSize:(CGFloat)size;

/**
 粗字体
 */
+ (UIFont *)BSize:(CGFloat)size;



@end
