//
//  ChangeLanguage.m
//  USDT
//
//  Created by hk on 2019/4/29.
//  Copyright © 2019年 Fengz. All rights reserved.
//

#import "ZFAppLanguage.h"
#import "Define-header.h"

#define Language_ZH_Str @"zh-Hans"
#define Language_EN_Str @"en"

#define App_LanguageKey @"AppLanguages"

@implementation ZFAppLanguage
static NSBundle *bundle = nil;
static LanguageType appLanguage = Lan_EN;
+ (NSBundle *)getBundle {
    return bundle;
}

//首次加载时检测语言是否存在
+ (void)load {
    
    NSString *currLanguage = [ZF_UserDefaults valueForKey:App_LanguageKey];
    if (!currLanguage) {
        NSArray *preferredLanguages = [NSLocale preferredLanguages];
        currLanguage = preferredLanguages[0];
        
        if ([currLanguage hasPrefix:@"zh-HK"] ||
            [currLanguage hasPrefix:@"zh-Hant"] ||
            [currLanguage hasPrefix:@"zh-Hans"]) {
            currLanguage = Language_ZH_Str;
            appLanguage = Lan_ZH;
        
        }
        else
        {
            currLanguage = Language_EN_Str;
            appLanguage = Lan_EN;
        }
        [ZF_UserDefaults setValue:currLanguage forKey:App_LanguageKey];
        [ZF_UserDefaults synchronize];
    }else
    {
        if ([currLanguage isEqualToString:Language_ZH_Str]) {
            appLanguage = Lan_ZH;
        
        }else{
             appLanguage = Lan_EN;
        }
    }
    //获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:currLanguage ofType:@"lproj"];
    bundle = [NSBundle bundleWithPath:path];//生成bundle
}

+ (void)setLanguage:(LanguageType)language{
    if (appLanguage == language) {
        return;
    }
    appLanguage = language;
    NSString *currLanguage = [ZF_UserDefaults valueForKey:App_LanguageKey];
    switch (appLanguage) {
        case Lan_ZH:
            currLanguage = Language_ZH_Str;
            break;
        case Lan_EN:
            currLanguage = Language_EN_Str;
            break;
        default:
            break;
    }
    [ZF_UserDefaults setValue:currLanguage forKey:App_LanguageKey];
    [ZF_UserDefaults synchronize];
    NSString *path = [[NSBundle mainBundle] pathForResource:currLanguage ofType:@"lproj"];
    bundle = [NSBundle bundleWithPath:path];
    ZF_PostNotication(AppLanguageChange_Notication, nil, nil)
}

+(LanguageType)language{
    return appLanguage;
}

+ (void)changeLan{
    
    LanguageType newLan = appLanguage;
    if (newLan == Lan_EN) {
        newLan = Lan_ZH;
    }
    else
    {
        newLan ++;
    }
    [self setLanguage:newLan];
    
    
    
}
+ (NSString *)getServiceLan{
    NSString *lan = @"1";
    switch (appLanguage) {
        case Lan_EN:
            lan = @"2";
            break;
        default:
            break;
    }
    return lan;
    
}
@end
