//
//  VideoViewController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/28.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "VideoViewController.h"

#import "HttpClient.h"
#import "MJRefresh.h"
#import "SQ_DetailViewController.h"
#import "SQ_Article.h"
#import "NSObject+YYModel.h"
#import "SQ_VideoCell.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
@interface VideoViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
typedef void (^JsonSuccess)(id json);

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *articleArray;
@property (nonatomic, strong) id result;
@property (nonatomic, assign) NSInteger dataNumber;
@property (nonatomic, strong) UIView *videoView;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerViewController *playerController;

@end



@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.articleArray = [NSMutableArray array];
    [self createTableView];
    self.dataNumber = 0;
  
       
    
    // Do any additional setup after loading the view.
}

- (void)createTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, self.view.frame.size.height - 104) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView ];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshData];
    }];
    [_tableView.mj_header beginRefreshing];
    
    
}

- (void)refreshData {
    
    [self reloadData];
    
}

- (void)loadData {
    if (_dataNumber == 3) {
        [self.tableView.mj_footer endRefreshing];
        [self footEndRefresh];
        return;
    }
    _dataNumber ++;
    [self handleData];
    [self.tableView.mj_footer endRefreshing];
    
    
    
}

- (void)footEndRefresh {
    [_tableView.mj_footer endRefreshingWithNoMoreData];
}

- (void)handleData {
    
    
    
    [self getJsonWithUrlString:[NSString stringWithFormat:@"http://app.www.gov.cn/govdata/gov/columns/column_481_%ld.json",(long)_dataNumber] json:^(id json) {
        
        if (json != NULL) {
            
            self.result = json;
            
            NSDictionary *articlesDic = [json valueForKey:@"articles"];
            
            NSArray *keyArray = [articlesDic allKeys];
            NSMutableArray *mtArray = [NSMutableArray array];
            
            for (int i = 0; i < keyArray.count; i++) {
                SQ_Article *article = [SQ_Article yy_modelWithDictionary:articlesDic[keyArray[i]]];
                [mtArray addObject:article];
                
            }
            
            for (int i = 0; i < mtArray.count; i++) {
                
                for (SQ_Article *art in mtArray) {
                    
                    if ([art.position intValue] == i) {
                        [_articleArray addObject:art];
                        //                        NSLog(@"%@",art.position);
                    }
                }
            }
            
            
            
            
            
            if (_tableView == NULL) {
                [self createTableView];
            }
            
            
            [_tableView reloadData];
            
        }
        
    }];
    
}

- (void)reloadData {
    self.dataNumber = 0;
    [self getJsonWithUrlString:[NSString stringWithFormat:@"http://app.www.gov.cn/govdata/gov/columns/column_481_%ld.json",(long)_dataNumber] json:^(id json) {
        
        if (json != NULL) {
            
            self.result = json;
            [_articleArray  removeAllObjects];
            NSDictionary *articlesDic = [json valueForKey:@"articles"];
            
            NSArray *keyArray = [articlesDic allKeys];
            NSMutableArray *mtArray = [NSMutableArray array];
            
            //根据position排序 并依次加入资源数组
            for (int i = 0; i < keyArray.count; i++) {
                SQ_Article *article = [SQ_Article yy_modelWithDictionary:articlesDic[keyArray[i]]];
                [mtArray addObject:article];
                
            }
            for (int i = 0; i < mtArray.count; i++) {
                
                for (SQ_Article *art in mtArray) {
                    
                    if ([art.position intValue] == i) {
                        [_articleArray addObject:art];
                        
                    }
                }
                
            }
            if (_tableView == NULL) {
                [self createTableView];
            }
            [_tableView reloadData];
            [_tableView.mj_header endRefreshing];
            
        }
        
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 250;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SQ_Article *article = _articleArray[indexPath.row];
    NSArray *keyArray = [article.medias allKeys];
    
    NSDictionary *dic = [article.medias valueForKey:[keyArray firstObject]];
    NSString *str = [dic valueForKey:@"file"];
    NSString *urlString = [NSString stringWithFormat:@"http://appvideo.www.gov.cn/gov/%@",str];
    
    NSLog(@"%@",urlString);
    //视频播放的url
    NSURL *videoUrl = [NSURL URLWithString:urlString];
    //初始化playerController
    self.playerController = [[AVPlayerViewController alloc] init];
    //AVPlayerItem 视频的一些信息 创建AVPlayer使用
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:videoUrl];
    self.player = [[AVPlayer alloc] initWithPlayerItem:item];
    //创建播放图层
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_player];
    layer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 250);
    layer.backgroundColor = [UIColor colorWithWhite:0.680 alpha:1.000].CGColor;
    //设置AVPlayer的填充模式
    layer.videoGravity = AVLayerVideoGravityResize;
    [self.view.layer addSublayer:layer];
    
    //设置avplayerController的avplayer为创建的player
    self.playerController.player = self.player;
    
    //关闭AVPlayerViewController内部的约束
    self.playerController.view.translatesAutoresizingMaskIntoConstraints = YES;
    
    [_player play];
    [self presentViewController:_playerController animated:YES completion:nil];
    layer.hidden = YES;
    
    
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _articleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    SQ_VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        cell = [[SQ_VideoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier] ;
    }
    cell.article = _articleArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
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