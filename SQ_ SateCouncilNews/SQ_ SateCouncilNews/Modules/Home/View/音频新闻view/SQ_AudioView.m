//
//  SQ_AudioView.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/25.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_AudioView.h"
#define MAS_SHORTHAND_GLOBALS
#define MAS_SHORTHAND

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#import "Masonry.h"

#import "UIImageView+WebCache.h"
#import "SQ_TopView.h"
#import "SQ_Article.h"
#import "NSObject+YYModel.h"
@interface SQ_AudioView ()
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *audioButton;

@end
@implementation SQ_AudioView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentLabel = [[UILabel alloc] init];
        [self addSubview:_contentLabel];
        [_contentLabel makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.left).offset(10);
            make.width.equalTo(self.width).offset(-120);
            make.top.equalTo(self.top).offset(10);
            make.height.equalTo(40);
        }];
        _contentLabel.numberOfLines = 2;
        _contentLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        
        self.timeLabel = [[UILabel alloc] init];
        [self addSubview:_timeLabel];
        [_timeLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentLabel.bottom).offset(3);
            make.left.equalTo(self.left).offset(10);
            make.width.equalTo(WIDTH / 4);
            make.bottom.equalTo(self.bottom);
        }];
        _timeLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        _timeLabel.textColor = [UIColor grayColor];
        
        self.audioButton = [[UIButton alloc] init];
        [self addSubview:_audioButton];
        [_audioButton makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.top).offset(20);
            make.left.equalTo(_contentLabel.right).offset(40);
            make.width.equalTo(50);
            make.height.equalTo(50);
            
        }];
        [_audioButton setImage:[UIImage imageNamed:@"audioButton"] forState:UIControlStateNormal];
        
        
        
        
        
    }
    return self;
}

- (void)setArticle:(SQ_Article *)article {
    
    if (_article != article) {
        _article = article;
        self.contentLabel.text = article.title;
        NSString *str = [article.path substringToIndex:9];
        self.timeLabel.text = str;
    }
    
}


@end
