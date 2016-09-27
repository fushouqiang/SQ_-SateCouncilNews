//
//  SQ_Member.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/27.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_BaseModel.h"

@interface SQ_Member : SQ_BaseModel

@property (nonatomic, copy) NSString *leadText;
@property (nonatomic, copy) NSArray *memberArray;
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, assign) BOOL isShowText;

@end
