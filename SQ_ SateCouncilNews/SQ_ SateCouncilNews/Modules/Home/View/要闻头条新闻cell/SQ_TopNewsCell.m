//
//  SQ_TopNewsCell.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/25.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_TopNewsCell.h"
#import "SQ_NormalNewsView.h"
#import "SQ_Article.h"
#import "SQ_News.h"
#import "NSObject+YYModel.h"
#define MAS_SHORTHAND_GLOBALS
#define MAS_SHORTHAND

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#import "Masonry.h"
#import "SQ_HalfNewsView.h"
#import "SQ_EasyNewsView.h"


@interface SQ_TopNewsCell ()

@property (nonatomic, retain)NSMutableArray *currentNewsArray;
@property (nonatomic, strong)SQ_NormalNewsView *newsView1;
@property (nonatomic, strong)SQ_NormalNewsView *newsView2;
@property (nonatomic, strong)SQ_NormalNewsView *newsView3;
@property (nonatomic, strong)SQ_EasyNewsView *newsView4;
@property (nonatomic, strong)SQ_HalfNewsView *newsView5;
@property (nonatomic, strong)SQ_HalfNewsView *newsView6;


@end
@implementation SQ_TopNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        
        
    }
    
    return self;
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    
    
    
    if (tap.view == _newsView1) {
        
        [self.delegate topNewsTouchData:_newsView1.article];
    }
    else if (tap.view == _newsView2) {
        [self.delegate topNewsTouchData:_newsView2.article];
    }
    else if (tap.view == _newsView3) {
        [self.delegate topNewsTouchData:_newsView3.article];
    }
    else if (tap.view == _newsView4) {
        [self.delegate topNewsTouchData:_newsView4.article];
    }
    else if (tap.view == _newsView5) {
        [self.delegate topNewsTouchData:_newsView5.article];
    }
    else if (tap.view == _newsView6) {
        [self.delegate topNewsTouchData:_newsView6.article];
    }
    
}


- (void)createUI {
    
    self.newsView1 = [[SQ_NormalNewsView alloc] init];
    [self.contentView addSubview:_newsView1];
    [_newsView1 makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.top).offset(10);
        make.left.equalTo(self.contentView.left);
        make.width.equalTo(WIDTH);
        make.height.equalTo(90);
        
    }];
    [_newsView1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    SQ_News *news1 = _currentNewsArray[0];
    _newsView1.article = news1.article;
    
    self.newsView2 = [[SQ_NormalNewsView alloc] init];
    [self.contentView addSubview:_newsView2];
    [_newsView2 makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_newsView1.bottom).offset(10);
        make.left.equalTo(self.contentView.left);
        make.width.equalTo(WIDTH);
        make.height.equalTo(90);
        
    }];
    [_newsView2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    SQ_News *news2 = _currentNewsArray[1];
    _newsView2.article = news2.article;
    
    self.newsView3 = [[SQ_NormalNewsView alloc] init];
    [self.contentView addSubview:_newsView3];
    [_newsView3 makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_newsView2.bottom).offset(10);
        make.left.equalTo(self.contentView.left);
        make.width.equalTo(WIDTH);
        make.height.equalTo(90);
        
    }];
    [_newsView3 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    SQ_News *news3 = _currentNewsArray[2];
    _newsView3.article = news3.article;
    
    self.newsView4 = [[SQ_EasyNewsView alloc] init];
    [self.contentView addSubview:_newsView4];
    [_newsView4 makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_newsView3.bottom).offset(10);
        make.left.equalTo(self.contentView.left);
        make.width.equalTo(WIDTH);
        make.height.equalTo(70);
    }];
    [_newsView4 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    SQ_News *news4 = _currentNewsArray[3];
    _newsView4.article = news4.article;
    
    self.newsView5 = [[SQ_HalfNewsView alloc] init];
    [self.contentView addSubview:_newsView5];
    [_newsView5 makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_newsView4.bottom).offset(10);
        make.left.equalTo(self.contentView.left).offset(10);
        make.width.equalTo(WIDTH / 2 - 20);
        make.height.equalTo(150);
    }];
    [_newsView5 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    SQ_News *news5 = _currentNewsArray[4];
    _newsView5.article = news5.article;
    
    self.newsView6 = [[SQ_HalfNewsView alloc] init];
    [self.contentView addSubview:_newsView6];
    [_newsView6 makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_newsView4.bottom).offset(10);
        make.left.equalTo(_newsView5.right).offset(10);
        make.width.equalTo(WIDTH / 2 - 20);
        make.height.equalTo(150);
    }];
    [_newsView6 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    SQ_News *news6 = _currentNewsArray[5];
    _newsView6.article = news6.article;
    
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
    
    // Configure the view for the selected state
}

@end
