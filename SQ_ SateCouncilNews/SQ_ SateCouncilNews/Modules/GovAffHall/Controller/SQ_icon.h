//
//  SQ_icon.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/1.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_BaseModel.h"

@interface SQ_icon : SQ_BaseModel

@property (nonatomic, strong) NSString *ministryId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *position;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSDictionary *columns;
@end
