//
//  SQ_HalfNewsView.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/25.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_HalfNewsView.h"


#import "SQ_News.h"
#import "NSObject+YYModel.h"
#import "UIImageView+WebCache.h"


@interface SQ_HalfNewsView ()

@property (nonatomic, strong) UIImageView *newsImageView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *signLabel;

@end
@implementation SQ_HalfNewsView

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
        
        
        self.signLabel = [[UILabel alloc] init];
        [self addSubview:_signLabel];
        [_signLabel makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_contentLabel.bottom).offset(10);
            make.left.equalTo(_timeLabel.right).offset(20);
            make.width.equalTo(WIDTH / 12);
            make.height.equalTo(14);
            
            
        }];
        _signLabel.textColor = [UIColor colorWithRed:0.316 green:0.524 blue:0.968 alpha:1.000];
        _signLabel.layer.borderColor = [UIColor colorWithRed:0.329 green:0.544 blue:1.000 alpha:1.000].CGColor;
        _signLabel.layer.borderWidth = 1;
        _signLabel.font = [UIFont systemFontOfSize:10];
        _signLabel.textAlignment = NSTextAlignmentCenter;

        
        
        
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
        self.signLabel.text = article.feature;
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
