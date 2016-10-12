//
//  SQ_Article.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/23.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_BaseModel.h"

@interface SQ_Article : SQ_BaseModel

@property (nonatomic, strong) NSNumber *articleId;
@property (nonatomic, strong) NSNumber *contentMode;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSDictionary *thumbnails;
@property (nonatomic, strong) NSString *shareUrl;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSNumber *columnId;
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id specialId;
@property (nonatomic, strong) NSNumber *updateTime;
@property (nonatomic, strong) NSNumber *publishTime;
@property (nonatomic, strong) id feature;
@property (nonatomic, strong) id categoryId;
@property (nonatomic, strong) id medias;
@property (nonatomic, strong) id pictures;
@property (nonatomic, strong) NSString *des;
@property (nonatomic, strong) NSString *saveImageUrl;
@property (nonatomic, assign) BOOL isPlay;


@end
