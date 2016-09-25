//
//  SQ_AvdioCell.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/25.
//  Copyright © 2016年 fu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQ_Article.h"

@protocol audioNewsDelegate <NSObject>

- (void)audioNewsWithData:(SQ_Article *)article;

@end

@interface SQ_AvdioCell : UITableViewCell

@property (nonatomic, strong)NSDictionary *dataDic;
@property (nonatomic, weak)id<audioNewsDelegate>delegate;

@end
