//
//  SQ_DetailArticle.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/3.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_BaseModel.h"

@interface SQ_DetailArticle : SQ_BaseModel

@property (nonatomic, strong) NSNumber *articleId;
@property (nonatomic, strong) NSNumber *contentMode;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *des;
@property (nonatomic, strong) id author;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *keywords;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) BOOL  isAd;
@property (nonatomic, strong) id thumbnails;
@property (nonatomic, strong) NSString *shareUrl;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) id position;
@property (nonatomic, strong) NSNumber *specialId;
@property (nonatomic, strong) NSNumber *updateTime;
@property (nonatomic, strong) NSNumber *publishTime;
@property (nonatomic, strong) NSNumber *languageMode;
@property (nonatomic, strong) NSString *feature;
@property (nonatomic, strong) id categoryId;
@property (nonatomic, strong) id pictures;
@property (nonatomic, strong) id medias;
@property (nonatomic, strong) id relatedArticles;



@end
