//
//  SQ_headNewsView.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/25.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_headNewsView.h"
#import "NSObject+YYModel.h"
#import "UIImageView+WebCache.h"

@interface SQ_headNewsView ()
@property (nonatomic, strong) UIImageView *newsImageView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *signImageView;
@end
@implementation SQ_headNewsView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.newsImageView = [[UIImageView alloc] init];
        [self addSubview:_newsImageView];
        [_newsImageView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.left).offset(10);
            make.right.equalTo(self.right).offset(-10);
            make.top.equalTo(self.top).offset(-10);
            make.bottom.equalTo(self.bottom).offset(-80);
            
        }];

        
        self.contentLabel = [[UILabel alloc] init];
        [self addSubview:_contentLabel];
        [_contentLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.left).offset(10);
            make.right.equalTo(self.right).offset(-10);
            make.top.equalTo(_newsImageView.bottom).offset(5);
            make.bottom.equalTo(self.bottom).offset(-20);
            
        }];
        _contentLabel.backgroundColor = [UIColor whiteColor];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.numberOfLines = 2;
        _contentLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
        
        self.timeLabel = [[UILabel alloc] init];
        [self addSubview:_timeLabel];
        [_timeLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentLabel.bottom);
            make.left.equalTo(self.left).offset(10);
            make.width.equalTo(WIDTH / 4);
            make.height.equalTo(20);
            
        }];
        _timeLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        _timeLabel.textColor = [UIColor colorWithWhite:0.665 alpha:1.000];

    }
    return self;
}

- (void)setArticle:(SQ_Article *)article {
    
    if (_article != article) {
        _article = article;
        
        NSString *urlSource = [[article.thumbnails valueForKey:@"2"] valueForKey:@"file"];
        NSString *urlString = [NSString stringWithFormat:@"http://app.www.gov.cn/govdata/gov/%@",urlSource];
        NSURL *imageUrl = [NSURL URLWithString:urlString];
        [_newsImageView sd_setImageWithURL:imageUrl placeholderImage:nil];
        _contentLabel.text = article.title;
        _timeLabel.text = [article.path substringToIndex:9];
        
    }
    
}
@end
