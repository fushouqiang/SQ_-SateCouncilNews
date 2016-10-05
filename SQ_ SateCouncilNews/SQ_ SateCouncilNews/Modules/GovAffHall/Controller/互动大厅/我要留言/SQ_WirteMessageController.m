//
//  SQ_WirteMessageController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/5.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_WirteMessageController.h"

@interface SQ_WirteMessageController ()

@end

@implementation SQ_WirteMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我要留言";
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://login.forum.gov.cn/html/form/suggest_wxzlsjh.html"]]];
    
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
