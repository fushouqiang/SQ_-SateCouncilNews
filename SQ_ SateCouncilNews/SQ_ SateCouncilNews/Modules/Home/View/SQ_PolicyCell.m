//
//  SQ_PolicyCell.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/25.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_PolicyCell.h"

#import "SQ_Article.h"
#import "SQ_News.h"
#import "NSObject+YYModel.h"
#define MAS_SHORTHAND_GLOBALS
#define MAS_SHORTHAND

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#import "Masonry.h"
#import "SQ_headNewsView.h"
#import "SQ_EasyNewsView.h"
#import "SQ_HalfNewsView.h"
@interface SQ_PolicyCell ()

@property (nonatomic, retain) NSMutableArray *currentNewsArray;
@property (nonatomic, strong) SQ_headNewsView *newsView1;
@property (nonatomic, strong) SQ_EasyNewsView *newsView2;
@property (nonatomic, strong) SQ_EasyNewsView *newsView3;
@property (nonatomic, strong) SQ_HalfNewsView *newsView4;
@property (nonatomic, strong) SQ_HalfNewsView *newsView5;

@end

@implementation SQ_PolicyCell

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
        
        [self.delegate policyNewsWithData:_newsView1.article];
    }
    else if (tap.view == _newsView2) {
        [self.delegate policyNewsWithData:_newsView2.article];

    }
    else if (tap.view == _newsView3) {
        [self.delegate policyNewsWithData:_newsView3.article];

    }
    else if (tap.view == _newsView4) {
        [self.delegate policyNewsWithData:_newsView4.article];

    }
    else if (tap.view == _newsView4) {
        [self.delegate policyNewsWithData:_newsView5.article];
        
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
    titleLabel.text = @"政策";
    titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    titleLabel.textColor = [UIColor colorWithRed:0.114 green:0.521 blue:1.000 alpha:1.000];
    
    
    
    self.newsView1 = [[SQ_headNewsView alloc] init];
    [self.contentView addSubview:_newsView1];
    [_newsView1 makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.top).offset(40);
        make.left.equalTo(self.contentView.left);
        make.height.equalTo(200);
        make.width.equalTo(self.contentView.width);
        
    }];
    SQ_News *news1 = _currentNewsArray[0];
    _newsView1.article = news1.article;
    [_newsView1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    
    
    
    self.newsView2 = [[SQ_EasyNewsView alloc] init];
    [self.contentView addSubview:_newsView2];
    [_newsView2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_newsView1.bottom);
        make.left.equalTo(self.contentView.left);
        make.height.equalTo(80);
        make.width.equalTo(self.contentView.width);
        
    }];
    SQ_News *news2 = _currentNewsArray[1];
    _newsView2.article = news2.article;
    [_newsView2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    
    
    self.newsView3 = [[SQ_EasyNewsView alloc] init];
    [self.contentView addSubview:_newsView3];
    [_newsView3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_newsView2.bottom);
        make.left.equalTo(self.contentView.left);
        make.height.equalTo(80);
        make.width.equalTo(self.contentView.width);
        
    }];
    SQ_News *news3 = _currentNewsArray[2];
    _newsView3.article = news3.article;
    [_newsView3 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];

    
    
    
    
    self.newsView4 = [[SQ_HalfNewsView alloc] init];
    [self.contentView addSubview:_newsView4];
    [_newsView4 makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_newsView3.bottom).offset(10);
        make.left.equalTo(self.contentView.left).offset(10);
        make.width.equalTo(WIDTH / 2 - 20);
        make.height.equalTo(150);
        
    }];
    SQ_News *news4 = _currentNewsArray[3];
    _newsView4.article = news4.article;
    [_newsView4 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    
    
    
    self.newsView5 = [[SQ_HalfNewsView alloc] init];
    [self.contentView addSubview:_newsView5];
    [_newsView5 makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_newsView3.bottom).offset(10);
        make.left.equalTo(_newsView4.right).offset(10);
        make.width.equalTo(WIDTH / 2 - 20);
        make.height.equalTo(150);
    }];
    SQ_News *news5 = _currentNewsArray[4];
    _newsView5.article = news5.article;
    [_newsView5 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    
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
    NSLog(@"%ld",_currentNewsArray.count);
    
    
    
}

@end
