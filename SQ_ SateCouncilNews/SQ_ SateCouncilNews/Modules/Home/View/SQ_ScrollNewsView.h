//
//  SQ_ScrollNewsView.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/24.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_BaseView.h"
#import "SQ_Article.h"

typedef void (^MyBlock)(SQ_Article *article);


@interface SQ_ScrollNewsView : SQ_BaseView


@property (nonatomic, strong)NSDictionary *dataDic;

- (void)getBlockArticle:(MyBlock)block;

@end
