//
//  SQ_ServiceDetailViewController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/4.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_ServiceDetailViewController.h"

#import "HttpClient.h"
#import "SQ_Article.h"
#import "NSObject+YYModel.h"
#import "SQ_DetailViewController.h"
#import "MJRefresh.h"
#import "SQ_ServiceDetailCell.h"
static NSString *const cellIdentifier = @"cell";
@interface SQ_ServiceDetailViewController ()
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

@implementation SQ_ServiceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, self.view.bounds.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[SQ_ServiceDetailCell class] forCellReuseIdentifier:cellIdentifier];
    _tableView.rowHeight = 100;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    
    return  _articleArray.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SQ_ServiceDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (_articleArray.count > 0) {
        cell.article = _articleArray[indexPath.row];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SQ_DetailViewController *dtVC = [[SQ_DetailViewController alloc] init];
    dtVC.article = _articleArray[indexPath.row];
    [self.navigationController pushViewController:dtVC animated:YES];
    
}
//http://app.www.gov.cn/govdata/gov/columns/columnCategory_10079_0.json
//http://app.www.gov.cn/govdata/columns/columnCategory_10079_0.json



- (void)handleData {
   
    self.articleArray = [NSMutableArray array];
    [self getJsonWithUrlString:[NSString stringWithFormat:@"http://app.www.gov.cn/govdata/gov/columns/columnCategory_%@_0.json",[_childClassify.categoryId stringValue]] json:^(id json) {
        
        if (json != NULL) {
            
   
            NSArray *array = [[json valueForKey:@"articles"] allKeys];
            
            for (int i = 0; i < array.count; i++) {
                NSDictionary *dic = [[json valueForKey:@"articles"] valueForKey:array[i]];
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



- (void)setChildClassify:(SQ_ChildClassify *)childClassify {
    
    if (_childClassify != childClassify) {
        _childClassify = childClassify;
    }
    
    [self handleData];
    self.navigationItem.title = _childClassify.title;
    
    
    
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
