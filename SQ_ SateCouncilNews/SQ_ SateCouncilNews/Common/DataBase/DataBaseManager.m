//
//  DataBaseManager.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/20.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "DataBaseManager.h"
#import <sqlite3.h>
#import "SQ_Article.h"
@implementation DataBaseManager {
    sqlite3 *dbPoint;
}

+ (DataBaseManager *)shareManager {
    
    static DataBaseManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[DataBaseManager alloc] init];
    });
    return manager;
    
}

- (BOOL)openSQLite {
    
    if (dbPoint != nil) {
        return YES;
    }
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *articleDBPath = [documentPath stringByAppendingPathComponent:@"article.db"];
    
    NSLog(@"%@",articleDBPath);
    
    int result = sqlite3_open([articleDBPath UTF8String], &dbPoint);
    
    return [self isSuccessWithResult:result alert:@"打开数据库"];
    
}


- (BOOL)closeSQLite {
    
    
    int result = sqlite3_close(dbPoint);
    
    dbPoint = nil;
    
    return  [self isSuccessWithResult:result alert:@"关闭数据库"];
    
}


- (BOOL)createSQLite {
    
    NSString *createTableSQL = @"create table if not exists Article(article_id integer primary key autoincrement,title text not null,date text not null,feature text not null,shareUrl text not null,imageUrl text)";
    
    char *error = NULL;
    
    int result = sqlite3_exec(dbPoint,[createTableSQL UTF8String],NULL,NULL,&error);
    if (error != NULL) {
        
        NSLog(@"error is %s",error);
    }
    
    return [self isSuccessWithResult:result alert:@"创建表"];
    
    
    return 0;
}


- (BOOL)insertIntoWithArticle:(SQ_Article *)article {
    
    NSString *dateString = [article.path substringToIndex:9];
    char *error = NULL;
    
    NSString *insertSQL = [NSString stringWithFormat:@"insert into Article values(null,'%@','%@','%@','%@','%@')",article.title,dateString,article.feature,article.shareUrl,article.saveImageUrl];
    
    int result = sqlite3_exec(dbPoint, [insertSQL UTF8String], NULL, NULL, &error);
    [self logErrorMessage:error];
    
    return [self isSuccessWithResult:result alert:@"插入"];
    
    
}


- (BOOL)deleteWithArticle:(SQ_Article *)article {
    
    char *error = NULL;
    
    
    NSString *deleteSQL = [NSString stringWithFormat:@"delete from Article where title is '%@'",article.title];
    
    int result = sqlite3_exec(dbPoint, [deleteSQL UTF8String], NULL, NULL, &error);
    
    [self logErrorMessage:error];
    
    return [self isSuccessWithResult:result alert:@"删除"];
    
}


- (NSArray *)selectAllArticle {
    
    NSString *selectSQL = @"select * from Article";
    
    sqlite3_stmt *stmt = NULL;
    
    int result = sqlite3_prepare(dbPoint,[selectSQL UTF8String],-1,&stmt,NULL);
    
    NSMutableArray *resultArray = [NSMutableArray array];
    
    if (result == SQLITE_OK) {
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            const unsigned char *name = sqlite3_column_text(stmt, 1);
            const unsigned char *date = sqlite3_column_text(stmt, 2);
            const unsigned char *feature = sqlite3_column_text(stmt, 3);
            const unsigned char *shareUrl = sqlite3_column_text(stmt, 4);
            const unsigned char *imageUrl = sqlite3_column_text(stmt, 5);
            SQ_Article *article = [[SQ_Article alloc] init];
            article.title = [NSString stringWithUTF8String:(const char *)name];
            article.path = [NSString stringWithUTF8String:(const char *)date];
            article.feature = [NSString stringWithUTF8String:(const char *)feature];
            article.shareUrl = [NSString stringWithUTF8String:(const char *)shareUrl];
            article.saveImageUrl = [NSString stringWithUTF8String:(const char *)imageUrl];
            
            
            [resultArray addObject:article];
        }
    }
    sqlite3_finalize(stmt);
    return  resultArray;
    
    
}

//查询是否存在
- (BOOL)selectArticle:(SQ_Article *)article {
    
    NSString *selectSQL = [NSString stringWithFormat:@"select * from Article where title = '%@'",article.title];
    
    
    sqlite3_stmt *stmt = NULL;
    
    int result = sqlite3_prepare(dbPoint,[selectSQL UTF8String],-1,&stmt,NULL);
    
    NSMutableArray *resultArray = [NSMutableArray array];
    
    if (result == SQLITE_OK) {
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            const unsigned char *name = sqlite3_column_text(stmt, 1);
            const unsigned char *date = sqlite3_column_text(stmt, 2);
            const unsigned char *feature = sqlite3_column_text(stmt, 3);
            const unsigned char *shareUrl = sqlite3_column_text(stmt, 4);
            const unsigned char *imageUrl = sqlite3_column_text(stmt, 5);
            SQ_Article *article = [[SQ_Article alloc] init];
            article.title = [NSString stringWithUTF8String:(const char *)name];
            article.path = [NSString stringWithUTF8String:(const char *)date];
            article.feature = [NSString stringWithUTF8String:(const char *)feature];
            article.shareUrl = [NSString stringWithUTF8String:(const char *)shareUrl];
            article.saveImageUrl = [NSString stringWithUTF8String:(const char *)imageUrl];
            
            
            [resultArray addObject:article];
        }
    }
    sqlite3_finalize(stmt);
    
    
    if (resultArray.count > 0) {
        
        return 1;
    }
    
    return 0;
}

//int Result(void* pContext, int nCol, char** azValue, char** azName) {
//
//}


- (void)logErrorMessage:(char *)error {
    
    
    if (error != NULL) {
        NSLog(@"error is %s",error);
    }
}


- (BOOL)isSuccessWithResult:(int)result alert:(NSString *)alertString {
    
    
    if (result == SQLITE_OK) {
        NSLog(@"%@成功",alertString);
        return YES;
    }
    
    NSLog(@"%@失败",alertString);
    
    return NO;
    
    
    
}

@end
