//
//  SQ_AffairsHallViewController.m
//  SQ_SCNews
//
//  Created by FuShouqiang on 16/9/19.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_AffairsHallViewController.h"

#import "UIViewController+MMDrawerController.h"
#import "SQ_SearchViewController.h"
#import "SQ_DepHallController.h"

@interface SQ_AffairsHallViewController ()

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
    
    
   
    [self setupNavigation];
    [self createUI];
    
   
    

    
    
//departmentHall  serviceHall  interactionHall  dataChina infoPublic

    
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}
//navigaiton配置
- (void)setupNavigation {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigationSettingButton"] style:UIBarButtonItemStylePlain target:self action:@selector(settingAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithWhite:0.534 alpha:1.000];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 25)];
    imageView.image = [UIImage imageNamed:@"navigationLogo"];
    self.navigationItem.titleView = imageView;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationSearchButton"] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithWhite:0.534 alpha:1.000];

}

//创建UI
- (void)createUI {
    

    
    CGFloat width =  (WIDTH - 30) / 3;
    CGFloat width2 =  (WIDTH - 30) / 2;
    
    
    //部门大厅
    UIView *departmentHall  = [[UIView alloc] init];
    [self.view addSubview:departmentHall];
    [departmentHall makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(15);
        make.top.equalTo(self.view.top).offset(150);
        make.width.equalTo(width);
        make.height.equalTo(width * 2);
        
    }];
    departmentHall.tag = 1001;
    [departmentHall addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    
    departmentHall.backgroundColor = [UIColor colorWithRed:0.261 green:0.465 blue:0.754 alpha:1.000];
    UIImageView *depIcon = [[UIImageView alloc] init];
    [departmentHall addSubview:depIcon];
    [depIcon makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(departmentHall.top).offset(width * 2 / 3);
        make.height.equalTo(width / 3);
        make.centerX.equalTo(departmentHall.centerX);
        make.width.equalTo(width / 3);
    }];
    depIcon.image = [UIImage imageNamed:@"hallMinistryIconLoading"];
    
    UILabel *depTitle = [[UILabel alloc] init];
    [departmentHall addSubview:depTitle];
    [depTitle makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(depIcon.bottom).offset(10);
        make.centerX.equalTo(departmentHall.centerX);
        make.height.equalTo(width / 5);
        make.width.equalTo(width - 30);
        
    }];
    depTitle.text = @"部门大厅";
    depTitle.font = [UIFont systemFontOfSize:15];
    depTitle.textColor = [UIColor whiteColor];
    depTitle.textAlignment = NSTextAlignmentCenter;
    
    
    
    
    //服务大厅
    UIView *serviceHall = [[UIView alloc] init];
    [self.view addSubview:serviceHall];
    [serviceHall makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(departmentHall.right).offset(4);
        make.top.equalTo(self.view.top).offset(150);
        make.width.equalTo(width * 2 - 4);
        make.height.equalTo(width - 2);
        
    }];
    serviceHall.tag = 1002;
    [serviceHall addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    serviceHall.backgroundColor = [UIColor colorWithWhite:0.809 alpha:1.000];
    
    UIImageView *serIcon = [[UIImageView alloc] init];
    [serviceHall addSubview:serIcon];
    [serIcon makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(serviceHall.left).offset(width /3);
        make.height.equalTo(width / 3 -5);
        make.centerY.equalTo(serviceHall.centerY);
        make.width.equalTo(width / 3);
    }];
    serIcon.image = [UIImage imageNamed:@"hallServiceIcon"];
    
    UILabel *serTitle = [[UILabel alloc] init];
    [serviceHall addSubview:serTitle];
    [serTitle makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(serIcon.right).offset(width /3 - 10);
        make.height.equalTo(width / 5);
        make.centerY.equalTo(serviceHall.centerY);
        make.width.equalTo(width - 30);
    }];
    serTitle.text = @"服务大厅";
    serTitle.font = [UIFont systemFontOfSize:15];
    serTitle.textColor = [UIColor colorWithRed:0.261 green:0.465 blue:0.754 alpha:1.000];
    
    
    
    
    
    
    
    //互动大厅
    UIView *interactionHall = [[UIView alloc] init];
    [self.view addSubview:interactionHall];
    [interactionHall makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(departmentHall.right).offset(4);
        make.top.equalTo(serviceHall.bottom).offset(4);
        make.width.equalTo(width * 2 - 4);
        make.height.equalTo(width - 2);
        
    }];
    [interactionHall addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    interactionHall.backgroundColor = [UIColor whiteColor];
    interactionHall.tag = 1003;
    
    UIImageView *interIcon = [[UIImageView alloc] init];
    [interactionHall addSubview:interIcon];
    [interIcon makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(interactionHall.left).offset(width /3);
        make.height.equalTo(width / 3 -5);
        make.centerY.equalTo(interactionHall.centerY);
        make.width.equalTo(width / 3);
    }];
    interIcon.image = [UIImage imageNamed:@"hallAskIcon"];
    
    UILabel *interTitle = [[UILabel alloc] init];
    [interactionHall addSubview:interTitle];
    [interTitle makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(interIcon.right).offset(width /3 - 10);
        make.height.equalTo(width / 5);
        make.centerY.equalTo(interactionHall.centerY);
        make.width.equalTo(width - 30);
    }];
    interTitle.text = @"互动大厅";
    interTitle.font = [UIFont systemFontOfSize:15];
    interTitle.textColor = [UIColor colorWithRed:0.261 green:0.465 blue:0.754 alpha:1.000];
    
    
    
    
    
 
    //数据中国
    UIView *dataChina = [[UIView alloc] init];
    [self.view addSubview:dataChina];
    [dataChina makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(15);
        make.top.equalTo(departmentHall.bottom).offset(4);
        make.width.equalTo(width2 - 2);
        make.height.equalTo(width);
        
    }];
    [dataChina addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    dataChina.backgroundColor = [UIColor colorWithWhite:0.809 alpha:1.000];
    dataChina.tag = 1004;
    
    UIImageView *dtcIcon = [[UIImageView alloc] init];
    [dataChina addSubview:dtcIcon];
    [dtcIcon makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(dataChina.top).offset(width/ 5);
        make.height.equalTo(width / 3);
        make.centerX.equalTo(dataChina.centerX);
        make.width.equalTo(width / 3);
    }];
    dtcIcon.image = [UIImage imageNamed:@"hallDataIcon"];
    
    UILabel *dtcTitle = [[UILabel alloc] init];
    [dataChina addSubview:dtcTitle];
    [dtcTitle makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dtcIcon.bottom).offset(10);
        make.centerX.equalTo(dataChina.centerX);
        make.height.equalTo(width / 5);
        make.width.equalTo(width - 30);
        
    }];
    dtcTitle.text = @"数据中国";
    dtcTitle.font = [UIFont systemFontOfSize:15];
    dtcTitle.textColor = [UIColor colorWithRed:0.261 green:0.465 blue:0.754 alpha:1.000];
    dtcTitle.textAlignment = NSTextAlignmentCenter;
    
    
    
    
    
    
    
    
    
    
    
    UIView *infoPublic = [[UIView alloc] init];
    [self.view addSubview:infoPublic];
    [infoPublic makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dataChina.right).offset(4);
        make.top.equalTo(interactionHall.bottom).offset(4);
        make.width.equalTo(width2 - 2);
        make.height.equalTo(width);
        
    }];
    [infoPublic addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    infoPublic.backgroundColor = [UIColor colorWithRed:0.261 green:0.465 blue:0.754 alpha:1.000];
    infoPublic.tag = 1005;
    
    UIImageView *ifpIcon = [[UIImageView alloc] init];
    [infoPublic addSubview:ifpIcon];
    [ifpIcon makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(infoPublic.left).offset(width / 5);
        make.height.equalTo(width / 3);
        make.centerY.equalTo(infoPublic.centerY);
        make.width.equalTo(width / 3);
    }];
    ifpIcon.image = [UIImage imageNamed:@"menu4"];
    
    UILabel *ifpTitle = [[UILabel alloc] init];
    [infoPublic addSubview:ifpTitle];
    [ifpTitle makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ifpIcon.right).offset(width / 6);
        make.centerY.equalTo(infoPublic.centerY);
        make.height.equalTo(width / 5);
        make.width.equalTo(width - 30);
        
    }];
    ifpTitle.text = @"信息公开";
    ifpTitle.font = [UIFont systemFontOfSize:15];
    ifpTitle.textColor = [UIColor whiteColor];
    ifpTitle.textAlignment = NSTextAlignmentCenter;

}


- (void)tapAction:(UITapGestureRecognizer *)tap {
    NSInteger tag = tap.view.tag - 1000;
    
    switch (tag) {
        case 1:
        {
            SQ_DepHallController *dhVC = [[SQ_DepHallController alloc] init];
            dhVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:dhVC animated:YES];
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            
        }
            break;
        case 5:
        {
            
        }
            break;
    }
        
    
    
    
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
