//
//  SQ_ServiceDetailCell.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/4.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_ServiceDetailCell.h"

#import "SQ_News.h"
#import "SQ_Article.h"
#import "NSObject+YYModel.h"
#import "UIImageView+WebCache.h"
@interface SQ_ServiceDetailCell ()

@property (nonatomic, strong) UILabel *contentLabel;

@end
@implementation SQ_ServiceDetailCell

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

        
    }
    
    return self;
}

- (void)setArticle:(SQ_Article *)article {
    
    if (_article != article) {
        _article = article;
        self.contentLabel.text = article.title;
        
       }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
