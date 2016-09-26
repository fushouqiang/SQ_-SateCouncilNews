//
//  SQ_SignNormalCell.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/26.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_SignNormalCell.h"

#define MAS_SHORTHAND_GLOBALS
#define MAS_SHORTHAND

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#import "Masonry.h"

#import "UIImageView+WebCache.h"
#import "SQ_TopView.h"
#import "SQ_Article.h"
#import "NSObject+YYModel.h"

@interface SQ_SignNormalCell ()


@property (nonatomic, strong) UIImageView *newsImageView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *signLabel;

@end

@implementation SQ_SignNormalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        self.signLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_signLabel];
        [_signLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.left).offset(10);
            make.top.equalTo(self.contentView.top).offset(10);
            make.width.equalTo(60);
            make.height.equalTo(20);
            
        }];
        _signLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        _signLabel.textColor = [UIColor colorWithRed:0.114 green:0.521 blue:1.000 alpha:1.000];
        
        
        self.newsImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_newsImageView];
        [_newsImageView makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView.left).offset(10);
            make.width.equalTo(120);
            make.top.equalTo(self.contentView.top).offset(40);
            make.bottom.equalTo(self.contentView.bottom);
        }];
        _newsImageView.backgroundColor = [UIColor redColor];
        
        self.contentLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_contentLabel];
        [_contentLabel makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_newsImageView.right).offset(10);
            make.width.equalTo(WIDTH / 2 + 20);
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
            make.bottom.equalTo(self.contentView.bottom);
        }];
        _timeLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        _timeLabel.textColor = [UIColor grayColor];
        
        
        
        
        
        
        
    }
    
    return  self;
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

- (void)setSignName:(NSString *)signName {
    if (_signName != signName) {
        signName = signName;
        _signLabel.text = signName;
    }
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
