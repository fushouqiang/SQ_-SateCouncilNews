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
#import "SQ_normalCell.h"

static NSString *const cellIdentifier = @"cell";
@interface SQ_depaChildController ()
<
UITableViewDelegate,
UITableViewDataSource
>
typedef void (^JsonSuccess)(id json);
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *articleArray;

@end

@implementation SQ_depaChildController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, self.view.bounds.size.height - 104) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[SQ_normalCell class] forCellReuseIdentifier:cellIdentifier];
    _tableView.rowHeight = 100;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
 
    
    return  _articleArray.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SQ_normalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (_articleArray.count > 0) {
        cell.article = _articleArray[indexPath.row];
    }
    
    
    return cell;
}




- (void)handleDataWithString:(NSString *)string str2:(NSString *)str2 {
    self.articleArray = [NSMutableArray array];
    [self getJsonWithUrlString:[NSString stringWithFormat:@"http://app.www.gov.cn/govdata/html/%@/column_%@_0.json",string,str2] json:^(id json) {
        
        if (json != NULL) {
            
            NSLog(@"%@",json);
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

    NSString *string = [[_dataDic allKeys] firstObject];
    NSString *str2 = [_dataDic valueForKey:string];
    
    [self handleDataWithString:string str2:str2];

    
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
