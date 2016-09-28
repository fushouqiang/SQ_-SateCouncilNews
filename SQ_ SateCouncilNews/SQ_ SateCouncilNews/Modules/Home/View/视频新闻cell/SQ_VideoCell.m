//
//  SQ_VideoCell.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/28.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_VideoCell.h"

#define MAS_SHORTHAND_GLOBALS
#define MAS_SHORTHAND

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "SQ_Article.h"
#import "NSObject+YYModel.h"


@interface SQ_VideoCell ()

@property (nonatomic, strong) UIImageView *newsImageView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *signImageView;




@end

@implementation SQ_VideoCell


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
            make.right.equalTo(self.contentView.right).offset(-10);
            make.top.equalTo(self.contentView.top).offset(-10);
            make.bottom.equalTo(self.contentView.bottom).offset(-80);
            
        }];
        
        
        
        self.signImageView   = [[UIImageView alloc] init];
        [_newsImageView addSubview:_signImageView];
        [_signImageView makeConstraints:^(MASConstraintMaker *make) {
                
                    make.left.equalTo(_newsImageView.left).offset(10);
                    make.bottom.equalTo(_newsImageView.bottom).offset(-3);
                    make.width.equalTo(40);
                    make.height.equalTo(40);
            }];
        _signImageView.image = [UIImage imageNamed:@"videoPlayButton"];
        
        
        
        self.contentLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_contentLabel];
        [_contentLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.left).offset(10);
            make.right.equalTo(self.contentView.right).offset(-10);
            make.top.equalTo(_newsImageView.bottom).offset(5);
            make.bottom.equalTo(self.contentView.bottom).offset(-20);
            
        }];
        _contentLabel.backgroundColor = [UIColor whiteColor];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.numberOfLines = 2;
        _contentLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
        
        
        
    }
    
    return self;
}


- (void)setArticle:(SQ_Article *)article {
    
    if (_article != article) {
        _article = article;
        
        NSString *urlSource = [[article.thumbnails valueForKey:@"1"] valueForKey:@"file"];
        NSString *urlString = [NSString stringWithFormat:@"http://app.www.gov.cn/govdata/gov/%@",urlSource];
        NSURL *imageUrl = [NSURL URLWithString:urlString];
        [_newsImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@""]];
        _contentLabel.text = article.title;

        
        
        
        
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
