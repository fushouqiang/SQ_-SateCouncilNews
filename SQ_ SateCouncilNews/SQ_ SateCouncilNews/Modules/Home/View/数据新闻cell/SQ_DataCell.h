//
//  SQ_DataCell.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/25.
//  Copyright © 2016年 fu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQ_Article.h"

@protocol dataNewsDelegate <NSObject>

- (void)dataNewsWithData:(SQ_Article *)article;

@end
@interface SQ_DataCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, weak) id<dataNewsDelegate>delegate;

@end
