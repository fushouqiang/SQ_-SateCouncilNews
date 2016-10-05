//
//  SQ_Column.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/2.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_BaseModel.h"

@interface SQ_Column : SQ_BaseModel
@property (nonatomic, strong) NSNumber *columnId;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSNumber *sourceId;
@property (nonatomic, strong) NSString *des;
@property (nonatomic, strong) NSNumber *subscriptionRequired;
@property (nonatomic, strong) id icons;
@property (nonatomic, strong) NSNumber *iconUpdateTime;
@property (nonatomic, strong) NSNumber *articleUpdateTime;
@property (nonatomic, strong) NSNumber *columnGroup;
@property (nonatomic, strong) NSNumber *columnStyle;
@property (nonatomic, strong) id link;
@property (nonatomic, strong) NSNumber *position;
@property (nonatomic, strong) id categories;
@end
