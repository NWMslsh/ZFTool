//
//  Define-header.h
//  ZFTool
//
//  Created by fengz on 2018/7/25.
//  Copyright © 2018年 FengZ. All rights reserved.
//

//机型
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

#define SCALE_H 667/SCREEN_H

#define kStatusH [UIApplication sharedApplication].statusBarFrame.size.height
#define kNavH  44

#define KIsIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define KIsIPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750,1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640,1136), [[UIScreen mainScreen] currentMode].size)) : NO)
#define KIsIPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125,2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size)) : NO)
#define kIsIPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


/**
 判空
 */
#define  IsNull(obj) obj == nil || obj == NULL ||[obj isKindOfClass:[NSNull class]] ? YES : NO

/**
 判断空串
 */
#define  IsEmptyStr(string) string == nil || string == NULL ||[string isKindOfClass:[NSNull class]]|| [string isEqualToString:@""] ||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 ? YES : NO


#define DEFINE_EVENT(EVENT) static NSString* EVENT = @#EVENT;

#define ZFUserDefaults [NSUserDefaults standardUserDefaults]

#define ZFFileManager [NSFileManager defaultManager]

#define WeakSelf(type)  __weak typeof(type) weak##type = type;
#define BlockSelf(type)  __block typeof(type) block##type = type;
//检测block是否可用
#define BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); };
// View圆角
#define ViewRadius(View,Radius) [View.layer setCornerRadius:(Radius)]; [View.layer setMasksToBounds:YES];
//View圆角和加边框
#define ViewBorderRadius(View,Radius,Width,Color)  [View.layer setCornerRadius:(Radius)];[View.layer setMasksToBounds:YES];[View.layer setBorderWidth:(Width)];[View.layer setBorderColor:[Color CGColor]];

#define k_rgb_color(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(1)]
#define k_rgba_color(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define k_hex_color(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]




#ifdef DEBUG
#define ZFLOG(...)  printf("<%s line%d>\n%s\n", __FUNCTION__,__LINE__,[[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else

#define ZFLOG(...)

#endif

//单例
#define ZFSingletonH + (instancetype)shared;
#define ZFSingletonM(className) \
static className *_instance = nil;\
+ (instancetype)shared{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [[self alloc] init];\
});\
return _instance;\
}\
+ (instancetype)allocWithZone:(struct _NSZone *)zone{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
- (id)copyWithZone:(NSZone *)zone{\
return _instance;\
}
