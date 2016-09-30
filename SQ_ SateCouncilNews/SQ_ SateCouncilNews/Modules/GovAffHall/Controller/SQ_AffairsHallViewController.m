//
//  SQ_AffairsHallViewController.m
//  SQ_SCNews
//
//  Created by FuShouqiang on 16/9/19.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_AffairsHallViewController.h"
#define MAS_SHORTHAND_GLOBALS
#define MAS_SHORTHAND

#define WIDTH ([UIScreen mainScreen].bounds.size.width )
#define HEIGHT [UIScreen mainScreen].bounds.size.height - 30
#import "Masonry.h"
#import "UIViewController+MMDrawerController.h"
#import "SQ_SearchViewController.h"

@interface SQ_AffairsHallViewController ()
@property (nonatomic, strong) UILabel *backLabel;
@end

@implementation SQ_AffairsHallViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        [self.mm_drawerController setRightDrawerViewController:nil];
    }];
    self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.mm_drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.926 alpha:1.000];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigationSettingButton"] style:UIBarButtonItemStylePlain target:self action:@selector(settingAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithWhite:0.534 alpha:1.000];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 25)];
    imageView.image = [UIImage imageNamed:@"navigationLogo"];
    self.navigationItem.titleView = imageView;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationSearchButton"] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithWhite:0.534 alpha:1.000];

    
    CGFloat width =  (WIDTH - 30) / 3;
    CGFloat width2 =  (WIDTH - 30) / 2;
    UIView *label1 = [[UILabel alloc] init];
    [self.view addSubview:label1];
    [label1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(15);
        make.top.equalTo(self.view.top).offset(150);
        make.width.equalTo(width);
        make.height.equalTo(width * 2);
        
    }];
    label1.backgroundColor = [UIColor colorWithRed:0.261 green:0.465 blue:0.754 alpha:1.000];
//    UIImageView *imageView = [[UIImageView alloc] init];
//    [label1 addSubview:imageView];
//    [imageView makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(label1.top).offset(width * 2 / 3);
//        make.height.equalTo(width / 3);
//        make.centerX.equalTo(label1.centerX);
//        make.width.equalTo(width / 3);
//    }];
//    imageView.image = [UIImage imageNamed:@"hallMinistryIconLoading"];
    
    
    
    UILabel *label2 = [[UILabel alloc] init];
    [self.view addSubview:label2];
    [label2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.right).offset(4);
        make.top.equalTo(self.view.top).offset(150);
        make.width.equalTo(width * 2 - 4);
        make.height.equalTo(width - 2);
        
    }];
    label2.backgroundColor = [UIColor colorWithWhite:0.718 alpha:1.000];

    
    UILabel *label3 = [[UILabel alloc] init];
    [self.view addSubview:label3];
    [label3 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.right).offset(4);
        make.top.equalTo(label2.bottom).offset(4);
        make.width.equalTo(width * 2 - 4);
        make.height.equalTo(width - 2);
        
    }];
    label3.backgroundColor = [UIColor whiteColor];

    
    UILabel *label4 = [[UILabel alloc] init];
    [self.view addSubview:label4];
    [label4 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(15);
        make.top.equalTo(label1.bottom).offset(4);
        make.width.equalTo(width2 - 2);
        make.height.equalTo(width);
        
    }];
    label4.backgroundColor = [UIColor colorWithRed:0.702 green:0.715 blue:0.771 alpha:1.000];

    
    UILabel *label5 = [[UILabel alloc] init];
    [self.view addSubview:label5];
    [label5 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label4.right).offset(4);
        make.top.equalTo(label3.bottom).offset(4);
        make.width.equalTo(width2 - 2);
        make.height.equalTo(width);
        
    }];
    label5.backgroundColor = [UIColor colorWithRed:0.261 green:0.465 blue:0.754 alpha:1.000];

    
    


    
    
    
    
    
    
    
    // Do any additional setup after loading the view.
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
