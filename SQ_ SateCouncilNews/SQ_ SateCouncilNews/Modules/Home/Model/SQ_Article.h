//
//  SQ_Article.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/23.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_BaseModel.h"

@interface SQ_Article : SQ_BaseModel

@property (nonatomic, retain) NSNumber *articleId;
@property (nonatomic, retain) NSNumber *contentMode;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSDictionary *thumbnails;
@property (nonatomic, retain) NSString *shareUrl;
@property (nonatomic, retain) NSString *path;
@property (nonatomic, retain) NSNumber *columnId;
@property (nonatomic, retain) id position;
@property (nonatomic, retain) id specialId;
@property (nonatomic, retain) NSNumber *updateTime;
@property (nonatomic, retain) NSNumber *publishTime;
@property (nonatomic, retain) id feature;
@property (nonatomic, retain) id categoryId;
@property (nonatomic, retain) id medias;

@end
