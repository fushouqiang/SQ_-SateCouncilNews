//
//  SQ_Classify.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/3.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_BaseModel.h"

@interface SQ_Classify : SQ_BaseModel

@property (nonatomic, strong) NSNumber *categoryId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *columnId;
@property (nonatomic, strong) NSNumber *position;
@property (nonatomic, strong) NSDictionary *categories;
@end
