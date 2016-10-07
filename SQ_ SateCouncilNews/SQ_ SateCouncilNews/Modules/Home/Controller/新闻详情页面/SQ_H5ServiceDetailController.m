//
//  SQ_H5ServiceDetailController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/7.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_H5ServiceDetailController.h"

@interface SQ_H5ServiceDetailController ()

@end

@implementation SQ_H5ServiceDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    NSURL *url = [NSURL URLWithString:self.article.shareUrl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
    
    
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
