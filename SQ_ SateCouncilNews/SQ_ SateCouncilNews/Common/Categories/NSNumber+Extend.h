//
//  NSNumber+Extend.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/20.
//  Copyright © 2016年 fu. All rights reserved.
//
#import <Foundation/Foundation.h>

#undef	__DOUBLE
#define	__DOUBLE( __x )			[NSNumber numberWithDouble:(double)__x]


@interface NSNumber (Extend)

- (double)safeDouble;
- (BOOL)numberIsFloat;
- (BOOL)numberIsInt;

@end
