//
//  SQ_SCorgViewController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/8.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_SCorgViewController.h"
//国务院组织结构Contrller
@interface SQ_SCorgViewController ()

@end

@implementation SQ_SCorgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64)];
    [self.view addSubview:webView];
    NSURL *url = [NSURL URLWithString:@"http://app.www.gov.cn/govdata/html/structure.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    
    
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
