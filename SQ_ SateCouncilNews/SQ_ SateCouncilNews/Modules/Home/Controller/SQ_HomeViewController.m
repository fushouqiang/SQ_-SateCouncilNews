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
#import "AudioViewController.h"
#import "VideoViewController.h"
#import "SpecialViewController.h"


@interface SQ_HomeViewController ()
<
UIScrollViewDelegate
>

@property (nonatomic, retain)UIScrollView *headScrollView;
@property (nonatomic, retain)UIScrollView *contentScrollView;
@property (nonatomic, retain)UIButton *lastSelectButton;



@end

@implementation SQ_HomeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置打开抽屉模式
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"国务院";
    [self setupHeadScrollView];
    [self setupContentScrollView];
    [self setupAllChildViewController];
    [self setupHeadScrollViewTitle];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBtn)];
    
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
    CGRect rect = CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, 60);
    
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
//    contentScrollView.backgroundColor = [UIColor colorWithRed:0.702 green:1.000 blue:0.545 alpha:1.000];
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
    premierVC.view.backgroundColor = [UIColor blueColor];
    [self addChildViewController:premierVC];
    PolicyViewController *policyVC = [[PolicyViewController alloc] init];
    policyVC.title = @"政策";
    [self addChildViewController:policyVC];
    DepartmentViewController *departmentVC = [[DepartmentViewController alloc] init];
    departmentVC.title = @"部门";
    [self addChildViewController:departmentVC];
    LocalityViewController *localityVC = [[LocalityViewController alloc] init];
    localityVC.title = @"地方";
    [self addChildViewController:localityVC];
    ServiceViewController *serviceVC = [[ServiceViewController alloc] init];
    serviceVC.title = @"服务";
    [self addChildViewController:serviceVC];
    DataViewController *dataVC = [[DataViewController alloc] init];
    dataVC.title = @"数据";
    [self addChildViewController:dataVC];
    SpecialViewController *specialVC = [[SpecialViewController alloc] init];
    specialVC.title = @"专题";
    [self addChildViewController:specialVC];
    PictureViewController *pictureVC = [[PictureViewController alloc] init];
    pictureVC.title = @"图片";
    [self addChildViewController:pictureVC];
    AudioViewController *audioVC = [[AudioViewController alloc] init];
    audioVC.title = @"音频";
    [self addChildViewController:audioVC];
    VideoViewController *videoVC = [[VideoViewController alloc] init];
    videoVC.title = @"视频";
    [self addChildViewController:videoVC];
    
    
    
    
    
}

//给 标题视图添加按钮
- (void)setupHeadScrollViewTitle {
    
    NSInteger count = 11;
    
    for (int i = 0; i < count; i++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeSystem];
        titleButton.frame = CGRectMake(i * 80, 0, 80, 60);
        titleButton.tag = 1000 + i;
        [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        UIViewController *vc = self.childViewControllers[i];
        [titleButton setTitle:vc.title forState:UIControlStateNormal];
        [titleButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.headScrollView addSubview:titleButton];
        
    }
    
    self.headScrollView.contentSize = CGSizeMake(count * 80, 0);
    self.contentScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * count, 0);
    
}

//标题按钮的点击事件
- (void)buttonClick:(UIButton *)button {
    
    NSInteger i = button.tag - 1000;
    [self selectedButton:button];
    [self setupOneViewController:i];
    CGFloat x = i * [UIScreen mainScreen].bounds.size.width;
//    self.contentScrollView.contentOffset = CGPointMake(x, 0);
    [self.contentScrollView setContentOffset:CGPointMake(x, 0) animated:YES];
    
}

- (void)selectedButton:(UIButton *)button {
    
    [self.lastSelectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
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


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([scrollView isEqual:self.contentScrollView]) {
   
//        NSLog(@"%f",scrollView.contentOffset.x);
        
//        if (scrollView.contentOffset.x < 0) {
//             [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
//        }
        
        
    }
    
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
