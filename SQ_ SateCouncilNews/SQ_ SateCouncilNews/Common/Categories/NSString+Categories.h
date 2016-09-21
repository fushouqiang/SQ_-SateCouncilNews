//
//  NSString+Categories.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/20.
//  Copyright © 2016年 fu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Categories)

/**
 *  计算 MD5 值
 *
 *  @param input
 *
 *  @return
 */
- (NSString *)md5:(NSString *)input;

/**
 *  对 URL 进行编码
 *
 *  @return 编码后的 URL
 */
- (NSString *)urlEncode;


/**
 *  检测字符串是否为空（nil或者空字符串）
 *
 *  @param trim 是否忽略前后空白字符
 *
 *  @return 是否为空
 */

+(BOOL)isEmpty:(NSString *)str trim:(BOOL)trim;


@end
