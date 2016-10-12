//
//  SQ_News.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/23.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_BaseModel.h"
#import "SQ_Article.h"

@interface SQ_News : SQ_BaseModel

@property (nonatomic, strong) NSNumber *recommendId;
@property (nonatomic, strong) NSNumber *recommendType;
@property (nonatomic, strong) NSNumber *recommendTemplate;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL isAd;
@property (nonatomic, strong) NSNumber *position;
@property (nonatomic, strong) NSNumber *createTime;
@property (nonatomic, strong) NSNumber *plate;
@property (nonatomic, strong) SQ_Article *article;

@end
