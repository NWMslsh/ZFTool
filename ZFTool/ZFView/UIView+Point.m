//
//  UIView+Point.m
//  ZFTool
//
//  Created by hk on 2019/3/16.
//  Copyright © 2019年 fengz. All rights reserved.
//
//  copy from https://github.com/chenfengxiaoxixi/TextSpecLib

#import "UIView+Point.h"
#pragma mark UIView
@implementation UIView (Point)
+ (UIView *(^)(void))zf_init{
    return ^(){
        return [[self alloc]init];
    };
}

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

- (UIView *(^)(UIColor *color))zf_bgColor{
    
    
    return ^(UIColor *color){
        self.backgroundColor = color;
        return self;
    };
    
    
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
