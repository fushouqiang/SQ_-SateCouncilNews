//
//  AudioViewController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/6.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "AudioViewController.h"
#import "HttpClient.h"
#import "SQ_normalCell.h"
#import "SQ_headCell.h"
#import "MJRefresh.h"
#import "SQ_DetailViewController.h"
#import "SQ_Article.h"
#import "NSObject+YYModel.h"
#import "SQ_AudioCell.h"

@interface AudioViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
typedef void (^JsonSuccess)(id json);

@property (nonatomic, strong) UITableView *tableView;
//模型数组
@property (nonatomic, strong) NSMutableArray *articleArray;

@property (nonatomic, strong) id result;
//刷新数据number
@property (nonatomic, assign) NSInteger dataNumber;

@property (nonatomic, assign) unsigned long flagNumber;
//音频播放器
@property (nonatomic, strong) __block AVPlayer *player;

@property (nonatomic, strong) __block AVPlayerItem *playerItem;

@property (nonatomic, assign) NSInteger cellNumber;

@end

@implementation AudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self createTableView];
    self.articleArray = [NSMutableArray array];
    
    self.dataNumber = 0;
    self.player = [[AVPlayer alloc]init];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
}


//创建tableView
- (void)createTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 150) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView ];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        _flagNumber = _articleArray.count;
        _dataNumber++;
        [self handleData];
        
    }];
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self reloadData];
        
    }];
    [_tableView.mj_header beginRefreshing];
    
    
}

- (void)refreshData {
    
    [self reloadData];
    
}



//获取数据
- (void)handleData {
    
    
    
    [self getJsonWithUrlString:[NSString stringWithFormat:@"http://app.www.gov.cn/govdata/gov/columns/column_%@_%zd.json",_column.columnId,_dataNumber] json:^(id json) {
        
        if (json != NULL) {
            
            self.result = json;
            
            NSDictionary *articlesDic = [json valueForKey:@"articles"];
            
            NSArray *keyArray = [articlesDic allKeys];
            
            if (keyArray > 0) {
                for (int i = 0; i < keyArray.count; i++) {
                    SQ_Article *article = [SQ_Article yy_modelWithDictionary:articlesDic[keyArray[i]]];
                    [_articleArray addObject:article];
                    [_tableView reloadData];
                    [_tableView.mj_footer endRefreshing];
                }
                
            }
            
        }
        else {
            
            
        }
        
    }];
    
}
//刷新数据
- (void)reloadData {
    [self getJsonWithUrlString:[NSString stringWithFormat:@"http://app.www.gov.cn/govdata/gov/columns/column_%@_%zd.json",_column.columnId,_dataNumber] json:^(id json) {
        
        if (json != NULL) {
            
            self.result = json;
            [_articleArray  removeAllObjects];
            NSDictionary *articlesDic = [json valueForKey:@"articles"];
            
            NSArray *keyArray = [articlesDic allKeys];
            
            for (int i = 0; i < keyArray.count; i++) {
                SQ_Article *article = [SQ_Article yy_modelWithDictionary:articlesDic[keyArray[i]]];
                [_articleArray addObject:article];
                
            }
            
            [_tableView reloadData];
            [_tableView.mj_header endRefreshing];
            
        }
        
    }];
    
}

//cell高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 250;
    }
    else
    {
        return 100;
    }
}

//点击跳转到相应页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SQ_DetailViewController *detailVC = [[SQ_DetailViewController alloc] init];
    detailVC.article = _articleArray[indexPath.row];
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _articleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        static NSString *cellIdentifier1 = @"Cell1";
        SQ_headCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (nil == cell) {
            cell = [[SQ_headCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier1] ;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.article = _articleArray[indexPath.row];
        return cell;
    }
    
    else {
        //给每一个cell设定标识避免重用 真是恶心啊
         NSString *cellIdentifier = [NSString stringWithFormat:@"cell%zd",indexPath.row];
        SQ_AudioCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil == cell) {
            cell = [[SQ_AudioCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier] ;
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        SQ_Article *cellArticle = _articleArray[indexPath.row];
        cell.article = cellArticle;
 
        cell.block = ^(AVPlayerItem *item ,SQ_AudioCell *currentCell) {

            
            //如果不是
            if (_playerItem == nil || (self.cellNumber != indexPath.row)) {
                _playerItem = item;
                [self.player replaceCurrentItemWithPlayerItem:_playerItem];
            }
            
            
            if (_cellNumber != indexPath.row && _cellNumber != 0) {
                
                //获取到上一个点击的cell
                SQ_AudioCell *lastCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_cellNumber inSection:0]];
                //如果上一个还处于播放状态
                if (lastCell.article.isPlay == YES) {
                     lastCell.article.isPlay = NO;
                }
                
               
                [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:_cellNumber inSection:0]] withRowAnimation:UITableViewRowAnimationNone];

            }
            
            
            
            if (cellArticle.isPlay == YES) {
                
                
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [_player play];
                
            });
            } else
            
            {
                [_player pause];
            }
            

          
            
            self.cellNumber = indexPath.row;

            
        };
        
        return cell;
    }
    
}

//获取json
- (void)getJsonWithUrlString:(NSString *)urlString json:(JsonSuccess)json{
    
    
    
    
    [HttpClient getWithUrlString:urlString success:^(id data) {
        NSString *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        json(dic);
    } failure:^(NSError *error) {
        [_tableView reloadData];
        [_tableView.mj_footer endRefreshingWithNoMoreData];
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
