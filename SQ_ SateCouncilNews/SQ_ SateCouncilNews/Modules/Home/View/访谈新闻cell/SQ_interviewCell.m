//
//  SQ_interviewCell.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/25.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_interviewCell.h"
#import "SQ_News.h"
#import "NSObject+YYModel.h"
#import "SQ_EasyNewsView.h"
#import "SQ_NormalNewsView.h"
@interface SQ_interviewCell ()

@property (nonatomic, retain) NSMutableArray *currentNewsArray;
@property (nonatomic, strong) SQ_NormalNewsView *newsView1;
@property (nonatomic, strong) SQ_EasyNewsView *newsView2;

@end

@implementation SQ_interviewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)tapAction:(UITapGestureRecognizer *)tap {
    if (tap.view == _newsView1) {
        
        [self.delegate interviewNewsWithData:_newsView1.article];
    }
    else if (tap.view == _newsView2) {
        [self.delegate interviewNewsWithData:_newsView2.article];
        
    }
    
    
}

- (void)createUI {
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:titleLabel];
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.left).offset(10);
        make.top.equalTo(self.contentView.top).offset(10);
        make.width.equalTo(60);
        make.height.equalTo(20);
        
    }];
    titleLabel.text = @"访谈";
    titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    titleLabel.textColor = [UIColor colorWithRed:0.114 green:0.521 blue:1.000 alpha:1.000];
    
    
    
    self.newsView1 = [[SQ_NormalNewsView alloc] init];
    [self.contentView addSubview:_newsView1];
    [_newsView1 makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.top).offset(20);
        make.left.equalTo(self.contentView.left);
        make.width.equalTo(WIDTH);
        make.height.equalTo(90);
        
    }];
    [_newsView1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    SQ_News *news1 = _currentNewsArray[0];
    _newsView1.article = news1.article;
    
    
    
    self.newsView2 = [[SQ_EasyNewsView alloc] init];
    [self.contentView addSubview:_newsView2];
    [_newsView2 makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_newsView1.bottom).offset(10);
        make.left.equalTo(self.contentView.left);
        make.width.equalTo(WIDTH);
        make.height.equalTo(70);
    }];
    [_newsView2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    SQ_News *news2 = _currentNewsArray[1];
    _newsView2.article = news2.article;
    
    
}


- (void)setDataDic:(NSDictionary *)dataDic {
    if (_dataDic != dataDic) {
        
        _dataDic = dataDic;
    }
    self.currentNewsArray = [NSMutableArray array];
    NSArray *keyArray = [dataDic allKeys];
    NSMutableArray *newsArray = [NSMutableArray array];
    for (int i = 0; i < keyArray.count; i++) {
        SQ_News *news = [SQ_News yy_modelWithDictionary:[dataDic valueForKey:keyArray[i]]];
        [newsArray addObject:news];
    }
    //将新闻的position排序并加入数组中
    for (int i = 0; i < newsArray.count; i++) {
        for (SQ_News *news in newsArray) {
            if ([news.position intValue] == i) {
                
                [self.currentNewsArray addObject:news];
            }
            
        }
    }
    [self createUI];
    
    
    
    
}

@end
