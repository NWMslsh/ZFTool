//
//  UIView+Animation.m
//  ZFTool
//
//  Created by fengz on 2017/12/18.
//  Copyright © 2017年 FengZ. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)
/**淡入*/
- (void)FadeShow{
    
    if (self.superview == nil) {
        return;
    }
    
    [self.superview bringSubviewToFront:self];
    self.hidden = false;
    self.alpha = 0.0;
    self.userInteractionEnabled = false;
    [UIView animateWithDuration:0.5 animations:^{
        
        self.alpha = 1;
        
    }completion:^(BOOL finished) {
        
        self.userInteractionEnabled = true;
    }];
}
/**淡出*/
- (void)FadeHid{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        
        if (finished) {
            self.hidden = true;
            self.alpha = 1;
        }
    }];
}
/**
 设置锚点
 
 @param anchorPoint view比例见下图
 
 
 
 0----------0.5---------1
 |          →X          |
 |                      |
 |                      |
 |                      |
 |                      |
 |   ↓                  |
 0.5  Y                  |
 |                      |
 |                      |
 |                      |
 |                      |
 |                      |
 |                      |
 1--------------------(1,1)
 */
- (void)setAnchorPoint:(CGPoint)anchorPoint{
    
    CGPoint oldOrigin = self.frame.origin;
    
    self.layer.anchorPoint = anchorPoint;
    
    CGPoint newOrigin = self.frame.origin;
    
    CGPoint transition = CGPointZero;
    
    transition.x = newOrigin.x - oldOrigin.x;
    
    transition.y = newOrigin.y - oldOrigin.y;
    
    self.center = CGPointMake(self.center.x - transition.x, self.center.y - transition.y);
    
}

/**
 线形动画
 
 @param dur 时间
 @param type 类型
 */
- (void)viewAnimationLineDuration:(CFTimeInterval)dur andLineType:(ViewLineType)type{
    
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = dur;
    NSMutableArray *values = [NSMutableArray array];
    
    switch (type) {
            
            
        case ViewLineLeftToRight:
            [self setAnchorPoint:CGPointMake(0, 0.5)];
            
            
            break;
        case ViewLineRightToLeft:
            
            [self setAnchorPoint:CGPointMake(1, 0.5)];
            
            break;
            
        case ViewLineTopToBottom:
            
            [self setAnchorPoint:CGPointMake(0.5, 0)];
            
            break;
            
        case ViewLineBottomToTop:
            
            [self setAnchorPoint:CGPointMake(0.5, 1)];
            
            break;
            
        case ViewLineCornerOfTLeftToBRight:
            
            [self setAnchorPoint:CGPointMake(0.0, 0.0)];
            
            break;
            
        case ViewLineCornerOfBRightToTLeft:
            
            [self setAnchorPoint:CGPointMake(1.0, 1.0)];
            
            
            break;
        case ViewLineCornerOfBLeftToTRight:
            [self setAnchorPoint:CGPointMake(0.0, 1.0)];
            
            break;
        case ViewLineCornerOfTRightToBLeft:
            [self setAnchorPoint:CGPointMake(1.0, 0.0)];
            
            break;
            
            default:
            break;
            
    }
    
    
    for (CGFloat i = 0.1; i <= 1; i += 0.1) {
        
        if(type == ViewLineLeftToRight || type == ViewLineRightToLeft)
        {
            
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(i, 1, 1.0)]];
            
        }
        else if(type == ViewLineTopToBottom || type == ViewLineBottomToTop){
            
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, i, 1.0)]];
            
        }
        else{
            
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(i, i, 1.0)]];
            
        }
        
    }
    animation.values = values;
    [self.layer addAnimation:animation forKey:nil];
    
    
    if (type != ViewLineTypeNormal) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((dur + 0.01) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setAnchorPoint:CGPointMake(0.5, 0.5)];
        });
    }
    
    
}

/**
 弹出效果

 */
- (void)viewAnimationBlowWithDuration:(NSTimeInterval)dur{
    
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    
    animation.duration = dur;
    
    NSMutableArray *values = [[NSMutableArray alloc]init];
    
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    
    [self.layer addAnimation:animation forKey:nil];
}
/**
 *  抖动效果
 *
 */
- (void)shakeAnimation{
    // 获取到当前的View
    
    CALayer *viewLayer = self.layer;
    
    // 获取当前View的位置
    
    CGPoint position = viewLayer.position;
    
    // 移动的两个终点位置
    
    CGPoint x = CGPointMake(position.x + 10, position.y);
    
    CGPoint y = CGPointMake(position.x - 10, position.y);
    
    // 设置动画
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    // 设置运动形式
    
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    
    // 设置开始位置
    
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    
    // 设置结束位置
    
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    
    // 设置自动反转
    
    [animation setAutoreverses:YES];
    
    // 设置时间
    
    [animation setDuration:.06];
    
    // 设置次数
    
    [animation setRepeatCount:3];
    
    // 添加上动画
    
    [viewLayer addAnimation:animation forKey:nil];
}


@end
