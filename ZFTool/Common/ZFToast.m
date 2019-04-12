//
//  ZFToast.m
//  ZFTool
//
//  Created by fengz on 2018/7/27.
//  Copyright © 2018年 FengZ. All rights reserved.
//

#import "ZFToast.h"
#import "Define-header.h"
#import "UIColor+ZFColor.h"
#import "UIFont+ZFFont.h"
#import "UIView+ZFView.h"
#import "UIView+Animation.h"
@interface ZFToast()
@property(nonatomic,strong)NSTimer *fadeOutTimer;
@property(nonatomic,weak)UILabel *titlelb;
@end
@implementation ZFToast
static ZFToast *instance_toast = nil;
+ (instancetype)share{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_toast = [[self alloc]init];
    });
    return instance_toast;
}
- (instancetype)init
{
    if (self = [super init]) {
        
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = true;
        
        self.hidden = true;
        self.backgroundColor = [UIColor mask_color];
        UILabel *titlelb = [UILabel new];
        titlelb.font = [UIFont Size:15];
        titlelb.numberOfLines = 0;
        titlelb.textAlignment = NSTextAlignmentCenter;
        titlelb.textColor = [UIColor white_color];
        [self addSubview:titlelb];
        self.titlelb = titlelb;
        
    }
    return self;
}
//设置定时器
- (void)setFadeOutTimer:(NSTimer *)fadeOutTimer{
    if (_fadeOutTimer != nil) {
        [_fadeOutTimer invalidate];
        _fadeOutTimer = nil;
    }
    if (fadeOutTimer != nil) {
        _fadeOutTimer = fadeOutTimer;
    }
    
}
//出现
+ (void)showStatus:(NSString *)status{
    
    UIWindow *view = [[[UIApplication sharedApplication] delegate] window];
    NSArray *windows = [UIApplication sharedApplication].windows;
    for (id windowView in windows) {
        NSString *viewName = NSStringFromClass([windowView class]);
        if ([@"UIRemoteKeyboardWindow" isEqualToString:viewName]) {
            view = windowView;
            break;
        }
    }
    [view addSubview:[self share]];
    [[self share]showInfo:status andTimeInterval:[self displayDurationFor:status]];
}

- (void)showInfo:(NSString *)status andTimeInterval:(NSTimeInterval)dur{
    
    self.titlelb.text = status;
    CGFloat width = [UIView getLableWidth:status font:[UIFont Size:15]] + 20;
    
    if (width > ZF_ScreenW - 100) {
        width = ZF_ScreenW - 100;
    }
    
    CGFloat height = [UIView getLableHeigth:status font:[UIFont Size:15] andWidth:ZF_ScreenW - 100] + 10;
    self.frame = CGRectMake((ZF_ScreenW - width)/2, ZF_ScreenH - height - 64, width, height);
    self.titlelb.frame = self.bounds;
    if (self.hidden) {
        [self viewAnimationBlowWithDuration:0.5];
    }
    
    self.hidden = false;
    ZF_WeakSelf(self);

    dispatch_async(dispatch_get_main_queue(), ^{
        
        weakself.fadeOutTimer = [NSTimer timerWithTimeInterval:dur target:self selector:@selector(diss) userInfo:nil repeats:NO];
        
        [[NSRunLoop mainRunLoop] addTimer:weakself.fadeOutTimer forMode:NSRunLoopCommonModes];
        
    });
    
}
//隐藏
- (void)diss{
    self.hidden = true;
    [self removeFromSuperview];
}
//返回出现时间
+ (NSTimeInterval)displayDurationFor:(NSString *)string{
    NSTimeInterval minDuration = MAX(string.length * 0.06 + 0.5, 1.5);
    return MIN(minDuration, 8.0);
}


@end
