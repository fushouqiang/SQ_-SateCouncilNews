//
//  SQ_DetailViewController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/23.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_DetailViewController.h"


#define MAS_SHORTHAND_GLOBALS
#define MAS_SHORTHAND
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#import "Masonry.h"
#import "HttpClient.h"
#import "SQ_Article.h"
#import "NSObject+YYModel.h"
#import "SQ_Detail.h"


@interface SQ_DetailViewController ()
<
UIWebViewDelegate
>
typedef void (^JsonSuccess)(id json);
@property (nonatomic, retain) UIWebView *webView;

@end

@implementation SQ_DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.view.backgroundColor = [UIColor orangeColor];
//    self.tabBarController.tabBar.hidden = YES;
    [self hidesBottomBarWhenPushed];
    self.webView = [[UIWebView alloc] init];

    [self.view addSubview:_webView];
    
    [_webView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.top).offset(64);
        make.left.equalTo(self.view);
        make.width.equalTo(WIDTH);
        make.height.equalTo(HEIGHT);
    }];
    
    NSString *urlString = self.article.shareUrl;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    [self handleData];

    
    self.webView.delegate = self;
    
}



//屏蔽JS广告
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('bottomicon')[0].style.display = 'NONE'"];
    
}

- (void)handleData {

    [self getJsonWithUrlString:[NSString stringWithFormat:@"http://app.www.gov.cn/govdata/gov/201609/27/390149/article.json"] json:^(id json) {
        
        if (json != NULL) {
            
            SQ_Detail *detail = [SQ_Detail yy_modelWithJSON:json];
            NSLog(@"%@",detail);
//            [_webView loadHTMLString:detail.content baseURL:nil];
            
        }

        
    }];
    
}



- (void)getJsonWithUrlString:(NSString *)urlString json:(JsonSuccess)json{
    
    
    
    
    [HttpClient getWithUrlString:urlString success:^(id data) {
        NSString *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        json(dic);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
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
