//
//  SQ_MainTabBarController.m
//  SQ_SCNews
//
//  Created by FuShouqiang on 16/9/19.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_MainTabBarController.h"
#import "SQ_HomeViewController.h"
#import "SQ_SCViewController.h"
#import "SQ_AffairsHallViewController.h"
#import "MMDrawerController.h"
#import "SQ_LeftViewController.h"

@interface SQ_MainTabBarController ()

@property (nonatomic, strong)MMDrawerController * drawerController;

@end

@implementation SQ_MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    SQ_HomeViewController *homeViewController = [[SQ_HomeViewController alloc] init];
    UINavigationController *SQ_homeNavigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    SQ_homeNavigationController.tabBarItem.title = @"首页";
    SQ_homeNavigationController.tabBarItem.image = [UIImage imageNamed:@"tabBarHomeIconSelected@3x"];
    
 
    
    
    SQ_SCViewController *scViewController = [[SQ_SCViewController alloc] init];
    UINavigationController *SQ_scNavigationController = [[UINavigationController alloc] initWithRootViewController:scViewController];
    SQ_scNavigationController.tabBarItem.title = @"国务院";
    SQ_scNavigationController.tabBarItem.image = [UIImage imageNamed:@"tabBarStateIconSelected@3x"];
    
    SQ_AffairsHallViewController *affairsHallViewController = [[SQ_AffairsHallViewController alloc] init];
    
    UINavigationController *SQ_affairsNavigationController = [[UINavigationController alloc] initWithRootViewController:affairsHallViewController];
    SQ_affairsNavigationController.tabBarItem.title = @"政务大厅";
    SQ_affairsNavigationController.tabBarItem.image = [UIImage imageNamed:@"tabBarHallIconSelected@3x"];
    
    self.viewControllers = @[SQ_homeNavigationController,SQ_scNavigationController,SQ_affairsNavigationController];
    
    self.tabBar.backgroundColor = [UIColor colorWithWhite:0.627 alpha:1.000];
    
    
    
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
