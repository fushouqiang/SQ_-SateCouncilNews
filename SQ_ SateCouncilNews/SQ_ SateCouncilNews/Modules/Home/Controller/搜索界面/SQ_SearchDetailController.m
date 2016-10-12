//
//  SQ_SearchDetailController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/30.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_SearchDetailController.h"
#import "HttpClient.h"
#import "SQ_Article.h"
#import "SQ_normalCell.h"
#import "NSObject+YYModel.h"
#import "MJRefresh.h"
#import "SQ_DetailViewController.h"
static NSString *const cellIdentifier = @"cell";


@interface SQ_SearchDetailController ()
<
UITableViewDelegate,
UITableViewDataSource
>

typedef void (^JsonSuccess)(id json);
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) id result;
@property (nonatomic, strong) NSMutableArray *articleArray;
@property (nonatomic, assign) NSInteger dataNumber;
@property (nonatomic, assign) unsigned long flagNumber;
@end

@implementation SQ_SearchDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    
    self.dataNumber = 0;
    self.view.backgroundColor = [UIColor whiteColor];
   
    UILabel *reasonlabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 70, WIDTH - 80, 30)];
    reasonlabel.text = @"为您搜索到以下结果";
    reasonlabel.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:reasonlabel];


}

- (void)backButtonAction:(UIButton *)button {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)createTableView {
    

    _articleArray = [NSMutableArray array];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[SQ_normalCell class] forCellReuseIdentifier:cellIdentifier];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self handleData];
        
    }];
    
    [_tableView.mj_header beginRefreshing];
    
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        _flagNumber = _articleArray.count;
        _dataNumber++;
        [self addMoreData];
        
        
     
    }];

    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _articleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SQ_normalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (_articleArray.count > 0) {
        cell.article = _articleArray[indexPath.row];
    }
    
    return cell;
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SQ_Article *article = _articleArray[indexPath.row];
    SQ_DetailViewController *detailVC = [[SQ_DetailViewController alloc] init];
    detailVC.article = article;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}








- (void)setSerachKey:(NSString *)serachKey {
    
    if (_serachKey != serachKey) {
        _serachKey = serachKey;
    }
    
    
    
}




//刷新
- (void)handleData {
    
    NSString *string = [NSString stringWithFormat:@"http://appdyn.www.gov.cn/gov//search.shtml?page=0&keyword=%@",_serachKey];
    
    if (_articleArray.count > 0) {
        
        [_articleArray removeAllObjects];
    }
//    NSString  *urlString = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString  *urlString = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [self getJsonWithUrlString:urlString json:^(id json) {
        
        if (json != NULL) {

            self.result = json;
            
            
            
            NSArray *keyArray = [json allKeys];
            
           
            
            if (keyArray.count > 0) {
                for (int i = 0; i < keyArray.count; i++) {
                    NSDictionary *articleDic = [json valueForKey:keyArray[i]];
                    SQ_Article *article = [SQ_Article yy_modelWithDictionary:articleDic];
                    [_articleArray addObject:article];
                    
                }
                
                [_tableView reloadData];
                [_tableView.mj_header endRefreshing];
                 
            } else {
                [_tableView.mj_header endRefreshing];
                UIAlertController *AlertController = [UIAlertController alertControllerWithTitle:@"没有数据 请返回继续搜索" message:nil preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
                [AlertController addAction:action];
                
                
                [self presentViewController:AlertController animated:YES completion:nil];

            }
            
            
            
            
            
        }
        
    }];
    
}

//加载
- (void)addMoreData {
    
    NSString *string = [NSString stringWithFormat:@"http://appdyn.www.gov.cn/gov//search.shtml?page=%zd&keyword=%@",_dataNumber,_serachKey];
    NSString  *urlString = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [self getJsonWithUrlString:urlString json:^(id json) {
        
        if (json != NULL) {
            self.result = json;
            
            
            
            NSArray *keyArray = [json allKeys];
            for (int i = 0; i < keyArray.count; i++) {
                NSDictionary *articleDic = [json valueForKey:keyArray[i]];
                SQ_Article *article = [SQ_Article yy_modelWithDictionary:articleDic];
                [_articleArray addObject:article];
                
            }
            
           
            if (_flagNumber == _articleArray.count) {
                
                [_tableView.mj_footer endRefreshingWithNoMoreData];
            }
            else {
                 [_tableView reloadData];
                [_tableView.mj_footer endRefreshing];
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
