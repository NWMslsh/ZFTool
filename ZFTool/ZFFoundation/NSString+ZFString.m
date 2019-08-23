//
//  NSString+ZFString.m
//  ZFTool
//
//  Created by fengz on 2018/7/18.
//  Copyright © 2018年 FengZ. All rights reserved.
//

#import "NSString+ZFString.h"
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "NSData+ZFData.h"

#define FileHashDefaultChunkSizeForReadingData 1024*8
@implementation NSString (ZFString)



#pragma mark -拼入注入html代码
- (NSString *)converToHtmlStr
{
    NSString *header = @"<html><head><meta name=\"viewport\" content=\"width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no\"/> <style type=\"text/css\">img{width:100%}</style> </head><boby style=\"width:100%; margin:0 auto;-webkit-user-select: none;-moz-user-select: none;\">";
    NSString *footer = @"</boby></html>";
    return [NSString stringWithFormat:@"%@%@%@",header,self,footer];
}

#pragma mark -邮箱校验
- (BOOL)isEmailValidate
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
#pragma mark -非法字符校验
- (BOOL)JudgeTheillegalCharacter{
    
    NSString *content = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    //提示 标签不能输入特殊字符
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![emailTest evaluateWithObject:content]) {
        return YES;
    }
    return NO;
}
#pragma mark -空格校验
- (BOOL)checkCharIsAllEmpy
{
    if([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0) {
        
        return YES;
    }
    
    return NO;
}
#pragma mark - 身份证识别
- (BOOL)checkIdentityCardNo
{
    if (self.length != 18) {
        
        return  NO;
    }
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    NSScanner* scan = [NSScanner scannerWithString:[self substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        
        
        return NO;
    }
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        sumValue+=[[self substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    if ([strlast isEqualToString: [[self substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
    
    return  NO;
}

/**
 是否含有汉字
 */
- (BOOL)hasChinese {
    
    for(int i=0; i< [self length];i++){
        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}

#pragma mark 手机号码验证
- (BOOL)checkPhoneNum
{
    NSString *mobileNum = self;
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|47[0-9]|70[0-9]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56]|7[0-9])\\d{8}$";
    
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,177,180,189
     22         */
    NSString * CT = @"^1((33|53|77|8[09])[0-9]|349)\\d{7}$";
    
    
    
    
    
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    //NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    //香港6和9开头后台跟7位数字
    NSString *HK = @"^([5|6|8|9])\\d{7}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    NSPredicate *regextestHK = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", HK];
    
    if(([regextestmobile evaluateWithObject:mobileNum] == YES)
       || ([regextestcm evaluateWithObject:mobileNum] == YES)
       || ([regextestct evaluateWithObject:mobileNum] == YES)
       || ([regextestcu evaluateWithObject:mobileNum] == YES)
       || ([regextestHK evaluateWithObject:mobileNum] == YES)){
        
        return false;
    }
    else
    {
        
        return true;
    }
    
}
#pragma mark 表情过滤
+ (BOOL)isEmojiWith:(NSString *)string{
    
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                   const unichar high = [substring characterAtIndex: 0];
                                   
                                   // Surrogate pair (U+1D000-1F9FF)
                                   if (0xD800 <= high && high <= 0xDBFF) {
                                       const unichar low = [substring characterAtIndex: 1];
                                       const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
                                       
                                       if (0x1D000 <= codepoint && codepoint <= 0x1F9FF){
                                           returnValue = YES;
                                       }
                                       
                                       // Not surrogate pair (U+2100-27BF)
                                   } else {
                                       if (0x2100 <= high && high <= 0x27BF){
                                           returnValue = YES;
                                       }
                                   }
                               }];
    
    return returnValue;
}


/**
 千分位
 */
- (NSString *)ThousandsFormat{
    if(!self || [self floatValue] == 0)
    {
        return @"0.00";
    }
    else if ([self floatValue] < 1)
    {
        return [NSString stringWithFormat:@"%.2f",self.floatValue];
    }
    else
    {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setPositiveFormat:@",###.00;"];
        return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[self doubleValue]]];
    }
    return @"";
}

#pragma mark -32位MD5加密
-(NSString *)MD5{
    
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }
    
    return [result copy];
}

#pragma mark -SHA1加密
- (NSString *)sha1{
    
    const char *cStr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cStr length:self.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return [result copy];
}
#pragma mark AES加密

NSString *const kInitVector = @"BH-128ByteVector";

- (NSString *)AES_encryptForKey:(NSString *)key {
    
    NSData *contentData = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:false];
    NSUInteger dataLength = contentData.length;
    
    // 为结束符'\\0' +1
    char keyPtr[kCCKeySizeAES256 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    // 密文长度 <= 明文长度 + BlockSize
    size_t encryptSize = dataLength + kCCBlockSizeAES128;
    void *encryptedBytes = malloc(encryptSize);
    size_t actualOutSize = 0;
    
    NSData *initVector = [kInitVector dataUsingEncoding:NSUTF8StringEncoding];
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,  // 系统默认使用 CBC，然后指明使用 PKCS7Padding
                                          keyPtr,
                                          kCCKeySizeAES256,
                                          initVector.bytes,
                                          contentData.bytes,
                                          dataLength,
                                          encryptedBytes,
                                          encryptSize,
                                          &actualOutSize);
    
    if (cryptStatus == kCCSuccess) {
        // 对加密后的数据进行 base64 编码
        return [[NSData dataWithBytesNoCopy:encryptedBytes length:actualOutSize] base64Encoding];
    }
    
    free(encryptedBytes);
    return nil;
}
#pragma mark AES解密
- (NSString *)AES_decryptForKey:(NSString*)key
{
    //把 base64 String 转换成 Data
    NSData * contentData = [[NSData alloc]initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSUInteger dataLength = contentData.length;
    char keyPtr[kCCKeySizeAES256 + 1];
    memset(keyPtr,0,sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    size_t decryptSize = dataLength + kCCBlockSizeAES128;
    void *decryptedBytes = malloc(decryptSize);
    size_t actualOutSize = 0;
    NSData *initVector=[kInitVector dataUsingEncoding:NSUTF8StringEncoding];
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCKeySizeAES256,
                                          initVector.bytes,
                                          contentData.bytes,
                                          dataLength,
                                          decryptedBytes,
                                          decryptSize,
                                          &actualOutSize);
    
    
    
    
    
    if(cryptStatus==kCCSuccess)
    {
        
        return[[NSString alloc] initWithData:[NSData dataWithBytesNoCopy:decryptedBytes length:actualOutSize] encoding:NSUTF8StringEncoding];
        
    }
    free(decryptedBytes);
    
    
    return
    nil;
    
    
}

+ (NSString *)md5OfFilePath:(NSString *)filePath
{
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    if (!handle) {
        return @"";
    }
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    BOOL done = NO;
    while(!done)
    {
        NSData* fileData = [handle readDataOfLength: 256 ];
        CC_MD5_Update(&md5, [fileData bytes], (CC_LONG)[fileData length]);
        if( [fileData length] == 0 ) done = YES;
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString *s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0], digest[1],
                   digest[2], digest[3],
                   digest[4], digest[5],
                   digest[6], digest[7],
                   digest[8], digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
    
    return s;
}

- (BOOL)isContainsString:(NSString *)sFind {
    if (sFind == nil) {
        return FALSE;
    }
    NSRange range = [self rangeOfString:sFind];
    return range.length != 0;
}
- (BOOL)passrodFilter{
    if (self.length > 16) {
        return true;
    }
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ZF_PaasWord_Number] invertedSet];
    
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    if (![self isEqualToString:filtered]) {
        return true;
    }
    return false;
}

+ (NSString * (^)(int a))initInt{
    return ^(int a){
        
        return [NSString stringWithFormat:@"%d",a];
    };
}
+ (NSString * (^)(long a))initLong{
    
    return ^(long a){
        
        return [NSString stringWithFormat:@"%ld",a];
    };
}
@end
