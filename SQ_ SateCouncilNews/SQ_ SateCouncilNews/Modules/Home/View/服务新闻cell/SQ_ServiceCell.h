//
//  SQ_ServiceCell.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/25.
//  Copyright © 2016年 fu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQ_Article.h"

@protocol serviceNewsDelegate <NSObject>

- (void)serviceNewsWithData:(SQ_Article *)article;

@end

@interface SQ_ServiceCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, weak) id<serviceNewsDelegate>delegate;

@end
