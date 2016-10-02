//
//  SQ_DepHallController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/1.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_DepHallController.h"
#import "SQ_EnterDepController.h"
#import "SQ_AffairsHallViewController.h"
#import "SQ_AffairsShowController.h"

@interface SQ_DepHallController ()
<
UIScrollViewDelegate
>
@property (nonatomic, retain)UIScrollView *contentScrollView;
@property (nonatomic, strong) UILabel *enterLabel;
@property (nonatomic, strong) UILabel *showLabel;


@end

@implementation SQ_DepHallController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.865 alpha:1.000];
    [self setUpHead];
    [self setupContentScrollView];
    [self setChildViewController];
    
     
     
     
}

- (void)setupContentScrollView {
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 110, WIDTH, self.view.bounds.size.height - 110)];
    [self.view addSubview:_contentScrollView];
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.delegate = self;
    self.contentScrollView.bounces = NO;
    _contentScrollView.backgroundColor = [UIColor colorWithRed:0.544 green:0.843 blue:1.000 alpha:1.000];
    _contentScrollView.contentSize = CGSizeMake(WIDTH * 2, 0);
    _contentScrollView.showsHorizontalScrollIndicator = NO;
}


- (void)setUpHead {
    CGFloat headHeight = 40;
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, headHeight)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    
    
    //入驻部门label
    self.enterLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH / 2, 40)];
    [headView addSubview:_enterLabel];
    [_enterLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headTapAction:)]];
    _enterLabel.text = @"入驻部门";
    _enterLabel.textAlignment = NSTextAlignmentCenter;
    _enterLabel.font = [UIFont systemFontOfSize:14];
    _enterLabel.textColor = [UIColor colorWithWhite:0.555 alpha:1.000];;
    
    //政务联播
    self.showLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH / 2, 0, WIDTH/ 2, 40)];
    [headView addSubview:_showLabel];
    [_showLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headTapAction:)]];
    _showLabel.text = @"政务联播";
    _showLabel.textAlignment = NSTextAlignmentCenter;
    _showLabel.font = [UIFont systemFontOfSize:14];
    _showLabel.textColor = [UIColor colorWithWhite:0.555 alpha:1.000];

}


- (void)setChildViewController {
    
    SQ_EnterDepController *edVC = [[SQ_EnterDepController alloc] init];
    [self addChildViewController:edVC];
    edVC.view.frame = CGRectMake(0, -66, WIDTH,  self.contentScrollView.superview.frame.size.height);
    [self.contentScrollView addSubview:edVC.view];
    SQ_AffairsShowController *asVC = [[SQ_AffairsShowController alloc] init];
    [self addChildViewController:asVC];
     asVC.view.frame = CGRectMake(WIDTH, -66, WIDTH,  self.contentScrollView.superview.frame.size.height);
    [self.contentScrollView addSubview:asVC.view];
}

- (void)headTapAction:(UITapGestureRecognizer *)tap {
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
