//
//  SQ_ScrollNewCell.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/24.
//  Copyright © 2016年 fu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQ_Article.h"

@protocol scrollNewsDelegate <NSObject>


- (void)scrollNewsTouchData:(SQ_Article *)article;

@end

@interface SQ_ScrollNewCell : UITableViewCell

@property (nonatomic, strong)NSDictionary *dataDic;
@property (nonatomic, weak)id<scrollNewsDelegate>delegate;

@end
