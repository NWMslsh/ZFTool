//  CommonTool.m
//  ZFTool
//  Created by fengz on 2018/7/25.
//  Copyright © 2018年 FengZ. All rights reserved.

#import "ZFCommon.h"
#import "Define-header.h"
#import "ZFKeyChain.h"
#define ZF_Device_Service @"ZF_Device_Service"
#define ZF_Device @"ZF_Device"
static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
@implementation ZFCommon
#pragma mark - 文件
/**
 * function: 判断文件是否存在
 * param:    @path :文件路径
 * return:   YES:文件存在； NO:文件不存在
 */
+ (BOOL)isFileExistsAtPath:(NSString*)path
{
    
    return [ZF_FileManager fileExistsAtPath:path];
}

/**
 * function: 判断文件夹是否存在,不存在则在相应的路径下创建该文件夹
 * param:    @path:文件夹路径
 * return:   YES:文件存在； NO:文件不存在
 */
+ (BOOL)createWhenDirectoryNotExistsAtPath:(NSString*)path
{
    
    if (![ZF_FileManager fileExistsAtPath:path]) {
        return [ZF_FileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return YES;
}

/**
 * function: 删除文件夹
 * param:    @path :文件路径
 * return:   YES:文件存在； NO:文件不存在
 */
+ (BOOL)removeDirectoryAtPath:(NSString*)path
{
    
    if ([ZF_FileManager fileExistsAtPath:path])  {
        return [ZF_FileManager removeItemAtPath:path error:nil];
    }
    return YES;
}

/**
 * function: 得到documents下文件路径
 * param:    @path :文件名
 * return:   文件路径
 */
+ (NSString*)documentsFilePath:(NSString*)fileName{
    
    //1、参数NSDocumentDirectory要获取的那种路径
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    //2、得到相应的Documents的路径
    NSString* documentDirectory = [paths objectAtIndex:0];
    
    return [NSString stringWithFormat:@"%@/%@", documentDirectory, fileName];
}
/**
 * function: 得到文件夹中的文件
 * param:    @path :文件名
 * return:   文件路径
 */
+ (NSArray *)getPathFiles:(NSString*)floderName{
    
    NSString *path = [self documentsFilePath:floderName];

    if (![ZF_FileManager fileExistsAtPath:path]) {
        [ZF_FileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSError *error;
    NSArray *fileArr = [ZF_FileManager contentsOfDirectoryAtPath:path error:&error];
    
    if (error) {
        
        ZFLOG(@"得到文件夹中的文件:%@",error);
        return nil;
    }
    
    return fileArr;
}
#pragma mark Image
/**
 * function:  使用图片名找本地image
 */
+ (UIImage *)imageInNSBundleWithName:(NSString *)strName type:(NSString *)type
{
    NSString* path = [[NSBundle mainBundle] pathForResource:strName ofType:type];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    return image;
}

/**
 * function:  使图片变为圆形
 */
+(UIImage*) circleImage:(UIImage*) image{
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context,2);
    CGRect rect = CGRectMake(0,0,image.size.width , image.size.height);
    CGContextAddEllipseInRect(context,rect);
    CGContextClip(context);
    [image drawInRect:rect];
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}


/**
 * function:  保存图片到document/dir
 */
+ (void)saveImage:(UIImage*)tempImage WithName:(NSString*)imageName WithDir:(NSString*)dir

{
    
    //NSData* imageData = UIImagePNGRepresentation(tempImage);
    float kCompressionQuality = 0.2;
    NSData* imageData = UIImageJPEGRepresentation(tempImage, kCompressionQuality);
    NSArray* paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString* documentsDirectory = [paths objectAtIndex:0];
    
    // Now we get the full path to the file
    
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:dir];
    if ([self createWhenDirectoryNotExistsAtPath:fullPathToFile]) {
        fullPathToFile = [fullPathToFile stringByAppendingPathComponent:imageName];
        // and then we write it out
        
        [imageData writeToFile:fullPathToFile atomically:NO];
    }
    
}
/**
 * function:  保存文件到document/dir
 */
+ (void)saveData:(NSData *)data WithName:(NSString*)dataName WithDir:(NSString*)dir

{
    NSArray* paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString* documentsDirectory = [paths objectAtIndex:0];
    
    // Now we get the full path to the file
    
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:dir];
    if ([self createWhenDirectoryNotExistsAtPath:fullPathToFile]) {
        fullPathToFile = [fullPathToFile stringByAppendingPathComponent:dataName];
        // and then we write it out
        [data writeToFile:fullPathToFile atomically:NO];
    }
    
}

/**
 移除某个目录下的文件
 */
+ (void)removeDataName:(NSString*)dataName WithDir:(NSString*)dir{
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory,NSUserDomainMask,YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    
    NSString* fullPathToFile = [[documentsDirectory stringByAppendingPathComponent:dir]stringByAppendingPathComponent:dataName];
    [ZF_FileManager removeItemAtPath:fullPathToFile error:nil];

    
}
#pragma mark -other
//字典转JSON字符
+ (NSString *)convertToJsonData:(NSDictionary *)dict

{
    if (ZF_IsNull(dict)) {
        return nil;
    }
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        NSLog(@"%@",error);
    }
    else
    {
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}
/**
 * function: 对web数据过滤，得到文字
 */
+ (NSString*)flattenHTML:(NSString*)html
{
    NSScanner *theScanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"<" intoString:nil];
        [theScanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    
    text = [NSString stringWithFormat:@"%@",html];
    
    //去掉&ldquo;   &rdquo;
    NSMutableString *Str = [[NSMutableString alloc] initWithString:text];
    NSRange range = [Str rangeOfString:@"&"];
    NSRange range2 = [Str rangeOfString:@";"];
    while (range.location != NSNotFound) {
        if (range2.location != NSNotFound) {
            NSInteger index = range2.location - range.location;
            if (index > 0 && index < 7) {
                [Str replaceCharactersInRange:NSMakeRange(range.location,index+1) withString:@""];
            }
        }
        range = [Str rangeOfString:@"&"];
        range2 = [Str rangeOfString:@";"];
    }
    
    NSString *reture = [NSString stringWithString:Str];
    
    
    return reture;
}
//退出程序
+ (void)exitApplication{
    exit(0);
}

#pragma mark VC
//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
    
}
+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC

{
    
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController])
    {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]])
    {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    }
    else if ([rootVC isKindOfClass:[UINavigationController class]])
    {
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    }
    else
    {
        // 根视图为非导航类
        currentVC = rootVC;
        
    }
    
    return currentVC;
    
}
/**
 获取设备号
 */
+ (NSString *)getUUID{
    
    NSString *device_uuid = [ZF_UserDefaults objectForKey:ZF_Device_UUID];
    if (ZF_IsEmptyStr(device_uuid)) {
        
        NSMutableDictionary *readKeyChains = (NSMutableDictionary *)[ZFKeyChain load:ZF_Device_Service];
        
        if (readKeyChains[ZF_Device] == nil) {
            
            NSMutableDictionary *saveKeyChains = [NSMutableDictionary dictionary];
            NSString *device_uuid = [NSString stringWithFormat:@"%@",[[[UIDevice currentDevice] identifierForVendor] UUIDString]];
            saveKeyChains[ZF_Device] = device_uuid;
            [ZFKeyChain save:ZF_Device_Service data:saveKeyChains];
            [ZF_UserDefaults setObject:device_uuid forKey:ZF_Device_UUID];
        }
        else
        {
            [ZF_UserDefaults setObject:readKeyChains[ZF_Device] forKey:ZF_Device_UUID];
        }
        [ZF_UserDefaults synchronize];
        
    }
    return device_uuid;
    
    
}

/**
 十六进制字符转Data
 
 */
+ (NSData *(^)(NSString *value))hexStringToData{
    
    return ^(NSString *value){
        NSMutableData* data = [NSMutableData data];
        int idx;
        for(idx = 0; idx + 2 <= value.length; idx += 2){
            NSRange range = NSMakeRange(idx, 2);
            NSString* hexStr = [value substringWithRange:range];
            NSScanner* scanner = [NSScanner scannerWithString:hexStr];
            unsigned int intValue;
            [scanner scanHexInt:&intValue];
            [data appendBytes:&intValue length:1];
        }
        return data;
    };
    
    
}



/**
 十六进制字符串转十进制数字
 */
+ (NSInteger (^)(NSString * value))hexStringToNumber{
    
    return ^(NSString * value){
        
        const char *hexChar = [value cStringUsingEncoding:NSUTF8StringEncoding];
        
        int hexNumber;
        
        sscanf(hexChar, "%x", &hexNumber);
        
        return (NSInteger)hexNumber;
        
    };
}
/**
 十进制数字转十六进制字符串
 */
+ (NSString *(^)(NSUInteger value))numberToHexString{
    
    
    return ^(NSUInteger value){
        char hexChar[6];
        sprintf(hexChar, "%02x", (int)value);
        NSString *hexString = [NSString stringWithCString:hexChar encoding:NSUTF8StringEncoding];
        
        return hexString;
    };
}
/**
 十进制数字转十六进制字符串(2字节)
 */
+ (NSString *(^)(NSUInteger value))numberToHexStringByTwoByte{
    
    
    return ^(NSUInteger value){
        char hexChar[10];
        sprintf(hexChar, "%04x", (int)value);
        NSString *hexString = [NSString stringWithCString:hexChar encoding:NSUTF8StringEncoding];
        return hexString;
    };
}
//

/**
 十进制转二进制字符串
 */
+ (NSString *(^)(NSInteger value))numberToBinStr{
    
    return ^(NSInteger value){
        NSString *binary = @"";
        while (value) {
            
            binary = [[NSString stringWithFormat:@"%ld", value % 2] stringByAppendingString:binary];
            if (value / 2 < 1) {
                
                break;
            }
            value = value / 2 ;
        }
        if (binary.length % 8 != 0) {
            
            NSMutableString *mStr = [[NSMutableString alloc]init];;
            for (int i = 0; i < 8 - binary.length % 8; i++) {
                
                [mStr appendString:@"0"];
            }
            binary = [mStr stringByAppendingString:binary];
            
        }
        return binary;
    };
    
    
}

/**
 data转NSString
 */
+ (NSString *(^)(NSData *value))dataToString{
    
    return ^(NSData *value){
        
        if (value.length == 0) {
            return @"";
        }
        NSString* result;
        const unsigned char* dataBuffer = (const unsigned char*)[value bytes];
        if(!dataBuffer){
            return @"";
        }
        NSUInteger dataLength = [value length];
        NSMutableString* hexString = [NSMutableString stringWithCapacity:(dataLength * 2 )];
        for(int i = 0; i < dataLength; i++){
            [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
        }
        result = [NSString stringWithString:hexString];
        return result;
    };
    
    
    
    
}

/**
 data转16进制字符
 */
+ (NSString *(^)(NSData *value))dataToHexStr{
    return ^(NSData *value){
        
        if (!value || [value length] == 0) {
            return @"";
        }
        NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[value length]];
        
        [value enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
            unsigned char *dataBytes = (unsigned char*)bytes;
            for (NSInteger i = 0; i < byteRange.length; i++) {
                NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
                if ([hexStr length] == 2) {
                    [string appendString:hexStr];
                } else {
                    [string appendFormat:@"0%@", hexStr];
                }
            }
        }];
        
        return [NSString stringWithString:string];
    };
}
/**
 data转int
 */
+ (NSInteger (^)(NSData *value))dataToNumber{
    
    return ^(NSData *value){
        
        if (!value || [value length] == 0) {
            return (NSInteger)0;
        }
        NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[value length]];
        
        [value enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
            unsigned char *dataBytes = (unsigned char*)bytes;
            for (NSInteger i = 0; i < byteRange.length; i++) {
                NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
                if ([hexStr length] == 2) {
                    [string appendString:hexStr];
                } else {
                    [string appendFormat:@"0%@", hexStr];
                }
            }
        }];
        NSString *valueStr = [NSString stringWithString:string];
        const char *hexChar = [valueStr cStringUsingEncoding:NSUTF8StringEncoding];
        int hexNumber;
        sscanf(hexChar, "%x", &hexNumber);
        return (NSInteger)hexNumber;
        
    };
}

/**
 data base64
 */
+ (NSString *(^)(NSData *value))dataToBase64Str;
{
    
    return ^(NSData *value){
        
        NSInteger len = value.length;
        if (len == 0)
            return @"";
        
        char *characters = malloc(((len + 2) / 3) * 4);
        if (characters == NULL)
            return @"";
        NSUInteger length = 0;
        
        NSUInteger i = 0;
        while (i < len)
        {
            char buffer[3] = {0,0,0};
            short bufferLength = 0;
            while (bufferLength < 3 && i < len)
                buffer[bufferLength++] = ((char *)[value bytes])[i++];
            
            //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
            characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
            characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
            if (bufferLength > 1)
                characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
            else characters[length++] = '=';
            if (bufferLength > 2)
                characters[length++] = encodingTable[buffer[2] & 0x3F];
            else characters[length++] = '=';
        }
        
        return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
    };
    
}

/**
 int转Str
 */
+ (NSString * (^)(int a))intToStr{
    return ^(int a){
        
        return [NSString stringWithFormat:@"%d",a];
    };
}

/**
 long转Str
 */
+ (NSString * (^)(long a))longToStr{
    
    return ^(long a){
        
        return [NSString stringWithFormat:@"%ld",a];
    };
}


@end
