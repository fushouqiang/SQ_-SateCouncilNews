//
//  SQ_HomeViewController.m
//  SQ_SCNews
//
//  Created by FuShouqiang on 16/9/20.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_HomeViewController.h"
#import "NewsViewController.h"
#import "PremierViewController.h"
#import "PolicyViewController.h"
#import "DepartmentViewController.h"
#import "LocalityViewController.h"
#import "ServiceViewController.h"
#import "DataViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "PictureViewController.h"
#import "VideoViewController.h"


@interface SQ_HomeViewController ()
<
UIScrollViewDelegate
>

@property (nonatomic, retain)UIScrollView *headScrollView;
@property (nonatomic, retain)UIScrollView *contentScrollView;
@property (nonatomic, retain)UIButton *lastSelectButton;
@property (nonatomic, strong) NSMutableArray *titleButtons;



@end

@implementation SQ_HomeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置打开抽屉模式
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lastSelectButton = [[UIButton alloc] init];
//    self.navigationItem.title = @"国务院";
    self.titleButtons = [NSMutableArray array];
    [self setupHeadScrollView];
    [self setupContentScrollView];
    [self setupAllChildViewController];
    [self setupHeadScrollViewTitle];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigationSettingButton"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBtn)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithWhite:0.534 alpha:1.000];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 25)];
    imageView.image = [UIImage imageNamed:@"navigationLogo"];
    self.navigationItem.titleView = imageView;
  
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationSearchButton"] style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithWhite:0.534 alpha:1.000];
    self.view.backgroundColor = [UIColor whiteColor];
    //默认点击的title
    UIButton *button = [self.view viewWithTag:1000];
    [self buttonClick:button];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view from its nib.
}

-(void)leftBtn{
    //这里的话是通过遍历循环拿到之前在AppDelegate中声明的那个MMDrawerController属性，然后判断是否为打开状态，如果是就关闭，否就是打开(初略解释，里面还有一些条件)
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
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


//创建内容的scrollView
- (void)setupContentScrollView {
    
    CGFloat y = CGRectGetMaxY(self.headScrollView.frame);
    UIScrollView *contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, y, self.view.bounds.size.width, self.view.bounds.size.height - y)];
    [self.view addSubview:contentScrollView];
    self.contentScrollView = contentScrollView;
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.delegate = self;
    self.contentScrollView.bounces = NO;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    
    
}

//创建子controller
- (void)setupAllChildViewController {
    
    NewsViewController *newsVC = [[NewsViewController alloc] init];
    newsVC.title = @"要闻";
    newsVC.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:newsVC];
    PremierViewController *premierVC = [[PremierViewController alloc] init];
    premierVC.title = @"总理";
//    vc2.view.backgroundColor = [UIColor blueColor];
    [self addChildViewController:premierVC];
    PolicyViewController *policyVC = [[PolicyViewController alloc] init];
    policyVC.title = @"政策";
    policyVC.view.backgroundColor = [UIColor yellowColor];
    [self addChildViewController:policyVC];
    DepartmentViewController *departmentVC = [[DepartmentViewController alloc] init];
    departmentVC.title = @"部门";
    departmentVC.view.backgroundColor = [UIColor blackColor];
    [self addChildViewController:departmentVC];
    LocalityViewController *localityVC = [[LocalityViewController alloc] init];
    localityVC.title = @"地方";
    localityVC.view.backgroundColor = [UIColor orangeColor];
    [self addChildViewController:localityVC];
    ServiceViewController *serviceVC = [[ServiceViewController alloc] init];
    serviceVC.title = @"服务";
    serviceVC.view.backgroundColor = [UIColor colorWithRed:0.367 green:0.935 blue:1.000 alpha:1.000];
    [self addChildViewController:serviceVC];
    DataViewController *dataVC = [[DataViewController alloc] init];
    dataVC.title = @"数据";
    dataVC.view.backgroundColor = [UIColor colorWithRed:1.000 green:0.232 blue:0.649 alpha:1.000];
    [self addChildViewController:dataVC];
    
    PictureViewController *picVC = [[PictureViewController alloc] init];
    picVC.view.backgroundColor = [UIColor whiteColor];
    picVC.title = @"图片";
    [self addChildViewController:picVC];
    
    VideoViewController *videoVC = [[VideoViewController alloc] init];
    videoVC.view.backgroundColor = [UIColor whiteColor];
    videoVC.title = @"视频";
    [self addChildViewController:videoVC];
    
    
    
    
    
}

//给 标题视图添加按钮
- (void)setupHeadScrollViewTitle {
    
    NSInteger count = self.childViewControllers.count;
    
    for (int i = 0; i < count; i++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeSystem];
        titleButton.frame = CGRectMake(i * 80, 0, 80, 40);
        titleButton.tag = 1000 + i;
        [titleButton setTitleColor:[UIColor colorWithWhite:0.705 alpha:1.000] forState:UIControlStateNormal];
        UIViewController *vc = self.childViewControllers[i];
        [titleButton setTitle:vc.title forState:UIControlStateNormal];
        titleButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
        [titleButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.headScrollView addSubview:titleButton];
        [self.titleButtons addObject:titleButton];
    }
    
    self.headScrollView.contentSize = CGSizeMake(count * 80, 0);
    self.headScrollView.backgroundColor = [UIColor colorWithRed:0.034 green:0.495 blue:0.703 alpha:1.000];
//    _headScrollView.backgroundColor = [UIColor colorWithWhite:0.952 alpha:1.000];
    self.contentScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * count, 0);
   
}

//标题按钮的点击事件
- (void)buttonClick:(UIButton *)button {
    
    NSInteger i = button.tag - 1000;
    [self selectedButton:button];
    [self setupOneViewController:i];
    CGFloat x = i * [UIScreen mainScreen].bounds.size.width;
    [self.contentScrollView setContentOffset:CGPointMake(x, 0) animated:YES];
    
}


- (void)selectedButton:(UIButton *)button {
    
    [self.lastSelectButton setTitleColor:[UIColor colorWithWhite:0.705 alpha:1.000] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.lastSelectButton = button;
    
    
    
}


- (void)setupOneViewController:(NSInteger)i {
    
    UIViewController *VC = self.childViewControllers[i];
    //如果已经加载了就不设置frame
    if (VC.view.superview) {
        return;
    }
    CGFloat x = [UIScreen mainScreen].bounds.size.width * i;
    VC.view.frame = CGRectMake(x, 0, [UIScreen mainScreen].bounds.size.width, self.contentScrollView.superview.frame.size.height);
    [self.contentScrollView addSubview:VC.view];
    
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger i = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    // 获取标题按钮
    UIButton *titleButton = self.titleButtons[i];
    
    // 1.选中标题
    [self selectedButton:titleButton];
    
    // 2.把对应子控制器的view添加上去
    [self setupOneViewController:i];
    long index = titleButton.tag - 1000;
    
    [self.headScrollView setContentOffset:CGPointMake(80 * index, 0) animated:YES];

    

    
    
    
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
