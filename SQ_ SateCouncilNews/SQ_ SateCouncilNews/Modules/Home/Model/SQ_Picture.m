//
//  SQ_Picture.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/27.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_Picture.h"

@implementation SQ_Picture


//因为description是系统关键字  系统自带description方法  所以返回一个 Dic，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{@"des" : @"description"};
}

@end
