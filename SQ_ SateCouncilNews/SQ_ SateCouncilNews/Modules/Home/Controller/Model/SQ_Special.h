//
//  SQ_Special.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/25.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_BaseView.h"

@interface SQ_Special : SQ_BaseView

@property (nonatomic, strong) NSNumber  *specialId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icons;
@property (nonatomic, copy) NSNumber *iconUpdateTime;
@property (nonatomic, strong) id columnStyle;
@property (nonatomic, strong) id link;
@end
