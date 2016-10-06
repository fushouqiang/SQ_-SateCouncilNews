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
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "PictureViewController.h"
#import "VideoViewController.h"
#import "SQ_SearchViewController.h"
#import "HttpClient.h"
#import "SQ_Column.h"
#import "NSObject+YYModel.h"
#import "AudioViewController.h"



@interface SQ_HomeViewController ()
<
UIScrollViewDelegate
>
typedef void (^JsonSuccess)(id json);
@property (nonatomic, retain)UIScrollView *headScrollView;
@property (nonatomic, retain)UIScrollView *contentScrollView;
@property (nonatomic, retain)UIButton *lastSelectButton;
@property (nonatomic, strong) NSMutableArray *titleButtons;
@property (nonatomic, strong) NSMutableArray *columsArray;
@property (nonatomic, assign) NSInteger json;
//因为每个titlebutton的frame是根据字符长度计算的,所以定义数组存放每个titleButton的位置
@property (nonatomic, strong) NSMutableArray *lengthArray;



@end

@implementation SQ_HomeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置打开抽屉模式
 
        [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            [self.mm_drawerController setRightDrawerViewController:nil];
        }];
        self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
        self.mm_drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
        
    
}


- (void)createUI {
    
    self.lastSelectButton = [[UIButton alloc] init];
    self.titleButtons = [NSMutableArray array];
    [self setupHeadScrollView];
    [self setupContentScrollView];
    [self setupAllChildViewController];
    [self setupHeadScrollViewTitle];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigationSettingButton"] style:UIBarButtonItemStylePlain target:self action:@selector(settingAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithWhite:0.534 alpha:1.000];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 25)];
    imageView.image = [UIImage imageNamed:@"navigationLogo"];
    self.navigationItem.titleView = imageView;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationSearchButton"] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithWhite:0.534 alpha:1.000];
    self.view.backgroundColor = [UIColor whiteColor];
    //默认点击的title
    UIButton *button = [self.view viewWithTag:1000];
    [self buttonClick:button];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleData];
       // Do any additional setup after loading the view from its nib.
}


- (void)handleData {
    
    
    self.columsArray = [NSMutableArray array];
    [self getJsonWithUrlString:[NSString stringWithFormat:@"http://app.www.gov.cn/govdata/gov/source.json"] json:^(id json) {
        
        if (json != NULL) {
            
            
            NSArray *array = [[json valueForKey:@"columns"] allKeys];
            
            NSMutableArray *colArray = [NSMutableArray array];
            
            for (int i = 0; i < array.count; i++) {
                
                NSDictionary *dic = [[json valueForKey:@"columns"] valueForKey:array[i]];
                SQ_Column *column = [SQ_Column yy_modelWithDictionary:dic];
                [colArray addObject:column];
            }
            
            for (int i = 0; i < 50; i++) {
                
                
                for (SQ_Column *col in colArray) {
                    
                    
                    if (i == [col.position intValue]) {
                        
                        [_columsArray addObject:col];
                    }
                }
            }
            
            
            

            [self createUI];
            
            
            
        }
        
      
    }];
    
}


//获取json
- (void)getJsonWithUrlString:(NSString *)urlString json:(JsonSuccess)json{
    
    
    
    
    [HttpClient getWithUrlString:urlString success:^(id data) {
        NSString *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        json(dic);
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
    
}

-(void)settingAction {
    //这里的话是通过遍历循环拿到之前在AppDelegate中声明的那个MMDrawerController属性，然后判断是否为打开状态，如果是就关闭，否就是打开(初略解释，里面还有一些条件)
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


- (void)searchAction {
    
    SQ_SearchViewController *searchVC = [[SQ_SearchViewController alloc] init];
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
   
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
   
   
    for (int i = 0; i < _columsArray.count; i++) {
        
        if (0 == i) {
            
            NewsViewController *newsVC = [[NewsViewController alloc] init];
            newsVC.title = @"要闻";
            [self addChildViewController:newsVC];
        }else if(8 == i){
            
            
            PictureViewController *picVC = [[PictureViewController alloc] init];
            picVC.title = [_columsArray[i] valueForKey:@"title"];
            [self addChildViewController:picVC];
            
        }else if(9 == i){
            
            
            VideoViewController *videoVC = [[VideoViewController alloc] init];
            videoVC.title = [_columsArray[i] valueForKey:@"title"];
            [self addChildViewController:videoVC];
            
        }else if(10 == i){
            
            
            AudioViewController *audioVC = [[AudioViewController alloc] init];
            audioVC.title = [_columsArray[i] valueForKey:@"title"];
            [self addChildViewController:audioVC];
        
        } else {
        
       
        
        PremierViewController *VC = [[PremierViewController alloc] init];
        VC.title = [_columsArray[i] valueForKey:@"title"];
        
        [self addChildViewController:VC];
            
        }
        
    }

 
    
    
    
    
}

//给 标题视图添加按钮
- (void)setupHeadScrollViewTitle {
    
    NSInteger count = self.childViewControllers.count;
    self.lengthArray = [NSMutableArray array];
    //   [_lengthArray add]
    CGFloat  allLength = 0;
    for (int i = 0; i < count; i++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeSystem];
        titleButton.frame = CGRectMake(i * 80, 0, 80, 40);
        titleButton.tag = 1000 + i;
        [titleButton setTitleColor:[UIColor colorWithWhite:0.705 alpha:1.000] forState:UIControlStateNormal];
        UIViewController *vc = self.childViewControllers[i];
        [titleButton setTitle:vc.title forState:UIControlStateNormal];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:16];
        //button根据文字宽度设置宽度和位置
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
        CGFloat length = [vc.title boundingRectWithSize:CGSizeMake(320, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
        titleButton.frame = CGRectMake(allLength + 10, 0, length + 15, 40);
        [_lengthArray addObject:[NSValue valueWithCGPoint:titleButton.frame.origin]];
        allLength = titleButton.frame.size.width + titleButton.frame.origin.x;

        [titleButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.headScrollView addSubview:titleButton];
        [self.titleButtons addObject:titleButton];
    }
    
    self.headScrollView.contentSize =CGSizeMake(allLength, 0);;
    self.headScrollView.backgroundColor = [UIColor colorWithRed:0.034 green:0.495 blue:0.703 alpha:1.000];
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
    
    

    
    if (0 == i) {
         NewsViewController *newsVC = self.childViewControllers[i];
        if (newsVC.view.superview) {
            return;
        }
        CGFloat x = [UIScreen mainScreen].bounds.size.width * i;
        newsVC.view.frame = CGRectMake(x, 0, [UIScreen mainScreen].bounds.size.width, self.contentScrollView.superview.frame.size.height);
        [self.contentScrollView addSubview:newsVC.view];
    } else if(8 == i) {
        PictureViewController *picVC = self.childViewControllers[i];
        if (picVC.view.superview) {
            return;
        }
        CGFloat x = [UIScreen mainScreen].bounds.size.width * i;
        picVC.view.frame = CGRectMake(x, 0, [UIScreen mainScreen].bounds.size.width, self.contentScrollView.superview.frame.size.height);
        [self.contentScrollView addSubview:picVC.view];
    } else if(9 == i) {
        VideoViewController *videoVC = self.childViewControllers[i];
        if (videoVC.view.superview) {
            return;
        }
        CGFloat x = [UIScreen mainScreen].bounds.size.width * i;
        videoVC.view.frame = CGRectMake(x, 0, [UIScreen mainScreen].bounds.size.width, self.contentScrollView.superview.frame.size.height);
        [self.contentScrollView addSubview:videoVC.view];
    } else {
    
    
    PremierViewController *VC = self.childViewControllers[i];
    
    //如果已经加载了就不设置frame
    if (VC.view.superview) {
        return;
    }
    CGFloat x = [UIScreen mainScreen].bounds.size.width * i;
    VC.view.frame = CGRectMake(x, 0, [UIScreen mainScreen].bounds.size.width, self.contentScrollView.superview.frame.size.height);
    VC.column = _columsArray[i];
    [self.contentScrollView addSubview:VC.view];
    }
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
    
    NSValue *value = [_lengthArray objectAtIndex:index];
    [self.headScrollView setContentOffset:[value CGPointValue] animated:YES];


    

    
    
    
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
