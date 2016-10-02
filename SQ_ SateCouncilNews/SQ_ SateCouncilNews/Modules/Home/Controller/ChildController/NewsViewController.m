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

#define gov http://app.www.gov.cn/govdata/gov/

#import "Masonry.h"
#import "NSObject+YYModel.h"
#import "news.h"


typedef void (^JsonSuccess)(id json);

@interface NewsViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) id result;
@property (nonatomic, retain) NSMutableArray *partArray;
@property (nonatomic, retain) NSMutableArray *newsArray;


@end

@implementation NewsViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.partArray = [NSMutableArray array];
    self.newsArray = [NSMutableArray array];
    
    NSString *urlString = @"http://app.www.gov.cn/govdata/gov/home_1.json";
    
    [self getJsonWithUrlString:urlString json:^(id json) {
 
    }];
    
    
    
    
    
    
}


- (void)createTableView {
    
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:_tableView];
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.top.equalTo(self.view.top);
        make.bottom.equalTo(self.view.bottom);
    }];
    
    
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
