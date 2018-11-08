//
//  NSDate+SFJDate.m
//  HK_Sensor
//
//  Created by Experimental Computer on 2018/4/9.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "NSDate+SFJDate.h"

@implementation NSDate (SFJDate)

+(NSString *)stringFromDate:(NSDate *)date formatter:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatter;
    return [dateFormatter stringFromDate:date];
}

+(NSDate *)dateFromString:(NSString *)dateString formatter:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatter;
    return [dateFormatter dateFromString:dateString];
}

+(NSString *)DateFromJsonString:(NSString *)unixDateString formatter:(NSString *)formatter{
    
    NSRange range1 = [unixDateString rangeOfString:@"("];//匹配得到的下标
    
    NSRange range2 = [unixDateString rangeOfString:@"+"];//匹配得到的下标
    
    NSRange range3 = NSMakeRange(range1.location +1, range2.location - range1.location - 1 - 3);//截取时间戳（注意，unix时间戳位数不够补0，所以删除最后的0）
    
    NSString *time = [unixDateString substringWithRange:range3];//时间戳
    
    NSTimeInterval timeInterval = [time doubleValue];//秒
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];//日期
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
   
    dateFormatter.dateFormat = formatter;
    
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    return dateString;
    
}

+(NSString *)calculateIntervalTimeByStartTime:(NSString *)StartTime andEndTime:(NSString *)EndTime
{
    //将字符串的时间转化成NSDate
    NSDate *startD = [self dateFromString:StartTime formatter:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *endD = [self dateFromString:EndTime formatter:@"yyyy-MM-dd HH:mm:ss"];
    
    //算两个时间差多少秒
    CGFloat second = [endD timeIntervalSinceDate:startD];
    int days = ((int)second)/(3600*24);
    
    int hours = ((int)second)%(3600*24)/3600;
    
    int minutes = ((int)second)%(3600*24)%3600/60;
    
    int seconds = ((int)second)%(3600*24)%3600%60;
    
    //将秒换算
    
    NSString * timeStr = [NSString stringWithFormat:@"%02d:%02d:%02d:%02d",days,hours,minutes,seconds];
    
    return timeStr;
}


//将本地日期字符串转为UTC日期字符串
//本地日期格式:2013-08-03 12:53:51
//可自行指定输入输出格式
+(NSString *)getUTCFormateLocalDate:(NSString *)localDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:localDate];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    // [dateFormatter release];
    return dateString;
}

//将UTC日期字符串转为本地时间字符串
//输入的UTC日期格式2013-08-03T04:53:51+0000
+(NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    //    [dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss z yyyy"];
    NSLog(@"~~:%@",utcDate);
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    // [dateFormatter release];
    return dateString;
}

+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc]initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}
@end
