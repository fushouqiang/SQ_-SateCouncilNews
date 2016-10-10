//
//  SQ_pictureScrollView.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/28.
//  Copyright © 2016年 fu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQ_pictureScrollView : UIScrollView


@property (nonatomic, copy) void(^singleTapBlock)();
//因为要保存图片,不得不把imageView写在外面
@property (nonatomic, strong) UIImageView *imageView;

- (instancetype)initWithFrame:(CGRect)frame urlString:(NSString *)urlString;

@end
