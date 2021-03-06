//
//  NSString+ZFString.h
//  ZFTool
//
//  Created by fengz on 2018/7/18.
//  Copyright © 2018年 FengZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZFString)

/**
 手机号校验
 */
- (BOOL)checkPhoneNum;
/**
 拼入注入html代码
 
 @return str
 */
- (NSString *)converToHtmlStr;
/**
 邮箱校验
 */
- (BOOL)isEmailValidate;

/**
 非法字符校验
 */
- (BOOL)JudgeTheillegalCharacter;

/**
 空格校验
 */
- (BOOL)checkCharIsAllEmpy;

/**
 身份证识别
 */
- (BOOL)checkIdentityCardNo;

/**
 是否存在汉字
 */
- (BOOL)hasChinese;

/**
 千分位
 */
- (NSString *)ThousandsFormat;

#pragma mark -加密编码
/**
 *  32位MD5加密
 */
@property (nonatomic,copy,readonly) NSString *MD5;
/**
 *  SHA1加密
 */
@property (nonatomic,copy,readonly) NSString *sha1;


/**
 AES加密
 */
- (NSString *)AES_encryptForKey:(NSString *)key;
/**
 AES解密
 */
- (NSString *)AES_decryptForKey:(NSString*)key;


/**
 文件MD5加密
 @param path 路径
 */
+ (NSString*)md5OfFilePath:(NSString*)path;

/**
 是否包含
 */
- (BOOL)isContainsString:(NSString *)sFind;

/**
 密码过滤
 @return true则不合规则
 */
- (BOOL)passrodFilter;


@end
