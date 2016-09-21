//
//  UIColor+Categories.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/20.
//  Copyright © 2016年 fu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Categories)

/**
 *  根据十六进制颜色值和透明度返回UICoor
 *
 *  @param hexValue 十六进制的颜色值
 *  @param alpha    透明度
 *
 *  @return 返回相应的UIColor
 */
+(UIColor*)colorWithHexValue:(uint)hexValue andAlpha:(float)alpha;

/**
 *  根据十六进制颜色值字符串和透明度返回UICoor
 *
 *  @param hexString 十六进制颜色值的字符串
 *  @param alpha     透明度
 *
 *  @return 返回相应的UIColor
 */
+(UIColor*)colorWithHexString:(NSString *)hexString andAlpha:(float)alpha;


@end
