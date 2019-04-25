//
//  Define-header.h
//  ZFTool
//
//  Created by fengz on 2018/7/25.
//  Copyright © 2018年 FengZ. All rights reserved.
//
#define ZF_Phone_Number @"0123456789-"
#define ZF_PaasWord_Number @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_"


//机型
#define ZF_ScreenH [UIScreen mainScreen].bounds.size.height
#define ZF_ScreenW [UIScreen mainScreen].bounds.size.width

#define ZF_ScaleH ZF_ScreenH/667.0

#define ZF_StatusH [UIApplication sharedApplication].statusBarFrame.size.height
#define ZF_NavH  self.navigationController.navigationBar.frame.size.height
#define ZF_StatusHAndNavH ZF_StatusH + ZF_NavH
#define ZF_TabbarH (ZF_StatusH > 20.0?83.0:49.0)


#define ZF_IsIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define ZF_IsIPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750,1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640,1136), [[UIScreen mainScreen] currentMode].size)) : NO)
#define ZF_IsIPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125,2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size)) : NO)
#define ZF_IsIPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//IMG
#define IMG(IMGSTR)  [UIImage imageNamed:IMGSTR]
/**
 判空
 */
#define  ZF_IsNull(obj) [obj isKindOfClass:[NSNull class]] || obj == NULL || obj == nil ? YES : NO

/**
 判断空串
 */
#define  ZF_IsEmptyStr(string) string == nil || string == NULL ||[string isKindOfClass:[NSNull class]]|| [string isEqualToString:@""] ||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 ? YES : NO


#define DEFINE_EVENT(EVENT) static NSString* EVENT = @#EVENT;

#define ZF_UserDefaults [NSUserDefaults standardUserDefaults]

#define ZF_FileManager [NSFileManager defaultManager]

#define ZF_WeakSelf(type)  __weak typeof(type) weak##type = type;
#define ZF_BlockSelf(type)  __block typeof(type) block##type = type;
//检测block是否可用
#define ZF_BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); };
// View圆角
#define ZF_ViewRadius(View,Radius) [View.layer setCornerRadius:(Radius)]; [View.layer setMasksToBounds:YES];
//View圆角和加边框
#define ZF_ViewBorderRadius(View,Radius,Width,Color)  [View.layer setCornerRadius:(Radius)];[View.layer setMasksToBounds:YES];[View.layer setBorderWidth:(Width)];[View.layer setBorderColor:[Color CGColor]];

#define ZF_rgb_color(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(1)]
#define ZF_rgba_color(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define ZF_hex_color(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]




#ifdef DEBUG
#define ZFLOG(...)  printf("%s <line:%d> %s\n", __FUNCTION__,__LINE__,[[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#define MCULOG(...)  printf("%s\n",[[NSString stringWithFormat:__VA_ARGS__] UTF8String])

#else

#define ZFLOG(...)
#define MCULOG(...)

#endif

//单例
#define ZF_SingletonH + (instancetype)shared;
#define ZF_SingletonM(className) \
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


#define ZF_PostNotication(aName,anObject,aUserInfo) dispatch_async(dispatch_get_main_queue(), ^{\
[[NSNotificationCenter defaultCenter]postNotificationName:aName object:anObject userInfo:aUserInfo];\
});

#define ZF_AddNotication(name_Y)   [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onEventNotification:) name:name_Y object:nil];


#define ZF_RemNotication(name) [[NSNotificationCenter defaultCenter] removeObserver:self name:name object:nil];
