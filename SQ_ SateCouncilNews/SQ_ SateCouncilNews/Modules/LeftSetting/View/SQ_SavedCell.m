//
//  SQ_SavedCell.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/8.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_SavedCell.h"

#import "UIImageView+WebCache.h"
#import "SQ_TopView.h"
#import "SQ_Article.h"
#import "NSObject+YYModel.h"

@interface SQ_SavedCell ()


@property (nonatomic, strong) UIImageView *newsImageView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *signLabel;

@end

@implementation SQ_SavedCell

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
            make.right.equalTo(self.contentView.right).offset(-10);
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
        
        
        
        self.signLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_signLabel];
        [_signLabel makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_contentLabel.bottom).offset(5);
            make.left.equalTo(_timeLabel.right).offset(20);
            make.width.equalTo(WIDTH / 12);
            make.height.equalTo(14);
            
            
        }];
        _signLabel.textColor = [UIColor colorWithRed:0.316 green:0.524 blue:0.968 alpha:1.000];
        _signLabel.font = [UIFont systemFontOfSize:10];
        _signLabel.textAlignment = NSTextAlignmentCenter;
        
        
    }
    
    return  self;
}



- (void)setArticle:(SQ_Article *)article {
    
    if (_article != article) {
        _article = article;
        
        
        
        NSString *urlString = _article.saveImageUrl;
        NSURL *imageUrl = [NSURL URLWithString:urlString];
        [self.newsImageView sd_setImageWithURL:imageUrl];
        self.contentLabel.text = article.title;
        NSString *str = [article.path substringToIndex:9];
        NSMutableString *str2 = [[NSMutableString alloc] initWithString:str];
        [str2 insertString:@"/" atIndex:4];
        self.timeLabel.text = str2;
        if (article.feature != nil) {
            _signLabel.layer.borderColor = [UIColor colorWithRed:0.329 green:0.544 blue:1.000 alpha:1.000].CGColor;
            _signLabel.layer.borderWidth = 1;
            self.signLabel.text = article.feature;
        }
        if ([article.feature isEqual: @"(null)"]) {
            
            [_signLabel removeFromSuperview];
        }
        
        
        if (urlString == nil) {
            
            [_newsImageView removeFromSuperview];
            [_contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self.contentView.left).offset(10);
                make.right.equalTo(self.contentView.right).offset(-10);
                make.top.equalTo(self.contentView.top).offset(20);
                //                make.bottom.equalTo(self.contentView.bottom).offset(-50);
            }];
            
            [_timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self.contentView.left).offset(10);
                make.top.equalTo(_contentLabel.bottom).offset(3);
                
                make.width.equalTo(WIDTH / 4);
                make.bottom.equalTo(self.contentView.bottom).offset(-3);
                
            }];
            
        }
        
        
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
