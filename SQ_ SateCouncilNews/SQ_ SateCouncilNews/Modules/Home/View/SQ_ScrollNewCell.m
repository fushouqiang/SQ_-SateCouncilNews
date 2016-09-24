//
//  SQ_ScrollNewCell.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/24.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_ScrollNewCell.h"
#import "SQ_ScrollNewsView.h"
#import "SQ_DetailViewController.h"

@interface SQ_ScrollNewCell ()

@property (nonatomic, strong) SQ_ScrollNewsView *scrollNewView;

@end
@implementation SQ_ScrollNewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithWhite:0.847 alpha:1.000];
        self.scrollNewView = [[SQ_ScrollNewsView alloc] initWithFrame:self.contentView.bounds];
  
        
        [self.contentView addSubview:_scrollNewView];
        
    }
    
    return self;
}

- (void)touchIndexOfScrollNewsWithData:(SQ_Article *)data {
    
    SQ_DetailViewController *detailVC = [[SQ_DetailViewController alloc] init];
    detailVC.article = data;
    
}

- (void)setDataDic:(NSDictionary *)dataDic {
    if (_dataDic != dataDic) {
        _dataDic = dataDic;
        _scrollNewView.dataDic = _dataDic;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
