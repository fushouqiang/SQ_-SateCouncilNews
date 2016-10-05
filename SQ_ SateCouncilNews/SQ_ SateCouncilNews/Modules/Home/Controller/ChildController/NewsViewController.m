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
#import "SQ_DetailViewController.h"
#import "SQ_ScrollNewCell.h"
#import "SQ_Article.h"
#import "SQ_TopNewsCell.h"
#import "SQ_AvdioCell.h"
#import "SQ_PolicyCell.h"
#import "SQ_LocalityCell.h"
#import "SQ_departmentCell.h"
#import "SQ_ServiceCell.h"
#import "SQ_DataCell.h"
#import "SQ_interviewCell.h"



//static NSString *const cellIndentifier = @"cell";
static NSString *const headView = @"head";


typedef void (^JsonSuccess)(id json);

@interface NewsViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
touchIndexDelegate,
scrollNewsDelegate,
topNewsDelegate,
audioNewsDelegate,
policyNewsDelegate,
departmentNewsDelegate,
localityNewsDelegate,
serviceNewsDelegate,
dataNewsDelegate,
interviewNewsDelegate
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

@property (nonatomic, strong) NSDictionary *carouseTouchDic;




@end

@implementation NewsViewController




- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self handleData];
 
}


- (void)handleData {
    
    self.dataSourceArray = [NSMutableArray array];
    
    //请求数据
    [self getJsonWithUrlString:@"http://app.www.gov.cn/govdata/gov/home_1.json" json:^(id json) {
        
        if (json != NULL) {
            
            self.result = json;
            [self initDicWithResult:_result];
            self.car = [[SQ_CarouselView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
            _car.delegate = self;
            self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 104) style:UITableViewStylePlain];
            _tableView.delegate = self;
            _tableView.dataSource = self;
            [self.view addSubview:_tableView ];
            _tableView.backgroundColor = [UIColor whiteColor];
            _tableView.tableHeaderView = _car;
            _car.dataDic = _carouseDic;
            [_tableView reloadData];
            
        }
        
    }];

    
}

- (void)pushWithData:(SQ_Article *)article {
    
    SQ_DetailViewController *detailVC = [[SQ_DetailViewController alloc] init];
    detailVC.article = article;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

//滚动新闻触摸代理方法
- (void)scrollNewsTouchData:(SQ_Article *)article{
    
    [self pushWithData:article];
}




//轮播图触摸代理方法
- (void)touchIndexWithdata:(SQ_Article *)data {
     [self pushWithData:data];
}

//头条新闻触摸代理方法
- (void)topNewsTouchData:(SQ_Article *)article {
    
    [self pushWithData:article];
}
//音视频新闻触摸代理方法
- (void)audioNewsWithData:(SQ_Article *)article {
    
    [self pushWithData:article];
}

//政策新闻触摸代理方法
- (void)policyNewsWithData:(SQ_Article *)article {
    
    [self pushWithData:article];
}

//部门新闻触摸代理方法
- (void)departmentNewsWithData:(SQ_Article *)article {
    
    
    [self pushWithData:article];
}

//地方新闻触摸代理方法
- (void)localityNewsWithData:(SQ_Article *)article {
    
    [self pushWithData:article];
}
//服务新闻触摸代理方法
- (void)serviceNewsWithData:(SQ_Article *)article {
    
    [self pushWithData:article];
}
//数据新闻触摸代理方法
- (void)dataNewsWithData:(SQ_Article *)article {
    [self pushWithData:article];
}
//访谈新闻触摸代理方法
- (void)interviewNewsWithData:(SQ_Article *)article {
    
    [self pushWithData:article];
}


//将请求回来的数据分发
- (void)initDicWithResult:(id)result {
    

    
    self.carouseDic = [NSDictionary dictionaryWithDictionary:[result valueForKey:@"1"]];
     self.marqueeDic = [NSDictionary dictionaryWithDictionary:[result valueForKey:@"2"]];
     self.topDic = [NSDictionary dictionaryWithDictionary:[result valueForKey:@"3"]];
     self.videoDic = [NSDictionary dictionaryWithDictionary:[result valueForKey:@"4"]];
     self.policyDic = [NSDictionary dictionaryWithDictionary:[result valueForKey:@"5"]];

     self.departmentDic = [NSDictionary dictionaryWithDictionary:[result valueForKey:@"6"]];
     self.localityDic = [NSDictionary dictionaryWithDictionary:[result valueForKey:@"7"]];
     self.serviceDic = [NSDictionary dictionaryWithDictionary:[result valueForKey:@"11"]];
     self.dataDic = [NSDictionary dictionaryWithDictionary:[result valueForKey:@"8"]];
     self.specialDic = [NSDictionary dictionaryWithDictionary:[result valueForKey:@"9"]];
     self.interviewDic = [NSDictionary dictionaryWithDictionary:[result valueForKey:@"10"]];

}

//设置不同模块cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 20;
    }
    else if (indexPath.row == 1) {
        return 550;
    }
    else if (indexPath.row == 2) {
        return 500;
    }
    else if (indexPath.row == 3) {
        return 580;
    }
    else if (indexPath.row == 4) {
        return 580;
    }
    
    else if (indexPath.row == 5) {
        return 300;
    }
    else if (indexPath.row == 6) {
        return 200;
    }
    else if (indexPath.row == 7) {
        return 200;
    }
    else if (indexPath.row == 8) {
        return 200;
    }

    return 100;
}
//cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

//cell代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier1 = @"scrollNews";
    if (indexPath.row == 0) {
       
        SQ_ScrollNewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (nil == cell) {
            
            cell = [[SQ_ScrollNewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
            cell.dataDic = _marqueeDic;
            cell.delegate = self;

            
        }
        return cell;
    }
        else if (indexPath.row == 1) {
         static NSString *cellIdentifier2 = @"topNews";
        SQ_TopNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        if (nil == cell) {
            
            cell = [[SQ_TopNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2];
            cell.dataDic = _topDic;
            cell.delegate = self;
            
            
        }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
        else if (indexPath.row == 2) {
             static NSString *cellIdentifier3 = @"audioNews";
            SQ_AvdioCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier3];
            if (nil == cell) {
                
                cell = [[SQ_AvdioCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier3];
                cell.dataDic = _videoDic;
                cell.delegate = self;
                
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else if (indexPath.row == 3) {
             static NSString *cellIdentifier4 = @"policyNews";
            SQ_PolicyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier4];
            if (nil == cell) {
                
                cell = [[SQ_PolicyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier4];
                cell.dataDic = _policyDic;
                cell.delegate = self;
                
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else if (indexPath.row == 4) {
            static NSString *cellIdentifier5 = @"departmentNews";
            SQ_departmentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier5];
            if (nil == cell) {
                
                cell = [[SQ_departmentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier5];
                cell.dataDic = _departmentDic;
                cell.delegate = self;
                
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else if (indexPath.row == 5) {
            static NSString *cellIdentifier6 = @"localityNews";
            SQ_LocalityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier6];
            if (nil == cell) {
                
                cell = [[SQ_LocalityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier6];
                cell.dataDic = _localityDic;
                cell.delegate = self;
                
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else if (indexPath.row == 6) {
            static NSString *cellIdentifier7 = @"serviceNews";
            SQ_ServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier7];
            if (nil == cell) {
                
                cell = [[SQ_ServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier7];
                cell.dataDic = _serviceDic;
                cell.delegate = self;
                
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else if (indexPath.row == 7) {
            static NSString *cellIdentifier8 = @"dataNews";
            SQ_DataCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier8];
            if (nil == cell) {
                
                cell = [[SQ_DataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier8];
                cell.dataDic = _dataDic;
                cell.delegate = self;
                
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else {
            static NSString *cellIdentifier9 = @"interviewNews";
            SQ_interviewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier9];
            if (nil == cell) {
                
                cell = [[SQ_interviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier9];
                cell.dataDic = _interviewDic;
                cell.delegate = self;
                
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
    

        }
 
    
    
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
