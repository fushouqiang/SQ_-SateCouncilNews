//
//  SQ_GDPPIViewController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/6.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_GDPPIViewController.h"
#import "MBProgressHUD.h"
@interface SQ_GDPPIViewController ()
<
MBProgressHUDDelegate,
UIWebViewDelegate
>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation SQ_GDPPIViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    _hud.delegate = self;
    _hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = _contentTitle;
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://data.stats.gov.cn"]];
    [self.webView loadRequest:request];
    [self.view addSubview:_webView];
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
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
