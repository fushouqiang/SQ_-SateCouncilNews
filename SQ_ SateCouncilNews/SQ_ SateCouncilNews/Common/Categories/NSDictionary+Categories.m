//
//  NSDictionary+Check.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/20.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "NSDictionary+Categories.h"

@implementation NSDictionary (Categories)

+(BOOL)isEmpty:(NSDictionary *)dict{
    if(dict == nil || dict.count == 0)
        return YES;
    return NO;
}

@end
