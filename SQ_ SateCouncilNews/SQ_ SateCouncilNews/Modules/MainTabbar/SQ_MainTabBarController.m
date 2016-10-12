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
#import "HttpClient.h"

@interface SQ_MainTabBarController ()

@property (nonatomic, strong)MMDrawerController * drawerController;

@end

@implementation SQ_MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];

   
    [self InternetJudge];
    [self createUI];
   

    

    
}

- (NSString *)getCurrentLanguage
{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    return currentLanguage;
    
}


- (void)createUI {
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


//网络判断
- (void)InternetJudge {
    
    [HttpClient reachbilityStatus:^(AFNetworkReachabilityStatus status) {
        
        
        if (status == AFNetworkReachabilityStatusNotReachable) {
            
            NSString *titleAC = @"Network is not connected";
            NSString *titleAA = @"Done";
            
            
            if ([[self getCurrentLanguage] isEqualToString:@"zh-Hans-US"]) {
                titleAA = @"确认";
                titleAC = @"网络未连接";
            }
            
            UIAlertController *clearDoneAlertController = [UIAlertController alertControllerWithTitle:titleAC message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:titleAA style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [clearDoneAlertController addAction:action];
            
            
            [self presentViewController:clearDoneAlertController animated:YES completion:nil];
            
        }
        
        
    }];

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
