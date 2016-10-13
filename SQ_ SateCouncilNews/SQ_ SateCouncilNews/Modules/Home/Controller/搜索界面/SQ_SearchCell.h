//
//  SQ_SearchCell.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/13.
//  Copyright © 2016年 fu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQ_Article.h"

@interface SQ_SearchCell : UITableViewCell
@property (nonatomic, strong)SQ_Article *article;
@property (nonatomic, strong)NSString *key;
@end
