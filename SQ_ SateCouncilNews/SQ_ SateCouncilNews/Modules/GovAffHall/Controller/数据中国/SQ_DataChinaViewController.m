//
//  SQ_DataChinaViewController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/5.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_DataChinaViewController.h"
#import "SQ_SectionHeadView.h"
#import "HttpClient.h"
#import "intHallTopCell.h"
#import "SQ_Article.h"
#import "NSObject+YYModel.h"
#import "SQ_DetailViewController.h"
#import "SQ_datacTopCell.h"
#import "SQ_GDPPIViewController.h"
#import "SQ_intHallDetailViewController.h"
#import "SQ_DataChinaCell.h"
#import "SQ_DataChinaMoreCell.h"

static NSString *const cellIdentifier = @"cell";

@interface SQ_DataChinaViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
typedef void (^JsonSuccess)(id json);
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *ideaArray;
@property (nonatomic, strong) NSMutableArray *backArray;
@end

@implementation SQ_DataChinaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"数据中国";
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 0.1f)];
    [self.view addSubview:_tableView];
    [self handleData];
}


- (void)handleData {
    
    self.ideaArray = [NSMutableArray array];
    self.backArray = [NSMutableArray array];
    [self getJsonWithUrlString:@"http://app.www.gov.cn/govdata/gov/column_497.json" json:^(id json) {
        
        if (json!= NULL) {
            
            
            
            NSDictionary *articlesDic = [json valueForKey:@"articles"];
            
            NSArray *keyArray = [articlesDic allKeys];
            
            if (keyArray > 0) {
                for (int i = 0; i < keyArray.count; i++) {
                    SQ_Article *article = [SQ_Article yy_modelWithDictionary:articlesDic[keyArray[i]]];
                    if ([article.categoryId isEqual: @"10171"]) {
                        [self.ideaArray addObject:article];
                    } else if ([article.categoryId isEqual: @"10173"]) {
                        [self.backArray addObject:article];
                        
                    }
                    [_tableView reloadData];
                    
                }
                
            }
            
        }
        
        
        
        
    }];
    
    
    
}


- (void)getJsonWithUrlString:(NSString *)urlString json:(JsonSuccess)json{
    
    [HttpClient getWithUrlString:urlString success:^(id data) {
        NSString *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        json(dic);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    SQ_SectionHeadView *headView = [[SQ_SectionHeadView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
    if (section == 0) {
        headView.titleText = @"数据要闻";
    } else if (section == 1) {
    } else {
        headView.titleText = @"数据解读";
    }
    headView.backgroundColor = [UIColor whiteColor];
    
    return headView;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        
        return 0.1;
    }
    
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        
        return 180;
    }
    
    if (indexPath.section == 1 && indexPath.row == 3) {
        return 60;
    }
    if (indexPath.section == 2 && indexPath.row == 3) {
        return 60;
    }
    
    return 100;
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 4;
    } else {
        return 4;
    }
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 &&  indexPath.row == 0) {
        static NSString *const cellID1 = @"cell1";
        SQ_datacTopCell *dataTopCell = [tableView dequeueReusableCellWithIdentifier:cellID1];
        if (dataTopCell == nil) {
            
            dataTopCell = [[SQ_datacTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
        }
        dataTopCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        dataTopCell.block = ^(NSInteger value) {
            
            if (value == 1) {
                SQ_GDPPIViewController *gdpVC = [[SQ_GDPPIViewController alloc] init];
                gdpVC.contentTitle = @"GDP";
                [self.navigationController pushViewController:gdpVC animated:YES];
            }
            else if (value == 2) {
                SQ_GDPPIViewController *gdpVC = [[SQ_GDPPIViewController alloc] init];
                gdpVC.contentTitle = @"GDP";
                [self.navigationController pushViewController:gdpVC animated:YES];            }   else if (value == 3) {
                    SQ_GDPPIViewController *gdpVC = [[SQ_GDPPIViewController alloc] init];
                    gdpVC.contentTitle = @"GDP";
                    [self.navigationController pushViewController:gdpVC animated:YES];
                }
            
        };
        
        return dataTopCell;
        
    } else if (indexPath.section == 1 && indexPath.row != 3) {
        static NSString *const cellID2 = @"cell2";
        if (indexPath.row != 3) {
            
            SQ_DataChinaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID2];
            if (cell == nil) {
                
                cell = [[SQ_DataChinaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];
                
            }
            
            if (_ideaArray.count > 0) {
                cell.article = _ideaArray[indexPath.row];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            
            return cell;
        }
        
    } else if (indexPath.section == 2 && indexPath.row != 3) {
        static NSString *const cellID3 = @"cell3";
        if (indexPath.row != 3) {
            
            SQ_DataChinaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID3];
            if (cell == nil) {
                
                cell = [[SQ_DataChinaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID3];
                
            }
            
            if (_backArray.count > 0) {
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.article = _backArray[indexPath.row];
                
            }
            
            
            return cell;
        }
        
    }
    
    
    SQ_DataChinaMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell = [[SQ_DataChinaMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 1 && indexPath.row != 3) {
        
        SQ_DetailViewController *detailVC = [[SQ_DetailViewController alloc] init];
        detailVC.article = _ideaArray[indexPath.row];
        [self.navigationController pushViewController:detailVC animated:YES];
        
    } else if (indexPath.section == 2 && indexPath.row != 3) {
        
        SQ_DetailViewController *detailVC = [[SQ_DetailViewController alloc] init];
        detailVC.article = _backArray[indexPath.row];
        [self.navigationController pushViewController:detailVC animated:YES];
        
    } else if (indexPath.section == 1 && indexPath.row == 3) {
        
        SQ_intHallDetailViewController *intDVC = [[SQ_intHallDetailViewController alloc] init];
        SQ_Article *article = _ideaArray[0];
        intDVC.categoryId = article.categoryId;
        intDVC.titleName = @"数据要闻";
        [self.navigationController pushViewController:intDVC animated:YES];
        
    } else if (indexPath.section == 2 && indexPath.row == 3) {
        
        SQ_intHallDetailViewController *intDVC = [[SQ_intHallDetailViewController alloc] init];
        SQ_Article *article = _backArray[0];
        intDVC.categoryId = article.categoryId;
        intDVC.titleName = @"数据解读";
        [self.navigationController pushViewController:intDVC animated:YES];
        
    }
    
    
    
    
    
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
