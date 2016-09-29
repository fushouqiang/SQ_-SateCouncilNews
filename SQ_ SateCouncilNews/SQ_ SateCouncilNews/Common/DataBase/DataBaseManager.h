//
//  DataBaseManager.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/20.
//  Copyright © 2016年 fu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SQ_Article;
@interface DataBaseManager : NSObject

//单例
+ (DataBaseManager *)shareManager;

- (BOOL)openSQLite;

- (BOOL)closeSQLite;

- (BOOL)createSQLite;

- (BOOL)insertIntoWithArticle:(SQ_Article *)article;

- (NSArray *)selectAllArticle;

- (BOOL)deleteWithArticle:(SQ_Article *)article;

- (BOOL)selectArticle:(SQ_Article *)article;
@end
