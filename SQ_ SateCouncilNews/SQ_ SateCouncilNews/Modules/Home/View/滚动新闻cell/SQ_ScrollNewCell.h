//
//  SQ_ScrollNewCell.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/24.
//  Copyright © 2016年 fu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQ_Article.h"


@interface SQ_ScrollNewCell : UITableViewCell

@property (nonatomic, strong)NSDictionary *dataDic;
@property (nonatomic, strong) void(^block)(SQ_Article* article);
@property (nonatomic, strong) NSTimer *timer;
@end
