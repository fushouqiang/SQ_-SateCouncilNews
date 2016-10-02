//
//  XLImagePageView.h
//  XLImagePageDemo
//
//  Created by FuShouqiang on 16/9/20.
//  Copyright © 2016年 fu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XLImagePageView;

@protocol XLImagePageViewDelegate <NSObject>

@optional

- (void)XLImagePageView:(XLImagePageView *)imagePageView didSelectPageAtIndex:(NSInteger)pageIndex;

@end

@interface XLImagePageView : UIView

@property (nonatomic, weak) id<XLImagePageViewDelegate>delegate;
@property (nonatomic, strong) NSArray *imageArray;

@end
