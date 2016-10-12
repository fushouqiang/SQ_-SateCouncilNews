//
//  SQ_depaDetailViewController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/8.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_depaDetailViewController.h"
#import "HttpClient.h"
#import "SQ_Article.h"
#import "NSObject+YYModel.h"
#import "SQ_Detail.h"
#import "DataBaseManager.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "SQ_DetailArticle.h"
#import "SQ_normalCell.h"
#import "MBProgressHUD.h"
#import "SQ_singlePicController.h"



static NSString *const cellIdentifier = @"cell";

@interface SQ_depaDetailViewController ()
<
UIWebViewDelegate,
UIGestureRecognizerDelegate,
MBProgressHUDDelegate
>
//定义一个有参数block
typedef void (^JsonSuccess)(id json);
//webView
@property (nonatomic, strong) UIWebView *webView;
//保存按钮
@property (nonatomic, strong) UIButton *saveButton;
//分享按钮
@property (nonatomic, strong) UIButton *shareButton;
//数据库manager
@property (nonatomic, strong) DataBaseManager *manager;
//是否以保存
@property (nonatomic, assign) BOOL isSaved;

//头视图
@property (nonatomic, strong) UILabel *headerView;

@property (nonatomic, strong) MBProgressHUD *hud;
//图片地址数组
@property (nonatomic, strong)  NSMutableArray  *mUrlArray;
//是否第一次进入
@property (nonatomic, assign) NSInteger visitNumber;







@end

@implementation SQ_depaDetailViewController



- (void)viewWillAppear:(BOOL)animated {
    
    
    [super viewWillAppear:animated];
    //打开数据里
    [_manager openSQLite];
    
    
    //防止浏览图片后hub一直显示
    
    if (_visitNumber == 0) {
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hud.delegate = self;
        _hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
    }
    
    _visitNumber += 1;
    
}


- (void)dealloc {
    
    [self.webView stopLoading];
    self.webView.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置标题视图
    self.headerView = [[UILabel alloc] init];
    _headerView.font = [UIFont systemFontOfSize:23];
    _headerView.numberOfLines = 0;
    _headerView.text = _article.title;
    
    //添加webView
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, self.view.frame.size.height - 64)];
    [self.view addSubview:_webView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView.delegate = self;
    _webView.scrollView.bounces = NO;
    //防止因为设置webView尾视图后每次跳转都会出现的黑条
    _webView.backgroundColor = [UIColor clearColor];
    _webView.opaque = NO;
    
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(100,0.0,0,0.0);

    
}



//创建UI视图
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
    [_shareButton addTarget:self action:@selector(shareButtonAction) forControlEvents:UIControlEventTouchUpInside];
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
    //开启数据区
    self.manager = [DataBaseManager shareManager];
    [_manager openSQLite];
    _isSaved =  [_manager selectArticle:article];
    
    [self createUI];
    
    //获取网络数据
    [self handleData];
    
    
    
}

//保存按钮响应
- (void)saveButtonAction:(UIButton *)button {
    
    
    if (_isSaved == true) {
        [_manager deleteWithArticle:_article];
        [button setImage:[UIImage imageNamed:@"newsSaveButton"] forState:UIControlStateNormal];
        [self alertWithTitle:@"取消收藏!" andMessage:nil];
    }
    
    else {
        
 
        [_manager insertIntoWithArticle:_article];
        [button setImage:[UIImage imageNamed:@"newsSavedButton"] forState:UIControlStateNormal];
        [self alertWithTitle:@"收藏成功!" andMessage:nil];
        
    }
    _isSaved = !_isSaved;
    
    
}
//alertController方法
- (void)alertWithTitle:(NSString *)title andMessage:(NSString *)message {
    
    
    UIAlertController *aboutUSAlertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [aboutUSAlertController addAction:action];
    
    
    [self presentViewController:aboutUSAlertController animated:YES completion:nil];
    
    
}


- (void)shareButtonAction {
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string  = _article.shareUrl;
    [self alertWithTitle:@"本页面分享链接已复制到剪贴板" andMessage:@"请手动粘贴到微信或微博"];
    
}




//获取底部相关新闻的数据
- (void)handleData {
    
    
    
    [self getJsonWithUrlString:[NSString stringWithFormat:@"http://app.www.gov.cn/govdata/html/%@",_article.path] json:^(id json) {
        
        if(json) {

            SQ_DetailArticle *detailArticle = [SQ_DetailArticle yy_modelWithJSON:json];
            NSString *str = [detailArticle.content stringByReplacingOccurrencesOfString:@"'\'" withString:@""];
            //图片高度自适应
            NSString *imageControl = [NSString stringWithFormat: @"<head><style>img{max-width:%f;height:auto !important;width:auto !important;.img {width:%f;}}</style></head>",WIDTH - 40,WIDTH - 40];
            
            
            NSString *htmlString = [imageControl stringByAppendingString:str];
            //加载剪辑后的html字符串
            [self.webView loadHTMLString:htmlString baseURL:nil];

            
            
            
            
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
    
    if ([request.URL.scheme isEqualToString:@"image-preview"]) {
        NSString* path = [request.URL.absoluteString substringFromIndex:[@"image-preview:" length]];
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

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [_hud hideAnimated:YES];
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
    
    
        self.headerView.frame = CGRectMake(0, -100, WIDTH, 100);
        [webView.scrollView addSubview:_headerView];
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
