//
//  NSNumber+Extend.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/20.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "NSNumber+Extend.h"

@implementation NSNumber (Extend)

- (double)safeDouble{
    NSNumber *object = [self isKindOfClass:[NSNull class]] ?  __DOUBLE(0.0): self;
    double number = object !=nil ? [object doubleValue] :0;
    return number;
}

- (BOOL)numberIsInt{
    if([self floatValue] == [self intValue]){
        return YES;
    }else{
        return NO;
    }
}

- (BOOL)numberIsFloat{
    return ![self numberIsInt];
}

@end