//
//  UIImage+ZFImage.h
//  ZFTool
//
//  Created by fengz on 2018/7/25.
//  Copyright © 2018年 FengZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZFImage)

/**
 纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color andRect:(CGSize)size;
/**
 获取启动图
 
 @return 启动图
 */

+ (UIImage *)getLaunchImg;
/**
 *  缩放图片，会按照给定的最大宽度，等比缩放
 *
 *  @param maxWidth 缩放后的最大宽度
 *
 *  @return 返回缩放后的图片
 */
- (UIImage *)imageWithscaleMaxWidth:(CGFloat)maxWidth;
/**
 重设图片size
 */
- (UIImage*)imagescaledToSize:(CGSize)newSize;

- (void)imageWihtSize:(CGSize)size radius:(CGFloat)radius backColor:(UIColor *)backColor completion:(void(^)(UIImage *image))completion;
/**
 生成二维码图片
 */
+ (UIImage *)GenerateQrCode:(NSString *)codeResult andSize:(CGFloat)imageWidth;
@end
