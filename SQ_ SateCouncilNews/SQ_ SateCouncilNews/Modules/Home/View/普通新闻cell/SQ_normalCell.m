//
//  SQ_normalCell.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/22.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_normalCell.h"
#import "UIImageView+WebCache.h"
#import "SQ_TopView.h"
#import "SQ_Article.h"
#import "NSObject+YYModel.h"
#import "UILabel+SizeToFit_W_H.h"

@interface SQ_normalCell ()


@property (nonatomic, strong) UIImageView *newsImageView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *signLabel;

@end

@implementation SQ_normalCell

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
        
       //获取图片地址
        NSString *urlSource = [[article.thumbnails valueForKey:@"1"] valueForKey:@"file"];
        NSString *urlString = [NSString stringWithFormat:@"http://app.www.gov.cn/govdata/gov/%@",urlSource];
        NSURL *imageUrl = [NSURL URLWithString:urlString];
        [_newsImageView sd_setImageWithURL:imageUrl placeholderImage:nil options:SDWebImageProgressiveDownload];
        //截取时间
        self.contentLabel.text = article.title;
        NSString *str = [article.path substringToIndex:9];
        NSMutableString *str2 = [[NSMutableString alloc] initWithString:str];
        [str2 insertString:@"/" atIndex:4];
        self.timeLabel.text = str2;
        
        if (article.feature != nil) {
            _signLabel.layer.borderColor = [UIColor colorWithRed:0.329 green:0.544 blue:1.000 alpha:1.000].CGColor;
            _signLabel.layer.borderWidth = 1;
            self.signLabel.text = article.feature;
           CGFloat signWidth = [UILabel getWidthWithTitle:article.feature Font:[UIFont systemFontOfSize:10]];
            
            [_signLabel updateConstraints:^(MASConstraintMaker *make) {
                
                make.width.equalTo(signWidth + 5);
            }];
        }
        if (article.feature == nil) {
            
            [_signLabel removeFromSuperview];
        }

        
        
        if (urlSource == NULL) {
            
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
