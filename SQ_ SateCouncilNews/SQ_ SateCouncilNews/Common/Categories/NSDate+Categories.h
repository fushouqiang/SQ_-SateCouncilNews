//
//  NSDate+Categories.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/20.
//  Copyright © 2016年 fu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Categories)

/**
 *  获取系统时间(毫秒)
 *
 */
+ (NSString *)getSystemTimeString;

/**
 *  获取系统时间,按照指定格式
 *
 *  @param format 格式字符串
 *
 *  @return 指定格式时间字符串
 */

+ (NSString *)getSystemTimeStringWithFormat:(NSString *)format;

/**
 *  时间戳转日期
 *
 *  @param timeInterval 时间(毫秒)
 *  @param formatString 格式字符串
 *
 *  @return 指定格式时间字符串
 */
+ (NSString *)secondToDate:(long long)timeInterval WithFormat:(NSString *)formatString;

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
+ (NSString *)intervalSinceNow:(long long)timeInterval;

/**
 *  计算两个时间戳之间的天数间隔
 *
 *  @param fromDateTime 从哪一天开始算
 *  @param toDateTime   到哪一天
 *
 *  @return 时间戳间隔的天数
 */
+ (BOOL)daysBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime;

/**
 *  保存最后一次打开时间
 */
+ (void)saveLastOpenDate;

/**
 *  当前中国时间
 *
 *  @return 返回中国时间，去除8个小时的时间差
 */
+ (NSDate *)ChinaDate;

/**
 *  最后一次打开时间
 *
 *  @return 返回最后一次打开时间
 */
+ (NSDate *)lastOpenDate;

+ (void)saveLastOpenDiagnoseDate;

+ (NSDate *)lastOpenDiagnose;
@end
