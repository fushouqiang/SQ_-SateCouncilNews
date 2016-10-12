//
//  HttpClient.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/20.
//  Copyright © 2016年 fu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
//宏定义成功block 回调成功后得到的信息
typedef void (^HttpSuccess)(id data);
//宏定义失败block 回调失败信息
typedef void (^HttpFailure)(NSError *error);

typedef void(^NetStatusResult)(AFNetworkReachabilityStatus status);


@interface HttpClient : NSObject


+(void)getWithUrlString:(NSString *)urlString success:(HttpSuccess)success failure:(HttpFailure)failure;

+ (void)reachbilityStatus:(NetStatusResult)result;

@end
