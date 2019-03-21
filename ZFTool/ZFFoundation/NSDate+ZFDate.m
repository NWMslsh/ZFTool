//
//  NSDate+ZFDate.m
//  ZFTool
//  Created by fengz on 2018/7/18.
//  Copyright © 2018年 FengZ. All rights reserved.

#import "NSDate+ZFDate.h"

@implementation NSDate (ZFDate)

/**
 获取NSDateFormatter
 */
+ (NSDateFormatter *)getFormatter:(NSString *)format{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    if (format == nil)
    {
        [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    else
    {
        [outputFormatter setDateFormat:format];
    }
    return outputFormatter;
}

/**
 字符转时间（默认格式）
 */
+ (NSDate *)dateFromString:(NSString *)string{
    
    return [self dateFromString:string withFormat:nil];
}
/**
 字符转时间（设定格式）
 */
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format{
    
    NSDateFormatter *outputFormatter = [self getFormatter:format];
    
    return [outputFormatter dateFromString:string];
}

/**
 时间转字符（默认格式）
 */
+ (NSString *)stringFromDate:(NSDate *)date{
    
    return [NSDate stringFromDate:date withFormat:nil];
}

/**
 时间转字符（设定格式）
 */
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format{
    
    NSDateFormatter *outputFormatter = [self getFormatter:format];
    return [outputFormatter stringFromDate:date];
}
/**
 今天日期字符
 */
+ (NSString *)TodayString{
    
    
    return [NSDate daysInterval:0];
}

/**
 昨天日期字符
 */
+ (NSString *)YesterdayString{
    return  [NSDate daysInterval:-1];;
}

/**
 后天日期字符
 */
+ (NSString *)TomorrowString{
    return  [NSDate daysInterval:1];;
}
/**
 间隔今天日期的字符
 */
+ (NSString *)daysInterval:(NSInteger)days{
    
    NSDate *date = [[NSDate date]dateByAddingTimeInterval:days * 24 * 3600];
    NSDateFormatter *outputFormatter = [self getFormatter:nil];
    return [outputFormatter stringFromDate:date];
}
/**
 是今天
 */
- (BOOL)isToday{
    NSDateFormatter *outputFormatter = [NSDate getFormatter:@"yyyy-MM-dd"];
    if ([[outputFormatter stringFromDate:self] isEqualToString:[outputFormatter stringFromDate:[NSDate date]]]) {
        
        return true;
    }
    return false;
}
/**
 是这个月
 */
- (BOOL)isThisMonth{
    NSDateFormatter *outputFormatter = [NSDate getFormatter:@"yyyy-MM"];
    if ([[outputFormatter stringFromDate:self] isEqualToString:[outputFormatter stringFromDate:[NSDate date]]]) {
        
        return true;
    }
    return false;
}
/**
 是今年
 */
- (BOOL)isThisYear{
    NSDateFormatter *outputFormatter = [NSDate getFormatter:@"yyyy"];
    if ([[outputFormatter stringFromDate:self] isEqualToString:[outputFormatter stringFromDate:[NSDate date]]]) {
        
        return true;
    }
    return false;
}

/**
 年
 */
- (NSString *)zf_year{
    return [NSDate stringFromDate:self withFormat:@"yyyy"];
    
}

/**
 月
 */
- (NSString *)zf_month{
    return [NSDate stringFromDate:self withFormat:@"HH"];
}

/**
 天
 */
- (NSString *)zf_day{
    return [NSDate stringFromDate:self withFormat:@"dd"];
}

/**
 小时
 */
- (NSString *)zf_hour{
    return [NSDate stringFromDate:self withFormat:@"HH"];
}

/**
 分钟
 */
- (NSString *)zf_minutes{
    return [NSDate stringFromDate:self withFormat:@"mm"];
}

/**
 时间戳
 
 @return 秒
 */
- (NSString *)toTimeStampBy{
    return [NSString stringWithFormat:@"%.f",self.timeIntervalSince1970];
}
/**
 时间戳
 
 @return 毫秒
 */
- (NSString *)toTimeStampByMS{
    return [NSString stringWithFormat:@"%.f",self.timeIntervalSince1970*1000];
}
+ (NSString *)getTimerInterval:(NSString *)dateStr{
    NSDateFormatter *dateFmt = [[ NSDateFormatter alloc ] init ];
    dateFmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *myDate = [dateFmt dateFromString:dateStr];
    return myDate.toTimeStampByMS;
}
@end
