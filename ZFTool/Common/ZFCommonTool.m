//  CommonTool.m
//  ZFTool
//  Created by fengz on 2018/7/25.
//  Copyright © 2018年 FengZ. All rights reserved.

#import "ZFCommonTool.h"
#import "Define-header.h"

@implementation ZFCommonTool
#pragma mark - 文件
/**
 * function: 判断文件是否存在
 * param:    @path :文件路径
 * return:   YES:文件存在； NO:文件不存在
 */
+ (BOOL)isFileExistsAtPath:(NSString*)path
{
    
    return [ZFFileManager fileExistsAtPath:path];
}

/**
 * function: 判断文件夹是否存在,不存在则在相应的路径下创建该文件夹
 * param:    @path:文件夹路径
 * return:   YES:文件存在； NO:文件不存在
 */
+ (BOOL)createWhenDirectoryNotExistsAtPath:(NSString*)path
{
    
    if (![ZFFileManager fileExistsAtPath:path]) {
        return [ZFFileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
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
    
    if ([ZFFileManager fileExistsAtPath:path])  {
        return [ZFFileManager removeItemAtPath:path error:nil];
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

#pragma mark -other
//字典转JSON字符
+ (NSString *)convertToJsonData:(NSDictionary *)dict

{
    if (IsNull(dict)) {
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
@end
