//
//  NSDate+Categories.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/20.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "NSDate+Categories.h"
#import "NSUserDefaults+Categories.h"

@implementation NSDate (Categories)

/**
 *  获取系统时间(毫秒)
 *
 *  @return
 */
+ (NSString *)getSystemTimeString {
    return [NSString stringWithFormat:@"%lld", [self getSystemTimeInterval]];
}

+ (long long)getSystemTimeInterval {
    long long systemTime = [[NSDate date] timeIntervalSince1970] * 1000;
    return systemTime;
}

/**
 *  获取系统时间,按照指定格式
 *
 *  @param format 格式字符串
 *
 *  @return 指定格式时间字符串
 */
+ (NSString *)getSystemTimeStringWithFormat:(NSString *)format {
    NSString *date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    date = [formatter stringFromDate:[NSDate date]];
    return date;
}

/**
 *  时间戳转日期
 *
 *  @param timeInterval 时间(毫秒)
 *  @param formatString 格式字符串
 *
 *  @return 指定格式时间字符串
 */
+ (NSString *)secondToDate:(long long)timeInterval WithFormat:(NSString *)formatString {
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:timeInterval / 1000];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    return [dateFormat stringFromDate:date];
}

/**
 *  发言时间显示
 *
 *  @param timeInterval 时间戳
 *
 *  1.小于一分钟：刚刚
 *  2.小于一小时：x分钟前
 *  3.超过一小时，小于24小时：x小时前
 *  4.超过1天，小于7天：x天前
 *  5.其余显示：yyyy/MM/dd HH:mm
 *
 *  @return 指定格式字符串
 */
+ (NSString *)intervalSinceNow:(long long)timeInterval {
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970] * 1000;
    NSTimeInterval cha = (currentTime - timeInterval) / 1000;
    
    NSString *timeString = @"";
    
    if (cha / 3600 < 1) {
        if (cha / 60 < 1) {
            timeString = @"刚刚";
        } else {
            timeString = [NSString stringWithFormat:@"%.f分钟前", cha / 60];
        }
    } else if (cha / 3600 > 1 && cha / 86400 < 1) {
        timeString = [NSString stringWithFormat:@"%.f小时前", cha / 3600];
    } else if (cha / 86400 > 1 && cha / 604800 < 1) {
        timeString = [NSString stringWithFormat:@"%.f天前", cha / 86400];
    } else {
        timeString = [self secondToDate:timeInterval WithFormat:@"yyyy/MM/dd HH:mm"];
    }
    return timeString;
}


+ (BOOL)daysBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime {
    NSDate *fromDate;
    NSDate *toDate;

    NSCalendar *calendar = [NSCalendar currentCalendar];

    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDateTime];

    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                               fromDate:fromDate toDate:toDate options:0];
    return [difference day] < 0;
}

+ (NSDate *)ChinaDate {
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    return [date dateByAddingTimeInterval:interval];
}

+ (void)saveLastOpenDate {
    [NSUserDefaults setObject:[self ChinaDate] forKey:@"LastOpenDate"];
    [NSUserDefaults synchronize];
}

+ (NSDate *)lastOpenDate {
    NSDate *date = (NSDate *) [NSUserDefaults objectForKey:@"LastOpenDate"];
    return date ?: [NSDate distantPast];
}

+ (void)saveLastOpenDiagnoseDate {
    [NSUserDefaults setObject:[self ChinaDate] forKey:@"LastOpenDiagnoseDate"];
    [NSUserDefaults synchronize];
}

+ (NSDate *)lastOpenDiagnose {
    NSDate *date = (NSDate *) [NSUserDefaults objectForKey:@"LastOpenDiagnoseDate"];
    return date ?: [NSDate distantPast];
}

@end
