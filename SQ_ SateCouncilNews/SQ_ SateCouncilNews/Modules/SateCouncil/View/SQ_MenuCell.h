//
//  SQ_MenuCell.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/26.
//  Copyright © 2016年 fu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQ_MenuCell : UITableViewCell


@property (nonatomic, strong) void(^block)(NSString *category);
@end
