//
//  SQ_datacTopCell.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/5.
//  Copyright © 2016年 fu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQ_datacTopCell : UITableViewCell

@property (nonatomic, copy) void(^block)(NSInteger value);
@end
