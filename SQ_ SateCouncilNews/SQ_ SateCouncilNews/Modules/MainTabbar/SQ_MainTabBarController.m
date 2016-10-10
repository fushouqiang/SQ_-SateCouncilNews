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
#import "SQ_DetailViewController.h"

@interface SQ_MainTabBarController ()

@property (nonatomic, strong)MMDrawerController * drawerController;

@end

@implementation SQ_MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    

    //主页
    SQ_HomeViewController *homeViewController = [[SQ_HomeViewController alloc] init];
    UINavigationController *SQ_homeNavigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    SQ_homeNavigationController.tabBarItem.title = @"首页";
    SQ_homeNavigationController.tabBarItem.image = [UIImage imageNamed:@"tabBarHomeIcon"];
    SQ_homeNavigationController.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBarHomeIconSelected"];
 
    
    //国务院
    SQ_SCViewController *scViewController = [[SQ_SCViewController alloc] init];
    UINavigationController *SQ_scNavigationController = [[UINavigationController alloc] initWithRootViewController:scViewController];
    SQ_scNavigationController.title = @"国务院";
    SQ_scNavigationController.tabBarItem.image = [UIImage imageNamed:@"tabBarStateIcon"];
    SQ_scNavigationController.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBarStateIconSelected"];
    
    //政务大厅
    SQ_AffairsHallViewController *affairsHallViewController = [[SQ_AffairsHallViewController alloc] init];
    UINavigationController *SQ_affairsNavigationController = [[UINavigationController alloc] initWithRootViewController:affairsHallViewController];
    SQ_affairsNavigationController.tabBarItem.title = @"政务大厅";
    SQ_affairsNavigationController.tabBarItem.image = [UIImage imageNamed:@"tabBarHallIcon"];
    SQ_affairsNavigationController.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBarHallIconSelected"];
    
    self.viewControllers = @[SQ_homeNavigationController,SQ_scNavigationController,SQ_affairsNavigationController];
    
    

    
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
