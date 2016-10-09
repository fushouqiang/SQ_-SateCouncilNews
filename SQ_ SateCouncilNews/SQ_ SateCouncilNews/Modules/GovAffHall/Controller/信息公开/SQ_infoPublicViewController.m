//
//  SQ_infoPublicViewController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/4.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_infoPublicViewController.h"
#import "MBProgressHUD.h"
@interface SQ_infoPublicViewController ()
<
UIWebViewDelegate,
MBProgressHUDDelegate
>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) MBProgressHUD *hud;
@end

@implementation SQ_infoPublicViewController


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    _hud.delegate = self;
    _hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"信息公开";
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://new.sousuo.gov.cn/s.htm?t=file"]]];
    [self.view addSubview:_webView];
    
    // Do any additional setup after loading the view.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('bottomicon')[0].style.display = 'NONE'"];
    [_hud hideAnimated:YES];
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
