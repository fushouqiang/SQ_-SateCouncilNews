//
//  SQ_depaChildController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/1.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_depaChildController.h"
#import "HttpClient.h"
#import "SQ_Article.h"
#import "NSObject+YYModel.h"
#import "SQ_depNewsCell.h"
#import "SQ_DetailViewController.h"
#import "MJRefresh.h"
#import "SQ_depaDetailViewController.h"
static NSString *const cellIdentifier = @"cell";
@interface SQ_depaChildController ()
<
UITableViewDelegate,
UITableViewDataSource
>
typedef void (^JsonSuccess)(id json);
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *articleArray;
@property (nonatomic, assign) NSInteger *dataNumber;
@property (nonatomic, assign) unsigned long flagNumber;
@end

@implementation SQ_depaChildController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, self.view.bounds.size.height - 104) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self handleData];
        
    }];
    [_tableView.mj_header beginRefreshing];
    [self.view addSubview:_tableView];
    [_tableView registerClass:[SQ_depNewsCell class] forCellReuseIdentifier:cellIdentifier];
    _tableView.rowHeight = 100;
 
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
 
    
    return  _articleArray.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SQ_depNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (_articleArray.count > 0) {
        cell.article = _articleArray[indexPath.row];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SQ_depaDetailViewController *dtVC = [[SQ_depaDetailViewController alloc] init];
    dtVC.article = _articleArray[indexPath.row];
    [self.navigationController pushViewController:dtVC animated:YES];
    
}




- (void)handleData {
    NSString *string = [[_dataDic allKeys] firstObject];
    NSString *str2 = [_dataDic valueForKey:string];
    self.articleArray = [NSMutableArray array];
    [self getJsonWithUrlString:[NSString stringWithFormat:@"http://app.www.gov.cn/govdata/html/%@/column_%@_0.json",string,str2] json:^(id json) {
        
        if (json != NULL) {
            NSArray *array = [json allKeys];
            
            for (int i = 0; i < array.count; i++) {
                NSDictionary *dic = [json valueForKey:array[i]];
                SQ_Article *article = [SQ_Article yy_modelWithDictionary:dic];
                [self.articleArray addObject:article];
                
            }
            [_tableView reloadData];
             [_tableView.mj_header endRefreshing];
 
            
        }
        
        
    }];
    
}


- (void)reloadData {
    NSString *string = [[_dataDic allKeys] firstObject];
    NSString *str2 = [_dataDic valueForKey:string];
    [self.articleArray removeAllObjects];
    [self getJsonWithUrlString:[NSString stringWithFormat:@"http://app.www.gov.cn/govdata/html/%@/column_%@_0.json",string,str2] json:^(id json) {
        
        if (json != NULL) {
            
            NSArray *array = [json allKeys];
            

            
            
            for (int i = 0; i < array.count; i++) {
                NSDictionary *dic = [json valueForKey:array[i]];
                SQ_Article *article = [SQ_Article yy_modelWithDictionary:dic];
                [self.articleArray addObject:article];
                
            }
            [_tableView reloadData];
            
            
            
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


- (void)setDataDic:(NSDictionary *)dataDic {
    
    
    if (_dataDic != dataDic) {
        _dataDic = dataDic;
    }

    
    
//    [self handleDataWithString:string str2:str2];

    
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
