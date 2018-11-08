//
//  NSDate+SFJDate.h
//  HK_Sensor
//
//  Created by Experimental Computer on 2018/4/9.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (SFJDate)
/**
 日期转字符串格式
 */
+(NSString *)stringFromDate:(NSDate *)date formatter:(NSString *)formatter;
/**
 字符串转日期格式
 */
+(NSDate *)dateFromString:(NSString *)dateString formatter:(NSString *)formatter;

/**
 unix时间戳转换
*/
+(NSString *)DateFromJsonString:(NSString *)unixDateString formatter:(NSString *)formatter;

/**
 计算时间差
 */
+(NSString *)calculateIntervalTimeByStartTime:(NSString *)StartTime andEndTime:(NSString *)EndTime;

/**
 将本地日期字符串转为UTC日期字符串
 */
+(NSString *)getUTCFormateLocalDate:(NSString *)localDate;
/**
 将UTC日期字符串转为本地时间字符串
 */
+(NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate;

+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate;
@end
