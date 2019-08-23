//
//  NSDate+ZFDate.h
//  ZFTool
//
//  Created by fengz on 2018/7/18.
//  Copyright © 2018年 FengZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ZFDate)


/**
 字符转时间（默认格式）
 */
+ (NSDate *)dateFromString:(NSString *)string;

/**
 字符转时间（设定格式）
 */
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;

/**
 时间转字符（默认格式）
 */
+ (NSString *)stringFromDate:(NSDate *)date;

/**
 时间转字符（设定格式）
 */
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format;

/**
 今天日期字符
 */
+ (NSString *)TodayString;

/**
 昨天日期字符
 */
+ (NSString *)YesterdayString;

/**
 后天日期字符
 */
+ (NSString *)TomorrowString;

/**
 间隔今天日期的字符
 */
+ (NSString *)daysInterval:(NSInteger)days;

/**
 是今天
 */
- (BOOL)isToday;
/**
 是这个月
 */
- (BOOL)isThisMonth;
/**
 是今年
 */
- (BOOL)isThisYear;

/**
 年
 */
- (NSString *)zf_year;

/**
 月
 */
- (NSString *)zf_month;

/**
 天
 */
- (NSString *)zf_day;

/**
 小时
 */
- (NSString *)zf_hour;

/**
 分钟
 */
- (NSString *)zf_minutes;


/**
 时间戳
 
 @return 秒
 */
- (NSString *)toTimeStampBy;
/**
 时间戳

 @return 毫秒
 */
- (NSString *)toTimeStampByMS;

+(NSString *)getTimerInterval:(NSString *)dateStr;
//NSDate日期比较，是否是同一天，同一月，同一年
+ (BOOL)checkDate:(NSDate*)date1 WithDate:(NSDate*)date2;

+ (NSString *(^)(NSString *timeStamp,NSString *format))zf_timeFormat;

/**
 timeFormat 时间字符转时间戳
 format 为nil时 时间字符格式为yyyy-MM-dd HH:mm:ss
 */
+ (NSString *(^)(NSString *timeStr,NSString *format))zf_timeStrToTimeStamp;
@end
