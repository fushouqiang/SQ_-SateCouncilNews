//
//  SQ_departNewsController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/1.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_departNewsController.h"
#import "NewsViewController.h"
#import "SQ_depaChildController.h"

@interface SQ_departNewsController ()
<
UIScrollViewDelegate
>
@property (nonatomic, retain)UIScrollView *headScrollView;
@property (nonatomic, retain)UIScrollView *contentScrollView;
@property (nonatomic, retain)UIButton *lastSelectButton;
@property (nonatomic, strong) NSMutableArray *columsArray;
@property (nonatomic, strong) NSMutableArray *titleButtons;
@end

@implementation SQ_departNewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lastSelectButton = [[UIButton alloc] init];
    self.titleButtons = [NSMutableArray array];
    [self setupHeadScrollView];
    [self setupContentScrollView];
    [self setupAllChildViewController];
    [self setupHeadScrollViewTitle];
    UIButton *button = [self.view viewWithTag:1000];
    [self buttonClick:button];
    //如果有navigation的话 滑动scrollView会偏移 64 所以加上这句话
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}

//创建title的scrollView
- (void)setupHeadScrollView {
    
    CGFloat y = self.navigationController ? 64 : 0;
    CGRect rect = CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, 40);
    
    UIScrollView *titleScrollView = [[UIScrollView alloc] initWithFrame:rect];
    titleScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleScrollView];
    
    self.headScrollView = titleScrollView;
    self.headScrollView.showsVerticalScrollIndicator = NO;
}


- (void)setupAllChildViewController {
    
    
    for (int i = 0; i < _columsArray.count; i++) {
        SQ_depaChildController *newsVC = [[SQ_depaChildController alloc] init];
        newsVC.title = [_columsArray[i] valueForKey:@"name"];
        [self addChildViewController:newsVC];
        newsVC.view.backgroundColor = [UIColor colorWithRed: 0.01* arc4random_uniform(100) green:0.01* arc4random_uniform(100) blue:0.01* arc4random_uniform(100) alpha:1.000];

    }
    
    
    
    
    
    
    
    
    
}




//给 标题视图添加按钮
- (void)setupHeadScrollViewTitle {
    
    NSInteger count = self.columsArray.count;
    
    CGFloat  allLength = 0;
    for (int i = 0; i < count; i++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeSystem];
       
        titleButton.tag = 1000 + i;
        [titleButton setTitleColor:[UIColor colorWithWhite:0.705 alpha:1.000] forState:UIControlStateNormal];
        UIViewController *vc = self.childViewControllers[i];
        [titleButton setTitle:vc.title forState:UIControlStateNormal];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:16];
        //button根据文字宽度设置宽度和位置
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
        CGFloat length = [vc.title boundingRectWithSize:CGSizeMake(320, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
                NSLog(@"%f",allLength);
         titleButton.frame = CGRectMake(allLength + 10, 0, length + 15, 40);
        allLength = titleButton.frame.size.width + titleButton.frame.origin.x;

        [titleButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.headScrollView addSubview:titleButton];
        [self.titleButtons addObject:titleButton];
    }
    self.headScrollView.backgroundColor = [UIColor colorWithRed:0.034 green:0.495 blue:0.703 alpha:1.000];
    self.headScrollView.contentSize = CGSizeMake(allLength, 0);
    
}



- (void)setupOneViewController:(NSInteger)i {
    
    SQ_depaChildController *VC = self.childViewControllers[i];
    if (VC.view.superview) {
        return;
    }
    
    CGFloat x = [UIScreen mainScreen].bounds.size.width * i;
    [self.contentScrollView addSubview:VC.view];
    VC.view.frame = CGRectMake(x, 0, [UIScreen mainScreen].bounds.size.width, self.contentScrollView.superview.frame.size.height);
    
    NSDictionary *dic = @{_icon.path : [_columsArray[i] valueForKey:@"columnId"]};
    VC.dataDic = dic;
}


//创建内容的scrollView
- (void)setupContentScrollView {
    
    CGFloat y = CGRectGetMaxY(self.headScrollView.frame);
    NSLog(@"%f",y);
    UIScrollView *contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, y, self.view.frame.size.width, self.view.bounds.size.height - y)];
    [self.view addSubview:contentScrollView];
    self.contentScrollView = contentScrollView;
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.delegate = self;
    _contentScrollView.bounces = NO;
    _contentScrollView.contentSize = CGSizeMake(WIDTH * _columsArray.count, 0);

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)selectedButton:(UIButton *)button {
    
    [self.lastSelectButton setTitleColor:[UIColor colorWithWhite:0.705 alpha:1.000] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.lastSelectButton = button;
    
    
    
}
- (void)buttonClick:(UIButton *)button {
    
    NSInteger i = button.tag - 1000;
    [self selectedButton:button];
    [self setupOneViewController:i];
    CGFloat x = i * [UIScreen mainScreen].bounds.size.width;
    [self.contentScrollView setContentOffset:CGPointMake(x, 0) animated:YES];
    
}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
    
    NSLog(@"%f",scrollView.contentOffset.y);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger i = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    // 获取标题按钮
    UIButton *titleButton = self.titleButtons[i];
    // 1.选中标题
    [self selectedButton:titleButton];
    
    // 2.把对应子控制器的view添加上去
    [self setupOneViewController:i];
//    long index = titleButton.tag - 1000;

//    [self.headScrollView setContentOffset:CGPointMake(80 * index, 0) animated:YES];

    
    
    
    
    
}


- (void)setIcon:(SQ_icon *)icon {
    
    if (_icon != icon) {
        _icon = icon;
    }
    self.columsArray = [NSMutableArray array];
    NSArray *keyArray = [icon.columns allKeys];
    NSMutableArray *colArray = [NSMutableArray array];
    
    for (int i = 0; i < keyArray.count; i++) {
        
        NSDictionary *dic = [icon.columns valueForKey:keyArray[i]];
        [colArray addObject:dic];
    }
    for (int i = 0; i < keyArray.count; i++) {
        
        for (NSDictionary *dic in colArray) {
            
            if (i == [[dic valueForKey:@"position"] intValue]) {
                [_columsArray addObject:dic];
            }
        }
    }
    
    
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
