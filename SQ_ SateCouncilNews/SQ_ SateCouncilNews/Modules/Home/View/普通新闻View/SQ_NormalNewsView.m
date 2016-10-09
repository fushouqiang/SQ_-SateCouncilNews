//
//  SQ_NormalNewsView.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/25.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_NormalNewsView.h"
#import "UIImageView+WebCache.h"
#import "SQ_TopView.h"
#import "SQ_Article.h"
#import "NSObject+YYModel.h"
#import "UILabel+SizeToFit_W_H.h"

@interface SQ_NormalNewsView ()


@property (nonatomic, strong) UIImageView *newsImageView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *signLabel;

@end

@implementation SQ_NormalNewsView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.backgroundColor = [UIColor colorWithWhite:0.850 alpha:1.000];
        self.newsImageView = [[UIImageView alloc] init];
        [self addSubview:_newsImageView];
        [_newsImageView makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.left).offset(10);
            make.width.equalTo(120);
            make.top.equalTo(self.top).offset(10);
            make.bottom.equalTo(self.bottom);
        }];

        
        self.contentLabel = [[UILabel alloc] init];
        [self addSubview:_contentLabel];
        [_contentLabel makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_newsImageView.right).offset(10);
            make.right.equalTo(self.right).offset(-10);
            make.top.equalTo(self.top).offset(10);
            make.bottom.equalTo(self.bottom).offset(-30);
        }];
        _contentLabel.numberOfLines = 2;
        _contentLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        
        self.timeLabel = [[UILabel alloc] init];
        [self addSubview:_timeLabel];
        [_timeLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentLabel.bottom).offset(3);
            make.left.equalTo(_newsImageView.right).offset(10);
            make.width.equalTo(WIDTH / 4);
            make.bottom.equalTo(self.bottom);
        }];
        _timeLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        _timeLabel.textColor = [UIColor grayColor];
        
        
        self.signLabel = [[UILabel alloc] init];
        [self addSubview:_signLabel];
        [_signLabel makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_contentLabel.bottom).offset(8);
            make.left.equalTo(_timeLabel.right).offset(20);
            make.width.equalTo(WIDTH / 12);
            make.height.equalTo(14);
            
            
        }];
        _signLabel.textColor = [UIColor colorWithRed:0.316 green:0.524 blue:0.968 alpha:1.000];
       
       
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
        NSMutableString *str2 = [[NSMutableString alloc] initWithString:str];
        [str2 insertString:@"/" atIndex:4];
        self.timeLabel.text = str2;
        
        if (article.feature) {
        _signLabel.layer.borderColor = [UIColor colorWithRed:0.329 green:0.544 blue:1.000 alpha:1.000].CGColor;
        _signLabel.layer.borderWidth = 1;
        CGFloat signWidth = [UILabel getWidthWithTitle:article.feature Font:[UIFont systemFontOfSize:10]];
            
        [_signLabel updateConstraints:^(MASConstraintMaker *make) {
                
                make.width.equalTo(signWidth + 5);
        }];
        self.signLabel.text = article.feature;
            
            
            if (urlSource == NULL) {
                
                [_newsImageView removeFromSuperview];
                [_contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(self.left).offset(10);
                     make.right.equalTo(self.right).offset(-10);
                }];
                [_timeLabel remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(_contentLabel.bottom).offset(3);
                    make.left.equalTo(self.left).offset(10);
                    make.width.equalTo(WIDTH / 4);
                    make.bottom.equalTo(self.bottom);
                }];

                
            }
        }
       
    }
    
}











@end
