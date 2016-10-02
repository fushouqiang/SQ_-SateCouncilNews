//
//  UILabel+SizeToFit_W_H.m
//  fsq111
//
//  Created by FuShouqiang on 16/9/26.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "UILabel+SizeToFit_W_H.h"

@implementation UILabel (SizeToFit_W_H)


+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title Font:(UIFont *)font {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}


+ (CGFloat)getWidthWithTitle:(NSString *)title Font:(UIFont *)font {
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}
@end
