//
//  UILabel+SizeToFit_W_H.h
//  fsq111
//
//  Created by FuShouqiang on 16/9/26.
//  Copyright © 2016年 fu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SizeToFit_W_H)

//高度自适应
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title Font :(UIFont*)font;
//宽度自适应
+ (CGFloat)getWidthWithTitle:(NSString *)title Font:(UIFont *)font;

@end
