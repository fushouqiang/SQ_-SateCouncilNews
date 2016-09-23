//
//  NewsViewController.m
//  SQ_SCNews
//
//  Created by FuShouqiang on 16/9/20.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "NewsViewController.h"
#import "AFNetworking.h"
#import "HttpClient.h"
#import "UIImageView+WebCache.h"

#define MAS_SHORTHAND_GLOBALS
#define MAS_SHORTHAND

#import "Masonry.h"
#import "NSObject+YYModel.h"
#import "SQ_normalCell.h"
#import "SQ_CarouselView.h"


//static NSString *const cellIndentifier = @"cell";
static NSString *const headView = @"head";


typedef void (^JsonSuccess)(id json);

@interface NewsViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)id result;
@property (nonatomic, retain) NSMutableArray *dataSourceArray;
//轮播图
@property (nonatomic, retain) NSDictionary *carouseDic;
//跑马灯
@property (nonatomic, strong) NSDictionary *marqueeDic;
//头条
@property (nonatomic, strong) NSDictionary *topDic;
//视听
@property (nonatomic, strong) NSDictionary *videoDic;
//政策
@property (nonatomic, strong) NSDictionary *policyDic;
//部门
@property (nonatomic, strong) NSDictionary *departmentDic;
//地方
@property (nonatomic, strong) NSDictionary *localityDic;
//服务
@property (nonatomic, strong) NSDictionary *serviceDic;
//数据
@property (nonatomic, strong) NSDictionary *dataDic;
//专题
@property (nonatomic, strong) NSDictionary *specialDic;
//访谈
@property (nonatomic, strong) NSDictionary *interviewDic;

@property (nonatomic, strong) SQ_CarouselView *car;




@end

@implementation NewsViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    

   
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView ];
    _tableView.backgroundColor = [UIColor whiteColor];

  
    
    
    self.dataSourceArray = [NSMutableArray array];

            
        [self getJsonWithUrlString:@"http://app.www.gov.cn/govdata/gov/home_1.json" json:^(id json) {
            
            if (json != NULL) {
                
                self.result = json;
                [self initDicWithResult:_result];
                self.car = [[SQ_CarouselView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
                _tableView.tableHeaderView = _car;
                _car.dataDic = _carouseDic;
                [_tableView reloadData];
                
//                NSLog(@"%@",self.topDic);
                
                
                
                
                
            }
            
        }];
        

    
 
    
 
}


- (void)initDicWithResult:(id)result {
    

    
    self.carouseDic = [NSDictionary dictionaryWithDictionary:[result valueForKey:@"1"]];
     self.marqueeDic = [NSDictionary dictionaryWithDictionary:[result valueForKey:@"2"]];
     self.topDic = [NSDictionary dictionaryWithDictionary:[result valueForKey:@"3"]];
     self.videoDic = [NSDictionary dictionaryWithDictionary:[result valueForKey:@"4"]];
     self.policyDic = [NSDictionary dictionaryWithDictionary:[result valueForKey:@"5"]];
     self.departmentDic = [NSDictionary dictionaryWithDictionary:[result valueForKey:@"6"]];
     self.localityDic = [NSDictionary dictionaryWithDictionary:[result valueForKey:@"7"]];
     self.serviceDic = [NSDictionary dictionaryWithDictionary:[result valueForKey:@"8"]];
     self.dataDic = [NSDictionary dictionaryWithDictionary:[result valueForKey:@"9"]];
     self.specialDic = [NSDictionary dictionaryWithDictionary:[result valueForKey:@"10"]];
     self.interviewDic = [NSDictionary dictionaryWithDictionary:[result valueForKey:@"11"]];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    static NSString *cellIdentifier = @"Cell";
    
    SQ_normalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil == cell) {
            cell = [[SQ_normalCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier] ;
        }   
    return cell;
    
}

//获取json
- (void)getJsonWithUrlString:(NSString *)urlString json:(JsonSuccess)json{
    
    
    
    
    [HttpClient getWithUrlString:urlString success:^(id data) {
        NSLog(@"%@",[NSThread currentThread]);
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
