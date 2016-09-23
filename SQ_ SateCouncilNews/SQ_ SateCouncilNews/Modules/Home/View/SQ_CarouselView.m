//
//  SQ_CarouselView.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/23.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_CarouselView.h"

#define MAS_SHORTHAND_GLOBALS
#define MAS_SHORTHAND

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "SQ_Article.h"
#import "NSObject+YYModel.h"
#import "SDWebImageManager.h"
#import "SQ_News.h"

@interface SQ_CarouselView ()
<
UIScrollViewDelegate

>

@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *currentArray;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIImageView *changeImageView;
@property (nonatomic, strong) UIImageView *changeImageView2;

@end

@implementation SQ_CarouselView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
           self.dataSourceArray = [NSMutableArray array];
        self.imageArray = [NSMutableArray array];

    }
    return self;
}

- (void)createUI {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(WIDTH * 7, self.frame.size.height);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;

    
//    for (int i = 0; i < self.dataSourceArray.count + 1; i++) {
//        
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH * i, 0, WIDTH, _scrollView.frame.size.height)];
//        [self.imageArray addObject:imageView];
//        [_scrollView addSubview:imageView];
//        
//     
//        imageView.backgroundColor = [UIColor redColor];
//        if (i == self.dataSourceArray.count) {
//            imageView.backgroundColor = [UIColor grayColor];
//            
//        }
// 
//    }
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 + 40, self.frame.size.height / 2 + 50, 80, 30)];
    _pageControl.numberOfPages = 5;
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    [_pageControl addTarget:self action:@selector(pageControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_pageControl];
    
    
}

- (void)pageControlValueChanged:(UIPageControl *)pageControl {
    
    
    [_scrollView setContentOffset:CGPointMake(self.frame.size.width * (pageControl.currentPage + 2 ), 0) animated:NO];
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    

    NSInteger i =   scrollView.contentOffset.x / WIDTH;
    
    if (i == 6) {
        [_scrollView setContentOffset:CGPointMake(WIDTH, 0) animated:NO];
        _pageControl.currentPage = 0;
        return;
    }
    if (i == 0) {
        [_scrollView setContentOffset:CGPointMake(WIDTH * 5, 0) animated:NO];
        _pageControl.currentPage = 5;
        return;
    }
    
    _pageControl.currentPage = i - 1;
    
}




- (void)setDataDic:(NSDictionary *)dataDic {
    if (_dataDic != dataDic) {
        _dataDic = dataDic;
         [self createUI];
        NSArray *array = [dataDic allKeys];
        for (int i = 0; i < array.count; i++) {
            
            NSDictionary *dic = [dataDic valueForKey:array[i]];
            SQ_News *news = [SQ_News yy_modelWithDictionary:dic];
            [self.dataSourceArray addObject:news];
            SQ_Article *article = [[SQ_Article alloc] init];
            article = news.article;
            NSString *urlString = [NSString stringWithFormat:@"http://app.www.gov.cn/govdata/gov/%@",[[article.thumbnails valueForKey:@"2"] valueForKey:@"file"]];
            NSLog(@"%@",urlString);
            
            if (i == 0) {
                self.changeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH * 6, 0, WIDTH, _scrollView.frame.size.height)];;
                 [_changeImageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
            }
            
            if (i == (array.count - 1)) {
                self.changeImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, _scrollView.frame.size.height)];;
                [_changeImageView2 sd_setImageWithURL:[NSURL URLWithString:urlString]];
            }
        
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH * (i+1), 0, WIDTH, _scrollView.frame.size.height)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
            [self.imageArray addObject:imageView];
             [_scrollView addSubview:imageView];
            [_scrollView reloadInputViews];
            
         
            

        }
        [self.scrollView addSubview:_changeImageView];
        [self.scrollView addSubview:_changeImageView2];
        NSLog(@"%@",_scrollView);
        _scrollView.contentOffset = CGPointMake(WIDTH, 0);
  
//        NSLog(@"%@",_dataSourceArray);
    }


}
 


@end
