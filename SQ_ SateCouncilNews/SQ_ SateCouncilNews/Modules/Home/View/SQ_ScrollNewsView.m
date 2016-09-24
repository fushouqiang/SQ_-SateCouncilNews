//
//  SQ_ScrollNewsView.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/24.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_ScrollNewsView.h"
#define MAS_SHORTHAND_GLOBALS
#define MAS_SHORTHAND

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#import "Masonry.h"
#import "SQ_Article.h"
#import "SQ_News.h"
#import "NSObject+YYModel.h"
@interface SQ_ScrollNewsView ()

@property (nonatomic, strong) UIScrollView *newsScrollView;
@property (nonatomic, strong) UILabel *newsTextLabel;
@property (nonatomic, copy) NSString *newsText;
@property (nonatomic, strong)NSMutableArray *articleArray;
@property (nonatomic, strong) SQ_Article *touchArticle;

@end
@implementation SQ_ScrollNewsView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
     
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(timerChanged:) userInfo:nil repeats:YES];
        
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        
    }
    return self;
}

- (void)getBlockArticle:(MyBlock)block {
 
    block(self.touchArticle);
}


- (void)timerChanged:(NSTimer *)timer {
    
    [_newsScrollView setContentOffset:CGPointMake(8 + _newsScrollView.contentOffset.x, 0) animated:YES];
    if (_newsScrollView.contentOffset.x > WIDTH *4) {
        
        [_newsScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
    
}

- (void)createUI{
    
    
    UIView *leftView = [[UIView alloc] init];
    [self addSubview:leftView];
    [leftView makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(WIDTH / 5);
        make.height.equalTo(20);
        make.top.equalTo(self.top);
        make.left.equalTo(self.left);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [leftView addSubview:imageView];
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftView.top).offset(3);
        make.left.equalTo(leftView.left).offset(3);
        make.width.equalTo(WIDTH / 20);
        make.height.equalTo(14);
    }];
    imageView.image = [UIImage imageNamed:@"newsRollIcon"];
    UILabel *leftLabel = [[UILabel alloc] init];
    [leftView addSubview:leftLabel];
    [leftLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.right).offset(2);
        make.top.equalTo(leftView.top).offset(3);
        make.width.equalTo(WIDTH / 10);
        make.height.equalTo(14);
    }];
    leftLabel.text = @"滚动:";
    leftLabel.font = [UIFont systemFontOfSize:12];

    
    self.newsScrollView = [[UIScrollView alloc] init];
    [self addSubview:_newsScrollView];
    [_newsScrollView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.top);
        make.left.equalTo(leftView.right).offset(5);
        make.right.equalTo(self.right);
        make.height.equalTo(20);
    }];
    [_newsScrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    _newsScrollView.contentSize = CGSizeMake(WIDTH * 6, 0);


    
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    
    UIScrollView *scrollView = (UIScrollView *)tap.view;
    NSInteger index = (scrollView.contentOffset.x / WIDTH);

    self.touchArticle =_articleArray[index];

    
}



- (void)setDataDic:(NSDictionary *)dataDic {
    if (_dataDic != dataDic) {
        
        _dataDic = dataDic;
        self.newsText = [[NSString alloc] init];
        self.articleArray = [NSMutableArray array];
        NSArray *keyArray = [dataDic allKeys];
        [self createUI];
        for (int i = 0; i < keyArray.count; i++) {
            
            SQ_News *news = [SQ_News yy_modelWithDictionary:[dataDic valueForKey:keyArray[i]]];
            SQ_Article *article = news.article;
            [_articleArray addObject:article];

            
           UILabel * TextLabel = [[UILabel alloc] init];
            [_newsScrollView addSubview:TextLabel];
            [TextLabel makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(_newsScrollView.left).offset(WIDTH * i);
                make.top.equalTo(_newsScrollView.top).offset(3);
                make.width.equalTo(WIDTH);
                make.height.equalTo(14);
                
            }];
//            TextLabel.backgroundColor = [UIColor redColor];
            TextLabel.text = news.title;
            TextLabel.font = [UIFont systemFontOfSize:12];
            
            
        }
        _newsTextLabel.text = _newsText;
        
        
    }
}


@end
