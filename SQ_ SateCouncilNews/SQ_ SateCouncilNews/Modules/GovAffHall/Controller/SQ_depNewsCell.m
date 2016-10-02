//
//  SQ_depNewsCell.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/2.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_depNewsCell.h"
#import "SQ_News.h"
#import "SQ_Article.h"
#import "NSObject+YYModel.h"
#import "UIImageView+WebCache.h"
@interface SQ_depNewsCell ()

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *signLabel;
@end
@implementation SQ_depNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_contentLabel];
        [_contentLabel makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView.left).offset(20);
            make.width.equalTo(self.contentView.width).offset(-40);
            make.top.equalTo(self.contentView.top).offset(20);
            make.height.equalTo(40);
        }];
        _contentLabel.numberOfLines = 2;
        _contentLabel.font = [UIFont fontWithName:@"Helvetica" size:17];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        
        self.timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_timeLabel];
        [_timeLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentLabel.bottom).offset(3);
            make.left.equalTo(self.contentView.left).offset(20);
            make.width.equalTo(WIDTH / 4);
            make.bottom.equalTo(self.contentView.bottom);
        }];
        _timeLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        _timeLabel.textColor = [UIColor grayColor];
        
    }
    
    return self;
}

- (void)setArticle:(SQ_Article *)article {
    
    if (_article != article) {
        _article = article;
        self.contentLabel.text = article.title;
        
        //找出字符串中时间标志的range
        NSRange range = [article.path rangeOfString:@"201"];
        
        NSString *str = [article.path substringWithRange:NSMakeRange(range.location, 9)];

//        NSString *str = [article.path substringToIndex:9];
        self.timeLabel.text = str;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
