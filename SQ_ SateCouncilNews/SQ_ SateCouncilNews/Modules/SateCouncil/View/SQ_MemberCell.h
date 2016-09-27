//
//  SQ_MemberCell.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/26.
//  Copyright © 2016年 fu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQ_Member.h"

@protocol MemberDelegate <NSObject>


- (void)makeHeight:(CGFloat)height;

@end

@interface SQ_MemberCell : UITableViewCell


@property (nonatomic, strong) SQ_Member *member;
@property (nonatomic, copy) void (^showMoreTextBlock)(SQ_MemberCell *currentCell);


@end
