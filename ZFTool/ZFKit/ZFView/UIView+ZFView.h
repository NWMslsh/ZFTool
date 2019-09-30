//
//  UIView+ZFView.h
//  ZFTool
//
//  Created by fengz on 2017/12/15.
//  Copyright © 2017年 FengZ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    ViewLineTypeNormal,             //中心点
    ViewLineLeftToRight,            //从左到右
    ViewLineRightToLeft,            //从右到左
    ViewLineTopToBottom,            //从上到下
    ViewLineBottomToTop,            //从下到上
    ViewLineCornerOfTLeftToBRight,  //左上角度到右下角
    ViewLineCornerOfBRightToTLeft,  //右下角到左上角
    ViewLineCornerOfBLeftToTRight,  //左下角到右上角
    ViewLineCornerOfTRightToBLeft,  //右上角到左下角
    
    
} ViewLineType;

@interface UIView (ZFView)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat rightX;
@property (nonatomic, assign) CGFloat bottomY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

/**
 设置数据
 */
- (void)binData:(id)data;

/**从Xib加载*/
+ (instancetype)LoadFormNib;

/**画线*/
- (CALayer *)drawlayerwithFram:(CGRect)rect withColor:(UIColor *)color;


/**
 画虚线
 */
- (UIImageView *)drawDashLineRect:(CGRect)rect color:(UIColor *)color;
/**
 获取label高度
 
 @param str str
 @param font font
 @return return str
 */
+ (CGFloat)getLableHeigth:(NSString *)str font:(UIFont *)font andWidth:(CGFloat)width;

/**
 获取label宽度
 
 @param str str
 @param font font
 @return return str
 */
+ (CGFloat)getLableWidth:(NSString *)str font:(UIFont *)font;
+ (void)p_changeMultiplierOfConstraint:(NSLayoutConstraint *)constraint multiplier:(CGFloat)multiplier;
- (void)drawPointLineRect:(CGRect)rect color:(UIColor *)color;

/**
 设置锚点
 
 @param anchorPoint 点
 */
- (void)setAnchorPoint:(CGPoint)anchorPoint;
/**线形动画*/
- (void)viewAnimationLineDuration:(CFTimeInterval)dur andLineType:(ViewLineType)type;
/**
 弹出效果
 
 */
- (void)viewAnimationBlowWithDuration:(NSTimeInterval)dur;
/**淡入*/
- (void)FadeShow;
/**淡出*/
- (void)FadeHid;

/**
 *  抖动效果
 */
- (void)shakeAnimation;
@end
