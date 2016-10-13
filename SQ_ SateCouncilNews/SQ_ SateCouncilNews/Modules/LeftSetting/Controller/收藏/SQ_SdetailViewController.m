//
//  SQ_SdetailViewController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/30.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_SdetailViewController.h"
#import "HttpClient.h"
#import "SQ_Article.h"
#import "NSObject+YYModel.h"
#import "SQ_Detail.h"
#import "DataBaseManager.h"
#import "SQ_singlePicController.h"


@interface SQ_SdetailViewController ()
<
UIWebViewDelegate
>
typedef void (^JsonSuccess)(id json);
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) NSMutableArray *mUrlArray;


@end

@implementation SQ_SdetailViewController



- (void)viewWillAppear:(BOOL)animated {
    
    
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.webView = [[UIWebView alloc] init];
    [self.view addSubview:_webView];
    self.view.backgroundColor = [UIColor whiteColor];
    [_webView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(70);
        make.left.equalTo(self.view);
        make.width.equalTo(WIDTH);
        make.height.equalTo(HEIGHT - 50);
    }];
    NSString *urlString = self.article.shareUrl;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    
    self.webView.delegate = self;
    _webView.scrollView.bounces = NO;
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
     [self.view addSubview:_backButton];
    [_backButton makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.left).offset(10);
        make.top.equalTo(self.view.top).offset(35);
        make.height.equalTo(35);
        make.width.equalTo(45);
    }];
    [_backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_backButton setImage:[UIImage imageNamed:@"backButton"] forState:UIControlStateNormal];
   
}

- (void)backButtonClick:(UIButton *)button {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if ([request.URL.scheme isEqualToString:@"image-preview"]) {
        NSString* path = [request.URL.absoluteString substringFromIndex:[@"image-preview:" length]];
        //url转码
        path = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        SQ_singlePicController *singlePic = [[SQ_singlePicController alloc] init];
        singlePic.urlString = path;
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:_mUrlArray];
        singlePic.picUrlArray = array;
        [self presentViewController:singlePic animated:YES completion:nil];
        
        return NO;
    }
    return YES;
    
}

//屏蔽JS广告
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('bottomicon')[0].style.display = 'NONE'"];
    
    
    //这里是js，主要目的实现对url的获取
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var objs = document.getElementsByTagName(\"img\");\
    var imgScr = '';\
    for(var i=0;i<objs.length;i++){\
    imgScr = imgScr + objs[i].src + '+';\
    };\
    return imgScr;\
    };";
    
    [webView stringByEvaluatingJavaScriptFromString:jsGetImages];//注入js方法
    NSString *urlResurlt = [webView stringByEvaluatingJavaScriptFromString:@"getImages()"];
    
    
    self.mUrlArray = [NSMutableArray arrayWithArray:[urlResurlt componentsSeparatedByString:@"+"]];
    
    
    
    [webView stringByEvaluatingJavaScriptFromString:@"function registerImageClickAction(){\
     var imgs=document.getElementsByTagName('img');\
     var length=imgs.length;\
     for(var i=0;i<length;i++){\
     img=imgs[i];\
     img.onclick=function(){\
     window.location.href='image-preview:'+this.src}\
     }\
     }"];
    [webView stringByEvaluatingJavaScriptFromString:@"registerImageClickAction();"];
    
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
