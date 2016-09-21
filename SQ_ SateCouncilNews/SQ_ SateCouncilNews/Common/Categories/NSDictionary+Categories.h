//
//  NSDictionary+Check.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/20.
//  Copyright © 2016年 fu. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSDictionary (Categories)

/**
 *  非空校验（nil或者元素个数为0）
 *
 *  @return 是否为空
 */
+(BOOL)isEmpty:(NSDictionary *)dict;

@end
