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
#import "SQ_DetailViewController.h"


@interface SQ_CarouselView ()
<
UIScrollViewDelegate
>

@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;



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

    }
    return self;
}

- (void)createUI {
    //创建scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(WIDTH * 7, self.frame.size.height);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [_scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];

    //创建pageControl
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 + 60, self.frame.size.height / 2 + 75, 50, 30)];
    _pageControl.numberOfPages = 5;
    _pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.551 alpha:1.000];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [_pageControl addTarget:self action:@selector(pageControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_pageControl];
    
    
}


- (void)tap:(UITapGestureRecognizer *)tap {
    
    UIScrollView *scrollView = (UIScrollView *)tap.view;
    
    NSInteger i = scrollView.contentOffset.x / WIDTH;
    //代理传值
    if (self.delegate && [self.delegate respondsToSelector:@selector(touchIndexWithdata:)]) {
        SQ_News *news = _dataSourceArray[i - 1];
        SQ_Article *article = news.article;
        [self.delegate touchIndexWithdata:article];
    }

    
}


//当pageControl变化时
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
        self.dataSourceArray = [NSMutableArray array];
        UIImageView *lastImageView = [[UIImageView alloc] init];
        UIImageView *firstImageView = [[UIImageView alloc] init];

        NSArray *keyArray = [dataDic allKeys];
        NSMutableArray *newsArray = [NSMutableArray array];
        for (int i = 0; i < keyArray.count; i++) {
            SQ_News *news = [SQ_News yy_modelWithDictionary:[dataDic valueForKey:keyArray[i]]];
            [newsArray addObject:news];
        }
        //将新闻的position排序并加入数组中
        for (int i = 0; i < keyArray.count; i++) {
            for (SQ_News *news in newsArray) {
                if ([news.position intValue] == i) {
                    
                    [self.dataSourceArray addObject:news];
                }
                
            }
        }
        
        
        
        for (int i = 0; i < _dataSourceArray.count; i++) {
            
            SQ_News *news = _dataSourceArray[i];
            
            SQ_Article *article = news.article;
            
            

            NSString *urlString = [NSString stringWithFormat:@"http://app.www.gov.cn/govdata/gov/%@",[[article.thumbnails valueForKey:@"1"] valueForKey:@"file"]];
       //伪跳转imageView last
            if (i == 0) {
              lastImageView.frame = CGRectMake(WIDTH * 6, 0, WIDTH, _scrollView.frame.size.height);
                 [lastImageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
                UILabel *introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _scrollView.frame.size.height - 50, WIDTH, 50)];
                introduceLabel.text = news.title;
                introduceLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
                introduceLabel.textColor = [UIColor whiteColor];
                introduceLabel.numberOfLines = 2;
                introduceLabel.textAlignment = NSTextAlignmentLeft;
                introduceLabel.backgroundColor = [UIColor colorWithWhite:0.394 alpha:0.571];
                [lastImageView addSubview:introduceLabel];
            }
            //伪跳转imageView first
            if (i == (_dataSourceArray.count - 1)) {
                firstImageView.frame = CGRectMake(0, 0, WIDTH, _scrollView.frame.size.height);
                [firstImageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
                UILabel *introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _scrollView.frame.size.height - 50, WIDTH, 50)];
                introduceLabel.text = news.title;
                introduceLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
                introduceLabel.textColor = [UIColor whiteColor];
                introduceLabel.numberOfLines = 2;
                introduceLabel.textAlignment = NSTextAlignmentLeft;
                introduceLabel.backgroundColor = [UIColor colorWithWhite:0.394 alpha:0.571];
                [firstImageView addSubview:introduceLabel];

            }
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH * (i+1), 0, WIDTH, _scrollView.frame.size.height)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
            UILabel *introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _scrollView.frame.size.height - 50, WIDTH, 50)];
            introduceLabel.text = news.title;
            introduceLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
            introduceLabel.textColor = [UIColor whiteColor];
            introduceLabel.numberOfLines = 2;
            introduceLabel.textAlignment = NSTextAlignmentLeft;
            introduceLabel.backgroundColor = [UIColor colorWithWhite:0.394 alpha:0.571];
            [imageView addSubview:introduceLabel];
             [_scrollView addSubview:imageView];
        }
        [self.scrollView addSubview:lastImageView];
        [self.scrollView addSubview:firstImageView];
        _scrollView.contentOffset = CGPointMake(WIDTH, 0);
    }


}
 


@end
