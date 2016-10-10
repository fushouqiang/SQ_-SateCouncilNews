//
//  SQ_WirteMessageController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/5.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_WirteMessageController.h"
#import "MBProgressHUD.h"

@interface SQ_WirteMessageController ()
<
MBProgressHUDDelegate,
UIWebViewDelegate
>
@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation SQ_WirteMessageController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.delegate = self;
    _hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我要留言";
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    webView.delegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://login.forum.gov.cn/html/form/suggest_wxzlsjh.html"]]];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
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
