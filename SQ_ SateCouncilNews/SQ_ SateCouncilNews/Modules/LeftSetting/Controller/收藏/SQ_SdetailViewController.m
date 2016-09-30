//
//  SQ_SdetailViewController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/30.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_SdetailViewController.h"


#define MAS_SHORTHAND_GLOBALS
#define MAS_SHORTHAND
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#import "Masonry.h"
#import "HttpClient.h"
#import "SQ_Article.h"
#import "NSObject+YYModel.h"
#import "SQ_Detail.h"
#import "DataBaseManager.h"


@interface SQ_SdetailViewController ()
<
UIWebViewDelegate
>
typedef void (^JsonSuccess)(id json);
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) DataBaseManager *manager;
@property (nonatomic, assign) BOOL isSaved;
@property (nonatomic, strong) UIButton *backButton;


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


- (void)createUI {
    UIView *bottomView = [[UIView alloc] init];
    [self.view insertSubview:bottomView aboveSubview:_webView];
    [bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left);
        make.width.equalTo(WIDTH);
        make.height.equalTo(64);
        make.bottom.equalTo(self.view.bottom);
        
    }];
    bottomView.backgroundColor = [UIColor colorWithWhite:0.826 alpha:1.000];
    
    self.saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomView addSubview:_saveButton];
    [_saveButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.left).offset(50);
        make.top.equalTo(bottomView.top).offset(7);
        make.height.equalTo(50);
        make.width.equalTo(50);
        
        
    }];
    
    self.isSaved = [_manager selectArticle:_article];
    
    if (_isSaved == true) {
        [_saveButton setImage:[UIImage imageNamed:@"newsSavedButton"] forState:UIControlStateNormal];
        
    }
    else {
        
        [_saveButton setImage:[UIImage imageNamed:@"newsSaveButton"] forState:UIControlStateNormal];
    }
    
    [_saveButton setImage:[UIImage imageNamed:@"newsSaveSelectedButton"] forState:UIControlStateSelected];
    [_saveButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomView addSubview:_shareButton];
    [_shareButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView.right).offset(-50);
        make.top.equalTo(bottomView.top).offset(7);
        make.height.equalTo(50);
        make.width.equalTo(50);
    }];
    [_shareButton setImage:[UIImage imageNamed:@"newsShareButton"] forState:UIControlStateNormal];
    [_shareButton setImage:[UIImage imageNamed:@"newsShareSelectedButton"] forState:UIControlStateSelected];
    NSLog(@"%@",_article);
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_manager closeSQLite];
    
}


- (void)setArticle:(SQ_Article *)article {
    
    if (_article != article) {
        _article = article;
    }
    self.manager = [DataBaseManager shareManager];
    [_manager openSQLite];
    _isSaved =  [_manager selectArticle:article];
    [self createUI];
    
    
    
}

- (void)saveButtonAction:(UIButton *)button {
    
    
    if (_isSaved == true) {
        
        
        [_manager deleteWithArticle:_article];
        [button setImage:[UIImage imageNamed:@"newsSaveButton"] forState:UIControlStateNormal];
    }
    
    else  {
        
        
        [_manager insertIntoWithArticle:_article];
        
        [button setImage:[UIImage imageNamed:@"newsSavedButton"] forState:UIControlStateNormal];
        
        
    }
    _isSaved = !_isSaved;
    
    
}



//屏蔽JS广告
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('bottomicon')[0].style.display = 'NONE'"];
    
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
