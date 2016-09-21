//
//  NSUserDefaultsUtils.h
//  封装
//
//  Created by FuShouqiang on 16/9/20.
//  Copyright © 2016年 fu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaultsUtils : NSObject

/**
 *  创建一个单例
 *
 *  @return 返回 NSUserDefaultsUtils 单例
 */
+ (instancetype)sharedInstance;

/**
 *  是否启动过应用
 */
@property (nonatomic, assign, getter = isEverLaunched) BOOL everLaunched;

/**
 *  是否是第一次启动应用
 */
@property (nonatomic, assign, getter = isFirstLaunched) BOOL firstLaunched;

/**
 *  是否是第一次提示升级
 */
@property (nonatomic, assign, getter = isFirstHintUpdate) BOOL firstHintUpdate;

/**
 *  用户是否评分过
 */
@property (nonatomic, copy) NSString *neverGrade;

@end
