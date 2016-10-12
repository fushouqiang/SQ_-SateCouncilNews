//
//  SQ_MessageShowCell.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/5.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_MessageShowCell.h"
#import "SQ_News.h"
#import "SQ_Article.h"
#import "NSObject+YYModel.h"
#import "UIImageView+WebCache.h"
#import "UILabel+SizeToFit_W_H.h"
@interface SQ_MessageShowCell ()

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *signLabel;
@end
@implementation SQ_MessageShowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_timeLabel];
        [_timeLabel makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(15);
            make.left.equalTo(self.contentView.left).offset(20);
            make.width.equalTo(WIDTH / 4);
            make.bottom.equalTo(self.contentView.bottom).offset(-3);
        }];
        _timeLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        _timeLabel.textColor = [UIColor grayColor];
        
    }
    
    
        self.contentLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_contentLabel];
        [_contentLabel makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView.left).offset(20);
            make.width.equalTo(self.contentView.width).offset(-40);
            make.top.equalTo(self.contentView.top).offset(5);
            make.bottom.equalTo(_timeLabel.top).offset(-10);
        }];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:16];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        
    
    return self;
}

- (void)setArticle:(SQ_Article *)article {
    
    if (_article != article) {
        _article = article;
        NSString *author = [NSString stringWithFormat:@"%@:  ",_article.title];
        
        //将作者的字符串换颜色
        NSMutableAttributedString *contentStr = [[NSMutableAttributedString alloc] initWithString:[author stringByAppendingString:_article.des]];
        
        [contentStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.214 green:0.467 blue:1.000 alpha:1.000] range:NSMakeRange(0,author.length)];
        _contentLabel.attributedText = contentStr;
       
        
        
        //时间的字符串的相关操作
        
        //找出字符串中时间标志的range
        NSRange range = [article.path rangeOfString:@"201"];
        //截取
        NSString *str = [article.path substringWithRange:NSMakeRange(range.location, 9)];
        //插入
        NSMutableString *str2 = [[NSMutableString alloc] initWithString:str];
        [str2 insertString:@"/" atIndex:4];
        
        //        NSString *str = [article.path substringToIndex:9];
        self.timeLabel.text = str2;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
