//
//  SQ_AudioCell.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/6.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_AudioCell.h"
#import "UIImageView+WebCache.h"
#import "SQ_TopView.h"
#import "SQ_Article.h"
#import "NSObject+YYModel.h"

@interface SQ_AudioCell ()


@property (nonatomic, strong) UIImageView *newsImageView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, retain) UILabel *timeLabel;

@property (nonatomic, strong) UIButton *audioButton;

@property (nonatomic, strong) __block AVPlayerItem *item;

@end

@implementation SQ_AudioCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.newsImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_newsImageView];
        [_newsImageView makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView.left).offset(10);
            make.width.equalTo(120);
            make.top.equalTo(self.contentView.top).offset(10);
            make.bottom.equalTo(self.contentView.bottom);
        }];
        
        
        
        self.contentLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_contentLabel];
        [_contentLabel makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_newsImageView.right).offset(10);
            make.width.equalTo(WIDTH / 3);
            make.top.equalTo(self.contentView.top).offset(10);
            make.bottom.equalTo(self.contentView.bottom).offset(-30);
        }];
        _contentLabel.numberOfLines = 2;
        _contentLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        
        self.timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_timeLabel];
        [_timeLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentLabel.bottom).offset(3);
            make.left.equalTo(_newsImageView.right).offset(10);
            make.width.equalTo(WIDTH / 4);
            make.bottom.equalTo(self.contentView.bottom).offset(-3);
        }];
        _timeLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        _timeLabel.textColor = [UIColor grayColor];
        
        self.audioButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_audioButton];
        [_audioButton makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.top).offset(15);
            make.left.equalTo(self.contentLabel.right).offset(20);
            make.width.equalTo(40);
            make.height.equalTo(40);
        }];
        [_audioButton setImage:[UIImage imageNamed:@"audioPlayButton"] forState:UIControlStateNormal];
        [_audioButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
//        if (_isUsed == YES) {
//            
//                [_audioButton setImage:[UIImage imageNamed:@"audioButton"] forState:UIControlStateNormal];
//        }
        
        
//        
        self.signLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_signLabel];
        [_signLabel makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_audioButton).offset(5);
            make.right.equalTo(self.contentView.right).offset(-10);
            make.width.equalTo(WIDTH / 4);
            make.height.equalTo(14);
            
            
        }];
        _signLabel.textColor = [UIColor colorWithRed:0.316 green:0.524 blue:0.968 alpha:1.000];
        _signLabel.font = [UIFont systemFontOfSize:10];
        _signLabel.textAlignment = NSTextAlignmentCenter;
        
        
    }
    
    return  self;
}


- (void)playButtonAction:(UIButton *)button {
    
    _isPlay = !_isPlay;
    
    
    NSArray *array = [_article.medias allKeys];
    NSDictionary *dic = [_article.medias valueForKey:array[0]];
    NSString *audioUrlString = [NSString stringWithFormat:@"http://appvideo.www.gov.cn/gov/%@",[dic valueForKey:@"file"]];
    NSURL * url  = [NSURL URLWithString:audioUrlString];
    self.item = [[AVPlayerItem alloc]initWithURL:url];
    if (_isPlay == YES) {
        
        [_audioButton setImage:[UIImage imageNamed:@"audioPauseButton"] forState:UIControlStateNormal];
       
        if (_block) {
            
//            self.block(_item);
        }
        
        
    } else if (_isPlay == NO){
       
        [_audioButton setImage:[UIImage imageNamed:@"audioPlayButton"] forState:UIControlStateNormal];
    }
    
     self.block(_item);
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
            self.signLabel.text = article.feature;
        }
        
      
        
        
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end