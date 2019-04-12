//
//  UIView+Point.m
//  ZFTool
//
//  Created by hk on 2019/3/16.
//  Copyright © 2019年 fengz. All rights reserved.
//
//  copy from https://github.com/chenfengxiaoxixi/TextSpecLib

#import "UIView+Point.h"

@implementation UIView (Point)
+ (UIView *(^)(void))zf_init{
    return ^(){
        return [[UIView alloc]init];
        
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

@implementation UIButton (Point)
+ (UIButton *(^)(void))zf_init{
    return ^(){
        return [[UIButton alloc]init];
        
    };
}
- (UIButton *(^)(UIFont *font))zf_Font{
    return ^(UIFont *font){
        self.titleLabel.font = font;
        return self;
    };
}
- (UIButton *(^)(NSString *title,UIControlState state))zf_text{
    
    return ^(NSString *title,UIControlState state){
        
        [self setTitle:title forState:state];
        return self;
    };
}
- (UIButton *(^)(UIColor *color,UIControlState state))zf_textColor{
 
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
- (UIButton *(^)(UIImage *img,UIControlState state))zf_img{
    return ^(UIImage *img,UIControlState state){
        [self setImage:img forState:state];
        return self;
    };
}
- (UIButton *(^)(UIImage *img,UIControlState state))zf_bgImg{
    return ^(UIImage *img,UIControlState state){
        [self setBackgroundImage:img forState:state];
        return self;
    };
}

@end

@implementation UILabel (Point)
+ (UILabel *(^)(void))zf_init
{
    return ^(){
        return [[UILabel alloc]init];
        
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
