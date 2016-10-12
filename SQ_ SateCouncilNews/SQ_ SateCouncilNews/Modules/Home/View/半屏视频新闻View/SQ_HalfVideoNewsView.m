//
//  SQ_HalfVideoNewsView.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/25.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_HalfVideoNewsView.h"
#import "SQ_News.h"
#import "NSObject+YYModel.h"
#import "UIImageView+WebCache.h"


@interface SQ_HalfVideoNewsView ()

@property (nonatomic, strong) UIImageView *newsImageView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *playImageView;

@end
@implementation SQ_HalfVideoNewsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.newsImageView = [[UIImageView alloc] init];
        [self addSubview:_newsImageView];
        [_newsImageView makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.left);
            make.width.equalTo(self.width);
            make.top.equalTo(self.top);
            make.height.equalTo(80);
            
        }];
  
        
        self.contentLabel = [[UILabel alloc] init];
        [self addSubview:_contentLabel];
        [_contentLabel makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.left);
            make.width.equalTo(self.width);
            make.top.equalTo(_newsImageView.bottom);
            make.height.equalTo(40);
        }];
        _contentLabel.numberOfLines = 2;
        _contentLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        
        self.timeLabel = [[UILabel alloc] init];
        [self addSubview:_timeLabel];
        [_timeLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentLabel.bottom).offset(3);
            make.left.equalTo(self.left);
            make.width.equalTo(WIDTH / 4);
            make.bottom.equalTo(self.bottom);
        }];
        _timeLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
        _timeLabel.textColor = [UIColor grayColor];
        
        self.playImageView = [[UIImageView alloc] init];
        [self addSubview:_playImageView];
        [_playImageView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.top).offset(40);
            make.left.equalTo(self.left).offset(5);
            make.width.equalTo(30);
            make.height.equalTo(30);
            
        }];
        _playImageView.image = [UIImage imageNamed:@"videoPlayButton"];
        
        
        
    }
    return self;
}

- (void)setArticle:(SQ_Article *)article {
    
    if (_article != article) {
        _article = article;
        
        
        NSString *urlSource = [[article.thumbnails valueForKey:@"1"] valueForKey:@"file"];
        NSString *urlString = [NSString stringWithFormat:@"http://app.www.gov.cn/govdata/gov/%@",urlSource];
        NSURL *imageUrl = [NSURL URLWithString:urlString];
        [self.newsImageView sd_setImageWithURL:imageUrl];
        self.contentLabel.text = article.title;
        NSString *str = [article.path substringToIndex:9];
        self.timeLabel.text = str;
    }
    
}


@end
