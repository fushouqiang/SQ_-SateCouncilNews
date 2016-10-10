
//
//  SQ_AffairsShowController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/1.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_AffairsShowController.h"
#import "HttpClient.h"
#import "SQ_depNewsCell.h"
#import "NSObject+YYModel.h"
#import "SQ_DetailViewController.h"
#import "SQ_depaDetailViewController.h"

static NSString *const cellIdentifier = @"cell";

@interface SQ_AffairsShowController ()
<
UITableViewDataSource,
UITableViewDelegate
>
typedef void (^JsonSuccess)(id json);
//政务联播TableView
@property (nonatomic, strong) UITableView *tableView;
//模型数组
@property (nonatomic, strong) NSMutableArray *articleArray;




@end

@implementation SQ_AffairsShowController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleData];
    self.view.backgroundColor = [UIColor greenColor];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 104)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[SQ_depNewsCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:_tableView];
    _tableView.rowHeight = 80;
    // Do any additional setup after loading the view.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _articleArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SQ_depaDetailViewController *detailVC = [[SQ_depaDetailViewController alloc] init];
    detailVC.article = _articleArray[indexPath.row];
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SQ_depNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (_articleArray.count > 0) {
        cell.article = _articleArray[indexPath.row];
    }
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleData {
    
    
    self.articleArray = [NSMutableArray array];
    [self getJsonWithUrlString:[NSString stringWithFormat:@"http://app.www.gov.cn/govdata/html/affairs_0.json"] json:^(id json) {
        
        if (json != NULL) {
            
            
            NSArray *keyArray = [json allKeys];
            
            for (int i = 0; i < keyArray.count; i++) {
                NSDictionary *articleDic = [json valueForKey:keyArray[i]];
                SQ_Article *article = [SQ_Article yy_modelWithDictionary:articleDic];
                [_articleArray addObject:article];
                
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
