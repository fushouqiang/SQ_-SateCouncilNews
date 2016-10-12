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
#import "SQ_H5ServiceDetailController.h"
#import "MJRefresh.h"


//static NSString *const cellIndentifier = @"cell";
static NSString *const headView = @"head";


typedef void (^JsonSuccess)(id json);

@interface NewsViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
topNewsDelegate
>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)id result;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
//轮播图
@property (nonatomic, strong) SQ_CarouselView *car;
@property (nonatomic, strong) NSDictionary *carouseTouchDic;




@end

@implementation NewsViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleData];
    self.view.backgroundColor = [UIColor whiteColor];
  
 
}
//创建tableView
- (void)createTableView {
    self.car = [[SQ_CarouselView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    //避免block循环引用
    __weak typeof(self)weakSelf = self;
    _car.block = ^(SQ_Article *article) {
        [weakSelf pushWithData:article];
    };
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 104) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
      _car.dataDic = _dataSourceArray[0];
    [self.view addSubview:_tableView ];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.tableHeaderView = _car;
  
}

//获取数据
- (void)handleData {
    
    self.dataSourceArray = [NSMutableArray array];
    
    //请求数据
    [self getJsonWithUrlString:@"http://app.www.gov.cn/govdata/gov/home_1.json" json:^(id json) {
        
        if (json != NULL) {
            
            self.result = json;
            [self initDicWithResult:_result];
            
            [self createTableView];
            
        }
        
    }];

    
}

- (void)pushWithData:(SQ_Article *)article {
    
    SQ_DetailViewController *detailVC = [[SQ_DetailViewController alloc] init];
    detailVC.article = article;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}



//H5服务专用代理方法
- (void)H5ServiceTouch:(SQ_Article *)article {
    
    SQ_H5ServiceDetailController *h5vc = [[SQ_H5ServiceDetailController alloc] init];
    h5vc.hidesBottomBarWhenPushed = YES;
    h5vc.article = article;
    [self.navigationController pushViewController:h5vc animated:YES];
    
    
}




//将请求回来的数据分发
- (void)initDicWithResult:(id)result {
    
    
    
    for (int i = 1; i < 12; i++) {
        NSDictionary *  Dic = [NSDictionary dictionaryWithDictionary:[result valueForKey:[NSString stringWithFormat:@"%d",i]]];
        [_dataSourceArray addObject:Dic];

    }
    
    
    

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
            cell.dataDic = _dataSourceArray[1];
            cell.block = ^(SQ_Article *article){
                [self pushWithData:article];
            };

            
        }
        return cell;
    }
        else if (indexPath.row == 1) {
         static NSString *cellIdentifier2 = @"topNews";
        SQ_TopNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        if (nil == cell) {
            
            cell = [[SQ_TopNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2];
            cell.dataDic = _dataSourceArray[2];
            cell.delegate = self;
            cell.block = ^(SQ_Article *article){
                [self pushWithData:article];
            };
            
            
        }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
        else if (indexPath.row == 2) {
             static NSString *cellIdentifier3 = @"audioNews";
            SQ_AvdioCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier3];
            if (nil == cell) {
                
                cell = [[SQ_AvdioCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier3];
                cell.dataDic = _dataSourceArray[3];
                cell.block = ^(SQ_Article *article){
                    [self pushWithData:article];
                };
                
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else if (indexPath.row == 3) {
             static NSString *cellIdentifier4 = @"policyNews";
            SQ_PolicyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier4];
            if (nil == cell) {
                
                cell = [[SQ_PolicyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier4];
                cell.dataDic = _dataSourceArray[4];
                cell.block = ^(SQ_Article *article){
                    [self pushWithData:article];
                };

                
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else if (indexPath.row == 4) {
            static NSString *cellIdentifier5 = @"departmentNews";
            SQ_departmentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier5];
            if (nil == cell) {
                
                cell = [[SQ_departmentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier5];
                cell.dataDic = _dataSourceArray[5];
                cell.block = ^(SQ_Article *article){
                    [self pushWithData:article];
                };
                
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else if (indexPath.row == 5) {
            static NSString *cellIdentifier6 = @"localityNews";
            SQ_LocalityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier6];
            if (nil == cell) {
                
                cell = [[SQ_LocalityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier6];
                cell.dataDic =_dataSourceArray[6];
                cell.block = ^(SQ_Article *article){
                    [self pushWithData:article];
                };

                
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else if (indexPath.row == 6) {
            static NSString *cellIdentifier7 = @"serviceNews";
            SQ_ServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier7];
            if (nil == cell) {
                
                cell = [[SQ_ServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier7];
                cell.dataDic = _dataSourceArray[10];
                cell.block = ^(SQ_Article *article){
                [self pushWithData:article];
                };
                
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else if (indexPath.row == 7) {
            static NSString *cellIdentifier8 = @"dataNews";
            SQ_DataCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier8];
            if (nil == cell) {
                
                cell = [[SQ_DataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier8];
                cell.dataDic = _dataSourceArray[7];
                cell.block = ^(SQ_Article *article){
                    [self pushWithData:article];
                };
                
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else {
            static NSString *cellIdentifier9 = @"interviewNews";
            SQ_interviewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier9];
            if (nil == cell) {
                
                cell = [[SQ_interviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier9];
                cell.dataDic = _dataSourceArray[9];
                cell.block = ^(SQ_Article *article){
                    [self pushWithData:article];
                };
                
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
    

        }
 
    
    
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
