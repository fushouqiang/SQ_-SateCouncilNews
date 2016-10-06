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
#import "DataBaseManager.h"
#import "AppDelegate.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "UIImageView+WebCache.h"
#import "SQ_DetailArticle.h"
#import "SQ_normalCell.h"
static NSString *const cellIdentifier = @"cell";

@interface SQ_DetailViewController ()
<
UIWebViewDelegate,
UIGestureRecognizerDelegate,
UITableViewDelegate,
UITableViewDataSource
>
typedef void (^JsonSuccess)(id json);
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) DataBaseManager *manager;
@property (nonatomic, assign) BOOL isSaved;
@property (nonatomic, strong) id result;
@property (nonatomic, strong) NSMutableArray *articleArray;
@property (nonatomic, strong) UITableView *footerView;
@property (nonatomic, strong) UIView *headerView;

@end

@implementation SQ_DetailViewController



- (void)viewWillAppear:(BOOL)animated {
    
    
    [super viewWillAppear:animated];
    
    //禁止侧滑
    self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
    self.mm_drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeNone;
    [_manager openSQLite];

    
}




- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.webView = [[UIWebView alloc] init];
    [self.view addSubview:_webView];
    self.view.backgroundColor = [UIColor whiteColor];
    [_webView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(64);
        make.left.equalTo(self.view);
        make.width.equalTo(WIDTH);
        make.height.equalTo(HEIGHT - 128);
    }];
    NSString *urlString = self.article.shareUrl;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    self.webView.delegate = self;
    _webView.scrollView.bounces = NO;
    
    //防止因为设置webView尾视图后每次跳转都会出现的黑条
    _webView.backgroundColor = [UIColor clearColor];
    _webView.opaque = NO;
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(0,0.0,240,0.0);

    
    
//    self.webView.scrollView.contentInset = UIEdgeInsetsMake(0,0.0,240,0.0);
    self.footerView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 240) style:UITableViewStylePlain];
    [_footerView registerClass:[SQ_normalCell class] forCellReuseIdentifier:cellIdentifier];
    _footerView.delegate = self;
    _footerView.dataSource = self;
    _footerView.rowHeight = 100;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SQ_normalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (_articleArray.count > 0) {
        cell.article = _articleArray[indexPath.row];
    }
    return cell;
    
    
    
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
//    self.navigationItem.title = _article.title;
    [self handleData];
    
    
    
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

//跳转页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SQ_DetailViewController *detailVC = [[SQ_DetailViewController alloc] init];
    detailVC.article = _articleArray[indexPath.row];
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];

    
    
}


//获取数据
- (void)handleData {
    
    
    
    [self getJsonWithUrlString:[NSString stringWithFormat:@"http://app.www.gov.cn/govdata/gov/%@",_article.path] json:^(id json) {
       
        if(json) {
        self.result = json;
           
            SQ_DetailArticle *detailArticle = [SQ_DetailArticle yy_modelWithJSON:json];
           NSString *str = [detailArticle.content stringByReplacingOccurrencesOfString:@"'\'" withString:@""];
            NSString *str1 = [NSString stringWithFormat: @"<head><style>img{width:%fpx !important;height:%fpx !important;}</style></head>",WIDTH - 40,HEIGHT - 80];
            NSString *htmlString = [str1 stringByAppendingString:str];
            //加载剪辑后的html字符串
            [self.webView loadHTMLString:htmlString baseURL:nil];
            
            self.articleArray = [NSMutableArray array];
            NSArray *keyArray = [detailArticle.relatedArticles allKeys];
            if (keyArray > 0) {
                for (int i = 0; i < keyArray.count; i++) {
                    
                    NSDictionary *articleDic = [detailArticle.relatedArticles valueForKey:keyArray[i]];
                    SQ_Article *article = [SQ_Article yy_modelWithDictionary:articleDic];
                    [self.articleArray addObject:article];

                    
                }

            } else {
                                    self.webView.scrollView.contentInset = UIEdgeInsetsMake(0,0.0,0,0.0);
            }
            
            
            
            
        }
    }];
    
}


//获取json
- (void)getJsonWithUrlString:(NSString *)urlString json:(JsonSuccess)json{
    
    
    
    
    [HttpClient getWithUrlString:urlString success:^(id data) {
        NSString *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        json(dic);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}



//禁止点击链接
- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if(navigationType==UIWebViewNavigationTypeLinkClicked)//判断是否是点击链接
        {
        
        return NO;
        }
    
    else {
        return YES;
    }
    
}


//屏蔽JS广告
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('bottomicon')[0].style.display = 'NONE'"];

    //设置尾视图的relateNews的相关曹操作
    
    
    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    NSLog(@"%@",currentURL);
    
    
    if (_articleArray.count > 0) {
        NSString *result = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"];
        
        NSInteger height = [result integerValue] ;
        
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, height + 20, WIDTH - 6, 2)];
        lineLabel.backgroundColor = [UIColor colorWithRed:0.034 green:0.495 blue:0.703 alpha:1.000];
        
        UILabel *relatedLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, height + 20 + 15, 100, 13)];
        relatedLabel.text = @"相关新闻";
        relatedLabel.textColor = [UIColor colorWithRed:0.034 green:0.495 blue:0.703 alpha:1.000];
        
        
        self.footerView.frame = CGRectMake(0, height + 20 + 40, WIDTH, 200);
        
        [webView.scrollView addSubview:lineLabel];
        [webView.scrollView addSubview:relatedLabel];
        [webView.scrollView addSubview:self.footerView];

    }
    
    
    

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
