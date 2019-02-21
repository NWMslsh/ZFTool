//
//  UIView+Animation.h
//  ZFTool
//
//  Created by fengz on 2017/12/18.
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
@interface UIView (Animation)
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
