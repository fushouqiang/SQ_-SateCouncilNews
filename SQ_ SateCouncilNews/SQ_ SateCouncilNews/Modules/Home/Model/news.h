//
//  news.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/22.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_BaseModel.h"
#import "article.h"

@interface news : SQ_BaseModel

@property (nonatomic, retain) NSNumber *recommendId;
@property (nonatomic, retain) NSNumber *recommendType;
@property (nonatomic, retain) NSNumber *recommendTemplate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, assign) BOOL isAd;
@property (nonatomic, retain) NSNumber *position;
@property (nonatomic, retain) NSNumber *createTime;
@property (nonatomic, retain) NSNumber *plate;
@property (nonatomic, retain) article *article;

@end
