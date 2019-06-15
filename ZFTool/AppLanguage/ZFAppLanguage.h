//
//  ChangeLanguage.h
//  USDT
//
//  Created by hk on 2019/4/29.
//  Copyright © 2019年 Fengz. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum : NSUInteger {
    /**简体*/
    Lan_ZH,
    /**英文*/
    Lan_EN,
} LanguageType;

@interface ZFAppLanguage : NSObject

@property(class,nonatomic,assign)LanguageType language;
+ (NSBundle *)getBundle;

+ (void)changeLan;

+ (NSString *)getServiceLan;
@end


