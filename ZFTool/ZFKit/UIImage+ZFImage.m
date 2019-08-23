//
//  UIImage+ZFImage.m
//  ZFTool
//
//  Created by fengz on 2018/7/25.
//  Copyright © 2018年 FengZ. All rights reserved.
//

#import "UIImage+ZFImage.h"

@implementation UIImage (ZFImage)
/**
 颜色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color andRect:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
/**
 获取启动图
 
 @return 启动图
 */
+ (UIImage *)getLaunchImg{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    NSString *viewO = @"Portrait";
    NSString *launchImg = @"";
    NSArray *imgDicS = [[[NSBundle mainBundle]infoDictionary]valueForKey:@"UILaunchImages"];
    for (NSDictionary *dic in imgDicS) {
        CGSize imgSize = CGSizeFromString(dic[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(screenSize, imgSize) && [viewO isEqualToString:dic[@"UILaunchImageOrientation"]]) {
            launchImg = dic[@"UILaunchImageName"];
        }
        
    }
    
    
    return  [UIImage imageNamed:launchImg];
}
/**
 *  缩放图片，会按照给定的最大宽度，等比缩放
 *
 *  @param maxWidth 缩放后的最大宽度
 *
 *  @return 返回缩放后的图片
 */
- (UIImage *)imageWithscaleMaxWidth:(CGFloat)maxWidth
{
    CGFloat width = self.size.width;
    CGFloat scale = [UIScreen mainScreen].scale;
    if (width > maxWidth)
    {
        
        CGFloat height = self.size.height;
        CGFloat maxHeight = maxWidth * height / width;
        
        CGSize size = CGSizeMake(maxWidth, maxHeight);
        
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale);
        [self drawInRect:CGRectMake(0, 0, maxWidth, maxHeight)];
        UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return resultImage;
    }
    
    return self;
}
/**
 重设图片size
 */
-(UIImage*)imagescaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)imageWihtSize:(CGSize)size radius:(CGFloat)radius backColor:(UIColor *)backColor completion:(void(^)(UIImage *image))completion{
    // 异步绘制裁切
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 利用绘图建立上下文
        UIGraphicsBeginImageContextWithOptions(size, true, 0);
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        // 填充颜色
        [backColor setFill];
        
        UIRectFill(rect);
        // 贝塞尔裁切
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
        [path addClip];
        [self drawInRect:rect];
        // 获取结果
        UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
        // 关闭上下文
        UIGraphicsEndImageContext();
        // 主队列回调
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(resultImage);
        });
    });
}
/**
 生成二维码图片
 */
+ (UIImage *)GenerateQrCode:(NSString *)codeResult andSize:(CGFloat)imageWidth{
    
    CIFilter * filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    NSData * urlData = [codeResult dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:urlData forKeyPath:@"inputMessage"];
    CIImage * outputImage = [filter outputImage];
    
    CGRect extent = CGRectIntegral(outputImage.extent);
    CGFloat scale = MIN(imageWidth/CGRectGetWidth(extent), imageWidth/CGRectGetHeight(extent));
    
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:outputImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
@end
