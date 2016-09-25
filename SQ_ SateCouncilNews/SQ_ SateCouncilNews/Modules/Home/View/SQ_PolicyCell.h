//
//  SQ_PolicyCell.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/25.
//  Copyright © 2016年 fu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQ_Article.h"

@protocol policyNewsDelegate <NSObject>

- (void)policyNewsWithData:(SQ_Article *)article;

@end

@interface SQ_PolicyCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, weak) id<policyNewsDelegate>delegate;
@end
