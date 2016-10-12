//
//  SQ_GeneralViewController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/8.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_GeneralViewController.h"
#import "HttpClient.h"
#import "SQ_normalCell.h"
#import "SQ_headCell.h"
#import "MJRefresh.h"
#import "SQ_DetailViewController.h"
#import "SQ_Article.h"
#import "NSObject+YYModel.h"
#import "SQ_H5ServiceDetailController.h"

@interface SQ_GeneralViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
typedef void (^JsonSuccess)(id json);
// tableView
@property (nonatomic, strong) UITableView *tableView;
//模型数组
@property (nonatomic, strong) NSMutableArray *articleArray;
//
@property (nonatomic, strong) id result;
//加载的页面个数
@property (nonatomic, assign) NSInteger dataNumber;
@property (nonatomic, assign) unsigned long flagNumber;

@end

@implementation SQ_GeneralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self createTableView];
    self.articleArray = [NSMutableArray array];
    
    self.dataNumber = 0;
    
    
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    //    self.articleArray = [NSMutableArray array];
    //    [self handleData];
    //    self.dataNumber = 0;
    
}

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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 250;
    }
    else
    {
        return 100;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SQ_Article *article = _articleArray[indexPath.row];

    if ([_column.columnId intValue]== 476 && [article.contentMode intValue] == 4) {
        
        SQ_H5ServiceDetailController *h5VC = [[SQ_H5ServiceDetailController alloc] init];
        h5VC.article = _articleArray[indexPath.row];
        h5VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:h5VC animated:YES];
        
    }
    else {
        
        SQ_DetailViewController *detailVC = [[SQ_DetailViewController alloc] init];
        detailVC.article = _articleArray[indexPath.row];
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
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
        static NSString *cellIdentifier = @"Cell";
        SQ_normalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil == cell) {
            cell = [[SQ_normalCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier] ;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.article = _articleArray[indexPath.row];
        return cell;}
    
}

//获取json
- (void)getJsonWithUrlString:(NSString *)urlString json:(JsonSuccess)json{
    
    
    
    
    [HttpClient getWithUrlString:urlString success:^(id data) {
        NSString *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        json(dic);
    } failure:^(NSError *error) {
        [_tableView reloadData];
        [_tableView.mj_footer endRefreshingWithNoMoreData];
        [_tableView.mj_header endRefreshing];
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
