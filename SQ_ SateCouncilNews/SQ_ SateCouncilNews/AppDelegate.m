//
//  AppDelegate.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/20.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "AppDelegate.h"
#import "SQ_MainTabBarController.h"
#import "SQ_LeftViewController.h"
#import "MMDrawerController.h"

#define MAS_SHORTHAND_GLOBALS
#define MAS_SHORTHAND



#import "Masonry.h"
#import "DataBaseManager.h"

@interface AppDelegate ()
@property (nonatomic, strong)MMDrawerController *drawerController;
@property (nonatomic, strong)DataBaseManager *manager;

@end

@implementation AppDelegate








- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
      
      
       
       
   
    
    
    SQ_MainTabBarController *mainTabBarController = [[SQ_MainTabBarController alloc] init];
    mainTabBarController.tabBar.translucent = NO;
    
    SQ_LeftViewController *leftViewController = [[SQ_LeftViewController alloc] init];
    UINavigationController *leftNavigationController = [[UINavigationController alloc] initWithRootViewController:leftViewController];
    
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:mainTabBarController leftDrawerViewController:leftNavigationController];
    //4、设置打开/关闭抽屉的手势
    self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.drawerController.closeDrawerGestureModeMask =MMCloseDrawerGestureModeAll;
    //5、设置左右两边抽屉显示的多少
    self.drawerController.maximumLeftDrawerWidth = WIDTH * 0.6;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_window makeKeyAndVisible];
    self.window.rootViewController = self.drawerController;
    self.manager = [DataBaseManager shareManager];
    [_manager openSQLite];
    [_manager createSQLite];
    [_manager closeSQLite];
    
    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
