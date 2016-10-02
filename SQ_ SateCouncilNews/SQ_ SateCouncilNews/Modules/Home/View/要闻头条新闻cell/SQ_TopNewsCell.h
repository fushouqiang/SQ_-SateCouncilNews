//
//  SQ_TopNewsCell.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/25.
//  Copyright © 2016年 fu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQ_Article.h"

@protocol topNewsDelegate <NSObject>


- (void)topNewsTouchData:(SQ_Article *)article;

@end


@interface SQ_TopNewsCell : UITableViewCell


@property (nonatomic, strong)NSDictionary *dataDic;

@property (nonatomic, weak)id<topNewsDelegate>delegate;

@end
