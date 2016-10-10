//
//  SQ_ScrollNewCell.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/24.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_ScrollNewCell.h"

#import "SQ_DetailViewController.h"
#import "SQ_News.h"
#import "SQ_Article.h"
#import "NSObject+YYModel.h"

@interface SQ_ScrollNewCell ()

//@property (nonatomic, strong) SQ_ScrollNewsView *scrollNewView;
@property (nonatomic, strong) UIScrollView *newsScrollView;
@property (nonatomic, strong) UILabel *newsTextLabel;
@property (nonatomic, copy) NSString *newsText;
@property (nonatomic, strong)NSMutableArray *articleArray;
@property (nonatomic, strong) SQ_Article *touchArticle;
@property (nonatomic, strong) NSArray *keyArray;

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

    }
    
    return self;
}

- (void)createUI{
    
    
    UIView *leftView = [[UIView alloc] init];
    [self.contentView addSubview:leftView];
    [leftView makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(WIDTH / 5);
        make.height.equalTo(20);
        make.top.equalTo(self.contentView.top);
        make.left.equalTo(self.contentView.left);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [leftView addSubview:imageView];
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftView.top).offset(3);
        make.left.equalTo(leftView.left).offset(3);
        make.width.equalTo(WIDTH / 20);
        make.height.equalTo(14);
    }];
    imageView.image = [UIImage imageNamed:@"newsRollIcon"];
    UILabel *leftLabel = [[UILabel alloc] init];
    [leftView addSubview:leftLabel];
    [leftLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.right).offset(2);
        make.top.equalTo(leftView.top).offset(3);
        make.width.equalTo(WIDTH / 10);
        make.height.equalTo(14);
    }];
    leftLabel.text = @"滚动:";
    leftLabel.font = [UIFont systemFontOfSize:12];
    
    
    self.newsScrollView = [[UIScrollView alloc] init];
    _newsScrollView.showsHorizontalScrollIndicator = NO;
    _newsScrollView.scrollEnabled = NO;
    [self addSubview:_newsScrollView];
    [_newsScrollView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.top);
        make.left.equalTo(leftView.right).offset(5);
        make.right.equalTo(self.contentView.right);
        make.height.equalTo(20);
    }];
    [_newsScrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    _newsScrollView.contentSize = CGSizeMake(WIDTH * (_keyArray.count + 1), 0);
    
    
    
}


- (void)timerChanged:(NSTimer *)timer {

 
        [_newsScrollView setContentOffset:CGPointMake(5 + _newsScrollView.contentOffset.x, 0) animated:YES];
        if (_newsScrollView.contentOffset.x > (WIDTH/10 * 9 - 5) *(_keyArray.count)) {
            
            [_newsScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        }


    
    
    
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    
    UIScrollView *scrollView = (UIScrollView *)tap.view;
    NSInteger index = (scrollView.contentOffset.x / (WIDTH /10 * 9 - 5));
    self.block(_articleArray[index]);
    
    
}


- (void)touchIndexOfScrollNewsWithData:(SQ_Article *)data {
    
    SQ_DetailViewController *detailVC = [[SQ_DetailViewController alloc] init];
    detailVC.article = data;
    
}

- (void)timerMake{
    

    
     self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(timerChanged:) userInfo:nil repeats:YES];
     [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
     //NSRunLoopCommonModes，这个模式等效于NSDefaultRunLoopMode和NSEventTrackingRunLoopMode的结合。

    
   
}


- (void)setDataDic:(NSDictionary *)dataDic {
    if (_dataDic != dataDic) {
        
        _dataDic = dataDic;
        self.newsText = [[NSString alloc] init];
        self.articleArray = [NSMutableArray array];
        
        self.keyArray = [dataDic allKeys];
        [self createUI];
        

        [self timerMake];
            
        

        
        UILabel * lastLabel = [[UILabel alloc] init];
        for (int i = 0; i < _keyArray.count; i++) {
        
            SQ_News *news = [SQ_News yy_modelWithDictionary:[dataDic valueForKey:_keyArray[i]]];
            SQ_Article *article = news.article;
            [_articleArray addObject:article];
            
            
            if (i == 0) {
                [_newsScrollView addSubview:lastLabel];
                [lastLabel makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(_newsScrollView.left).offset(WIDTH * _keyArray.count);
                    make.top.equalTo(_newsScrollView.top).offset(3);
                    make.width.equalTo(WIDTH);
                    make.height.equalTo(14);
                    
                }];
                lastLabel.text = news.title;
                lastLabel.font = [UIFont systemFontOfSize:12];
                lastLabel.textAlignment = NSTextAlignmentLeft;

            }
            
            UILabel * TextLabel = [[UILabel alloc] init];
            [_newsScrollView addSubview:TextLabel];
            [TextLabel makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(_newsScrollView.left).offset(WIDTH * i);
                make.top.equalTo(_newsScrollView.top).offset(3);
                make.width.equalTo(WIDTH);
                make.height.equalTo(14);
                
            }];
            //            TextLabel.backgroundColor = [UIColor redColor];
            TextLabel.text = news.title;
            TextLabel.textAlignment = NSTextAlignmentLeft;
            TextLabel.font = [UIFont systemFontOfSize:12];
            
            
        }
        _newsTextLabel.text = _newsText;
        
        
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
