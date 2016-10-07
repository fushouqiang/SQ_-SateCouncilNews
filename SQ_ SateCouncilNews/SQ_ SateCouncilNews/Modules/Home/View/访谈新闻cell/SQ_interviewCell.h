//
//  SQ_interviewCell.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/25.
//  Copyright © 2016年 fu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQ_Article.h"

@interface SQ_interviewCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) void(^block)(SQ_Article* article);
@end
