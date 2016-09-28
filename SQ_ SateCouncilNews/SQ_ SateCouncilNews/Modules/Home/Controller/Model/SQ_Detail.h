//
//  SQ_Detail.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/27.
//  Copyright © 2016年 fu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQ_Detail : NSObject


@property (nonatomic, strong) NSNumber *articleId;
@property (nonatomic, strong) NSNumber *contentMode;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *keywords;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) BOOL isAd;
@property (nonatomic, strong) NSDictionary *thumbnails;
@property (nonatomic, strong) NSString *shareUrl;
@property (nonatomic, strong) NSNumber *columnId;
@property (nonatomic, strong) NSNumber *specialId;
@property (nonatomic, strong) NSNumber *updateTime;
@property (nonatomic, strong) NSNumber *publishTime;
@property (nonatomic, strong) NSString *feature;
@property (nonatomic, strong) NSDictionary *relatedArticles;
@property (nonatomic, strong) id medias;


@end
