//
//  SQ_Picture.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/27.
//  Copyright © 2016年 fu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQ_Picture : NSObject

@property (nonatomic, strong) NSNumber *pictureId;
@property (nonatomic, strong) NSNumber *width;
@property (nonatomic, strong) NSNumber *height;
@property (nonatomic, strong) id relatedLocationId;
@property (nonatomic, strong) NSNumber *articleId;
@property (nonatomic, strong) NSNumber *position;
@property (nonatomic, strong) NSString *file;



@end
