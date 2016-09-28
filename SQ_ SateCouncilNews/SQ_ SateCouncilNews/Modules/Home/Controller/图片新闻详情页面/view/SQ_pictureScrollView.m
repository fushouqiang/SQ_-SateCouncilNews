//
//  SQ_pictureScrollView.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/28.
//  Copyright © 2016年 fu. All rights reserved.
//


#define MAS_SHORTHAND_GLOBALS
#define MAS_SHORTHAND
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#import "SQ_pictureScrollView.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface SQ_pictureScrollView ()
<
UIScrollViewDelegate
>

@end

@implementation SQ_pictureScrollView



- (instancetype)initWithFrame:(CGRect)frame urlString:(NSString *)urlString {
    
    self = [super initWithFrame:frame];
    if (self) {
    
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
//        [self.imageView makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.left.equalTo(self.left);
//            make.right.equalTo(self.right);
//            make.top.equalTo(self.top).offset(200);
//            make.b.equalTo(self.bottom)
//            
//        }];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.userInteractionEnabled = YES;
        [_imageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:nil options:SDWebImageProgressiveDownload];
        [self addSubview:_imageView];
        
        //设置缩放
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.maximumZoomScale = 2.0;
        self.minimumZoomScale = 1.0;
        
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapOnScrollView)];
        [_imageView addGestureRecognizer:singleTap];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapOnSrollView:)];
        [doubleTap setNumberOfTapsRequired:2];
        [_imageView addGestureRecognizer:doubleTap];
        /**
         比如，单击和双击并存时，如果不做处理，它就只能发送出单击的消息。为了能够识别出双击手势，就需要做一个特殊处理逻辑，即先判断手势是否是双击，在双击失效的情况下作为单击手势处理。使用
         [A requireGestureRecognizerToFail：B]函数，它可以指定当A手势发生时，即便A已经滿足条件了，也不会立刻触发，会等到指定的手势B确定失败之后才触发。
         */
        [_imageView addGestureRecognizer:singleTap];
        [singleTap requireGestureRecognizerToFail:doubleTap];
    
    }
    
    return self;
    
}


- (void)singleTapOnScrollView
{
    if (self.singleTapBlock) {
        self.singleTapBlock();
    }
}

- (void)doubleTapOnSrollView:(UITapGestureRecognizer *)doubleTap {
    
    CGPoint touchPoint = [doubleTap locationInView:self];
    if (self.zoomScale <= 1.0) {
        
        CGFloat scaleX = touchPoint.x + self.contentOffset.x;
        CGFloat scaleY = touchPoint.y + self.contentOffset.y;
        [self zoomToRect:CGRectMake(scaleX, scaleY, 0, 0) animated:YES];
    }
    else {
        [self setZoomScale:1.0 animated:YES];
    }
    
    
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    
    
    
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    CGPoint actualCenter = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,scrollView.contentSize.height * 0.5 + offsetY);
    
    _imageView.center = actualCenter;
    
}

// 放大后切换到下一张时,将原来那张变回原来的大小
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    //模拟双击
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] init];
    //将scrollView添加到手势中
    [recognizer setValue:scrollView forKey:@"view"];
    [self doubleTapOnSrollView:recognizer];
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return _imageView;
}

@end
