//
//  UIView+Point.m
//  ZFTool
//
//  Created by hk on 2019/3/16.
//  Copyright © 2019年 fengz. All rights reserved.
//
//  copy from https://github.com/chenfengxiaoxixi/TextSpecLib

#import "UIView+Point.h"
#import "Define-header.h"
#import <objc/runtime.h>
#pragma mark UIView
@implementation UIView (Point)
/**
 初始化
 */
+ (UIView *(^)(void))zf_init{
    return ^(){
        return [[self alloc]init];
    };
}
/**
 设置frame
 */
- (UIView *(^)(CGFloat x,CGFloat y,CGFloat width,CGFloat height))zf_frame{
    return ^(CGFloat x,CGFloat y,CGFloat width,CGFloat height){
        CGRect frame = self.frame;
        frame.origin.x = x;
        frame.origin.y = y;
        frame.size.width = width;
        frame.size.height = height;
        self.frame = frame;
        return self;
    };
}

/**
 设置背景颜色
 */
- (UIView *(^)(UIColor *color))zf_bgColor{
    return ^(UIColor *color){
        self.backgroundColor = color;
        return self;
    };
}
/**
 设置圆角
 */
- (UIView *(^)(CGFloat radius))zf_radius{
    return ^(CGFloat radius){
        [self.layer setCornerRadius:radius];
        [self.layer setMasksToBounds:YES];
        return self;
    };
}
/**
 添加到View上
 */
- (UIView *(^)(UIView *superV))zf_addToView{
    return ^(UIView *superV){
        [superV addSubview:self];
        return self;
    };
}
#pragma mark clickAction
DEFINE_EVENT(Click_block_key)
DEFINE_EVENT(Click_tap_key)
/**
 添加点击方法
 */
- (UIView *(^)(ViewCallBackBlock clickblock))zf_addClick{
    return ^(ViewCallBackBlock clickblock){
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
        
        self.clickBlock = clickblock;
        return self;
    };
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

- (ViewCallBackBlock)clickBlock
{
    return objc_getAssociatedObject(self, &Click_block_key);
}
@end
#pragma mark UIButton
@implementation UIButton (Point)
+ (UIButton *(^)(void))zf_init{
    return ^(){
        return [[self alloc]init];
        
    };
}
- (UIButton *(^)(UIFont *font))zf_Font{
    return ^(UIFont *font){
        self.titleLabel.font = font;
        return self;
    };
}
- (UIButton *(^)(NSString *title))zf_text{
    
    return ^(NSString *title){
        
        [self setTitle:title forState:UIControlStateNormal];
        return self;
    };
}
- (UIButton *(^)(NSString *title,UIControlState state))zf_textByState{
    
    return ^(NSString *title,UIControlState state){
        
        [self setTitle:title forState:state];
        return self;
    };
}
- (UIButton *(^)(UIColor *color))zf_textColor{
    return ^(UIColor *color){
        
        [self setTitleColor:color forState:UIControlStateNormal];
        return self;
    };
    
}
- (UIButton *(^)(UIColor *color,UIControlState state))zf_textColorByState{
    return ^(UIColor *color,UIControlState state){
        
        [self setTitleColor:color forState:state];
        return self;
    };
}

- (UIButton *(^)(UIColor *color))zf_bgColor{
    return ^(UIColor *color){
        [self setBackgroundColor:color];
        return self;
    };
}
/**
 image
 */
- (UIButton *(^)(UIImage *img))zf_img{
    return ^(UIImage *img){
        [self setImage:img forState:UIControlStateNormal];
        return self;
    };
}
- (UIButton *(^)(UIImage *img,UIControlState state))zf_imgByState{
    return ^(UIImage *img,UIControlState state){
        [self setImage:img forState:state];
        return self;
    };
}

/**
 BGImg
 */
- (UIButton *(^)(UIImage *img))zf_bgImg{
    return ^(UIImage *img){
        [self setBackgroundImage:img forState:UIControlStateNormal];
        return self;
    };
}
- (UIButton *(^)(UIImage *img,UIControlState state))zf_bgImgByState{
    return ^(UIImage *img,UIControlState state){
        [self setBackgroundImage:img forState:state];
        return self;
    };
}

@end
#pragma mark UILabel
@implementation UILabel (Point)
+ (UILabel *(^)(void))zf_init
{
    return ^(){
        return [[self alloc]init];
    };
}
- (UILabel *(^)(UIFont *font))zf_Font
{
    return ^(UIFont *font){
        self.font = font;
        return self;
    };
}
- (UILabel *(^)(UIColor *color))zf_textColor
{
    return ^(UIColor *color){
        self.textColor = color;
        return self;
    };
}
- (UILabel *(^)(UIColor *color))zf_bgColor{
    return ^(UIColor *color){
        self.backgroundColor = color;
        return self;
    };
}


@end
