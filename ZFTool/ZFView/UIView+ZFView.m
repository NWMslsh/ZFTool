//
//  UIView+ZFView.m
//  ZFTool
//
//  Created by fengz on 2017/12/15.
//  Copyright © 2017年 FengZ. All rights reserved.
//

#import "UIView+ZFView.h"
#import "UIView+Point.h"
#import "Define-header.h"
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
#pragma mark clickAction
DEFINE_EVENT(Click_block_key)
DEFINE_EVENT(Click_tap_key)
/**
 添加点击事件
 */
- (void)addClickAction:(ViewCallBackBlock)block{
    self.clickBlock  = block;
    
    self.userInteractionEnabled = YES;
    
    /**
     *  添加相同事件方法，，先将原来的事件移除，避免重复调用
     */
    NSMutableArray *taps = [self allUIViewBlockTaps];
    [taps enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITapGestureRecognizer *tap = (UITapGestureRecognizer *)obj;
        [self removeGestureRecognizer:tap];
    }];
    [taps removeAllObjects];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(invoke:)];
    [self addGestureRecognizer:tap];
    [taps addObject:tap];
}
- (void)invoke:(id)sender
{
    ZF_BLOCK_EXEC(self.clickBlock,nil);
}

- (NSMutableArray *)allUIViewBlockTaps
{
    NSMutableArray *taps = objc_getAssociatedObject(self, &Click_tap_key);
    if (!taps) {
        taps = [NSMutableArray array];
        objc_setAssociatedObject(self, &Click_block_key, taps, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return taps;
}
- (void)setClickBlock:(ViewCallBackBlock)clickBlock{
    objc_setAssociatedObject(self, &Click_block_key, clickBlock, OBJC_ASSOCIATION_COPY);
}

- (ViewCallBackBlock)touchCallBackBlock
{
    return objc_getAssociatedObject(self, &Click_block_key);
}
@end
