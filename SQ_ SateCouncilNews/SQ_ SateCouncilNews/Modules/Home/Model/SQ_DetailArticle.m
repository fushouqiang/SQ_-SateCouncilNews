//
//  SQ_DetailArticle.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/3.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_DetailArticle.h"

@implementation SQ_DetailArticle

//因为description是系统关键字  系统自带description方法  所以返回一个 Dic，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{@"des" : @"description"};
}

@end
