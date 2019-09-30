//
//  UIView+ZFView.m
//  ZFTool
//
//  Created by fengz on 2017/12/15.
//  Copyright © 2017年 FengZ. All rights reserved.
//

#import "UIView+ZFView.h"


@implementation UIView (ZFView)
#pragma mark X
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
    
}

- (CGFloat)x
{
    return self.frame.origin.x;
}
#pragma mark Y
- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

#pragma mark CenterX
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)centerX
{
    return self.center.x;
}
#pragma mark CenterY
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

#pragma mark RightX
- (void)setRightX:(CGFloat)rightX{
    
    CGRect frame = self.frame;
    frame.origin.x = rightX - frame.size.width;
    self.frame = frame;
    
    
}
- (CGFloat)rightX{
    return self.frame.origin.x + self.frame.size.width;
}
#pragma mark BottomY

- (void)setBottomY:(CGFloat)bottomY{
    
    CGRect fram = self.frame;
    fram.origin.y = bottomY - self.frame.size.height;
    self.frame = fram;
}
- (CGFloat)bottomY{
    
    return self.frame.origin.y + self.frame.size.height;
}
#pragma mark size
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

#pragma mark width
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)width
{
    return self.frame.size.width;
}


#pragma mark height
- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)height
{
    return self.frame.size.height;
}
/**
 设置数据
 */
- (void)binData:(id)data{}
/**从Xib加载*/
+ (instancetype)LoadFormNib
{
    UIView *view = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
    
    if (view == nil) {
        view = [[self alloc]init];
    }
    return view;
    
}

/**画线*/
- (CALayer *)drawlayerwithFram:(CGRect)rect withColor:(UIColor *)color{
    CALayer *border = [CALayer layer];
    border.frame = rect;
    border.backgroundColor = [color CGColor];
    [self.layer addSublayer:border];
    return border;
}
/**
 画虚线
 */
- (UIImageView *)drawDashLineRect:(CGRect)rect color:(UIColor *)color{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
    [self addSubview:imageView];
    UIGraphicsBeginImageContext(imageView.frame.size); //开始画线 划线的frame
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    //设置线条终点形状
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    // 5是每个虚线的长度 5是间隔
    CGFloat lengths[] = {5,3};
    CGContextRef line = UIGraphicsGetCurrentContext();
    // 设置颜色
    CGContextSetStrokeColorWithColor(line, color.CGColor);
    
    CGContextSetLineDash(line, 0, lengths, 2); //画虚线
    //开始画线
    CGContextMoveToPoint(line, 0.0, 1.5);
    CGContextAddLineToPoint(line, rect.size.width, 1.5);
    
    CGContextStrokePath(line);
    
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    return imageView;
}

- (void)drawPointLineRect:(CGRect)rect color:(UIColor *)color
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:rect];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame)/2)];
    
    [shapeLayer setStrokeColor:color.CGColor];
    [shapeLayer setLineWidth:0.5];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:@[@5,@3]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    if (CGRectGetWidth(self.frame) > CGRectGetHeight(self.frame)) {
        CGPathAddLineToPoint(path, NULL, CGRectGetWidth(self.frame),0);
    }else{
        CGPathAddLineToPoint(path, NULL, 0,CGRectGetHeight(self.frame));
    }
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    //  把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}
/**
 获取label高度

 */
+ (CGFloat)getLableHeigth:(NSString *)str font:(UIFont *)font andWidth:(CGFloat)width{
    CGSize textSize = [str boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)             options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:font}
                                        context:nil].size;
    
    
    return textSize.height + 5;
}

/**
 获取label宽度
 */
+ (CGFloat)getLableWidth:(NSString *)str font:(UIFont *)font{
    CGSize textSize = [str boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 30)             options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:font}
                                        context:nil].size;
    
    
    return textSize.width + 10;
}

+ (void)p_changeMultiplierOfConstraint:(NSLayoutConstraint *)constraint multiplier:(CGFloat)multiplier {
    
    [NSLayoutConstraint deactivateConstraints:@[constraint]];
    NSLayoutConstraint *newConstraint = [NSLayoutConstraint constraintWithItem:constraint.firstItem attribute:constraint.firstAttribute relatedBy:constraint.relation toItem:constraint.secondItem attribute:constraint.secondAttribute multiplier:multiplier constant:constraint.constant];
    newConstraint.priority = constraint.priority;
    newConstraint.shouldBeArchived = constraint.shouldBeArchived;
    newConstraint.identifier = constraint.identifier;
    [NSLayoutConstraint activateConstraints:@[newConstraint]];
}
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
