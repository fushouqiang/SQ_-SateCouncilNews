//
//  SQ_MenuCell.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/26.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_MenuCell.h"
#import "UIButton+Block.h"
#import "SQ_MenuButtonView.h"


static NSString *const cellIdentifier = @"cell";
@interface SQ_MenuCell ()


@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *categoryArray;

@end

@implementation SQ_MenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createArray];
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 220)];
        [self addSubview:_scrollView];
        for (int i = 0; i < 12; i++) {
            
            CGFloat y = 20;
            CGFloat x = 20 + i * WIDTH / 4;
            if (i > 7) {
                y = 110;
                x = 20 + (i - 8) * WIDTH / 4;
            }
            
            SQ_MenuButtonView *View = [[SQ_MenuButtonView alloc] initWithFrame:CGRectMake(x, y, 50, 70)];
            View.image = _imageArray[i];
            View.title = _titleArray[i];
            [self.scrollView addSubview:View];
            View.tag = 1000 + i;
            [View addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
        }
        _scrollView.contentSize = CGSizeMake(WIDTH * 2, 100);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(WIDTH / 2 - 15, 180, 60, 30)];
        pageControl.numberOfPages = 2;
        pageControl.tintColor = [UIColor blackColor];
        [self.contentView addSubview:pageControl];
        
        
        
      
        
    }
    
    return self;
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    
    SQ_MenuButtonView *view = (SQ_MenuButtonView *)tap.view;
    NSString *category = _categoryArray[view.tag - 1000];
    self.block(category);
}


- (void)createArray {
    
    self.imageArray = [NSMutableArray array];
    for (int i =0; i < 12; i++) {
        
        NSString *imageName = [NSString stringWithFormat:@"menu%d",i];
        UIImage *image = [UIImage imageNamed:imageName];
        [self.imageArray addObject:image];
        
    }
    //标题数组
    self.titleArray = @[@"会议",@"活动",@"出访",@"讲话",@"批示",@"致电",@"通话",@"回信",@"文章",@"参加",@"图片",@"视频"];
    
    //各模块Id数组
    self.categoryArray = @[@"10054",@"10055",@"10056",@"10058",@"10178",@"10179",@"10180",@"10181",@"10059",@"10057",@"10060",@"10061"];
    
 

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
