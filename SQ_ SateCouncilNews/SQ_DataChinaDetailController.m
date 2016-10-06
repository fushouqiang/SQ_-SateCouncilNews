//
//  SQ_DataChinaDetailController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/6.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_DataChinaDetailController.h"
#import "SQ_Article.h"
#import "HttpClient.h"
#import "NSObject+YYModel.h"
#import "MJRefresh.h"
#import "SQ_DetailViewController.h"
#import "SQ_DataChinaCell.h"

static NSString *const cellIdentifier = @"cell";

@interface SQ_DataChinaDetailController ()
<
UITableViewDelegate,
UITableViewDataSource
>
typedef void (^JsonSuccess)(id json);
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *articleArray;
@property (nonatomic, strong) id result;
@property (nonatomic, assign) NSInteger dataNumber;

@end

@implementation SQ_DataChinaDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.articleArray = [NSMutableArray array];
    [self createTableView];
    self.navigationItem.title = _titleName;
    
    self.dataNumber = 0;
    
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.rowHeight = 80;
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _dataNumber++;
        [self handleData];
        
    }];
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self reloadData];
        
    }];
    [_tableView.mj_header beginRefreshing];
    
}

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
    
    
    SQ_DataChinaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        cell = [[SQ_DataChinaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    if (_articleArray.count > 0) {
        cell.article = _articleArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    return cell;
    
    
}


- (void)handleData {
    
    [self getJsonWithUrlString:[NSString stringWithFormat:@"http://app.www.gov.cn//govdata/gov/columns/columnCategory_%@_%zd.json",_categoryId,_dataNumber] json:^(id json) {
        
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

- (void)reloadData {
    [self getJsonWithUrlString:[NSString stringWithFormat:@"http://app.www.gov.cn//govdata/gov/columns/columnCategory_%@_%zd.json",_categoryId,_dataNumber] json:^(id json) {
        
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
