//
//  SQ_AudioCell.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/6.
//  Copyright © 2016年 fu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQ_Article.h"
#import <AVFoundation/AVFoundation.h>

@interface SQ_AudioCell : UITableViewCell

@property (nonatomic, strong)SQ_Article *article;
@property (nonatomic, strong) void(^block)(AVPlayerItem *item);
@property (nonatomic, assign) BOOL isPlay;
@end
