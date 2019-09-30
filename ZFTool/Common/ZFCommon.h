//
//  CommonTool.h
//  ZFTool
//
//  Created by fengz on 2018/7/25.
//  Copyright © 2018年 FengZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ZFCommon : NSObject
#pragma mark - 文件
/**
 * function: 判断文件是否存在
 * param:    @path :文件路径
 * return:   YES:文件存在； NO:文件不存在
 */
+ (BOOL)isFileExistsAtPath:(NSString*)path;

/**
 * function: 判断文件夹是否存在,不存在则在相应的路径下创建该文件夹
 * param:    @path:文件夹路径
 * return:   YES:文件存在； NO:文件不存在
 */
+ (BOOL)createWhenDirectoryNotExistsAtPath:(NSString*)path;

/**
 * function: 删除文件夹
 * param:    @path :文件路径
 * return:   YES:文件存在； NO:文件不存在
 */
+ (BOOL)removeDirectoryAtPath:(NSString*)path;

/**
 * function: 得到documents下文件路径
 * param:    @path :文件名
 * return:   文件路径
 */
+ (NSString*)documentsFilePath:(NSString*)fileName;
/**
 * function: 得到文件夹中的文件
 * param:    @path :文件名
 * return:   文件路径
 */
+ (NSArray *)getPathFiles:(NSString*)floderName;

#pragma mark Image
/**
 * function:  使用图片名找本地image
 */
+ (UIImage *)imageInNSBundleWithName:(NSString *)strName type:(NSString *)type;

/**
 * function:  使图片变为圆形
 */
+(UIImage*) circleImage:(UIImage*) image;


/**
 * function:  保存图片到document/dir
 */
+ (void)saveImage:(UIImage*)tempImage WithName:(NSString*)imageName WithDir:(NSString*)dir;
/**
 * function:  保存文件到document/dir
 */
+ (void)saveData:(NSData *)data WithName:(NSString*)dataName WithDir:(NSString*)dir;
/**
 移除某个目录下的文件
 */
+ (void)removeDataName:(NSString*)dataName WithDir:(NSString*)dir;

#pragma mark VC
//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC;

#pragma mark other
//字典转JSON字符
+ (NSString *)convertToJsonData:(NSDictionary *)dict;

/**
 * function: 对web数据过滤，得到文字
 */
+ (NSString*)flattenHTML:(NSString*)html;
//退出程序
+ (void)exitApplication;

/**
 获取设备号
 */
+ (NSString *)getUUID;

/**
 十六进制字符转Data
 */
+ (NSData *(^)(NSString *value))hexStringToData;
/**
 十六进制字符串转十进制数字
 */
+ (NSInteger (^)(NSString * value))hexStringToNumber;
/**
 十进制数字转十六进制字符串(2字节)
 */
+ (NSString *(^)(NSUInteger value))numberToHexStringByTwoByte;
/**
 十进制数字转十六进制字符串
 */
+ (NSString *(^)(NSUInteger value))numberToHexString;
/**
 十进制转二进制字符串
 */
+ (NSString *(^)(NSInteger value))numberToBinStr;
/**
 data转NSString
 */
+ (NSString *(^)(NSData *value))dataToString;

/**
 data转16进制字符
 */
+ (NSString *(^)(NSData *value))dataToHexStr;
/**
 data转int
 */
+ (NSInteger (^)(NSData *value))dataToNumber;

/**
 data base64
 */
+ (NSString *(^)(NSData *value))dataToBase64Str;

/**
 int转Str
 */
+ (NSString * (^)(int a))intToStr;

/**
 long转Str
 */
+ (NSString * (^)(long a))longToStr;
@end
