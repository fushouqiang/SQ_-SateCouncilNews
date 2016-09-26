//
//  SQ_SCViewController.m
//  SQ_SCNews
//
//  Created by FuShouqiang on 16/9/19.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_SCViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "HttpClient.h"
#import "SQ_headCell.h"
#import "SQ_News.h"
#import "NSObject+YYModel.h"
#import "SQ_Article.h"
#import "SQ_normalCell.h"
#import "SQ_SignNormalCell.h"
#import "SQ_EasyNewsCell.h"
typedef void (^JsonSuccess)(id json);

@interface SQ_SCViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *premierArray;
@property (nonatomic, strong) NSMutableArray *vicePremierArray;
@property (nonatomic, strong) NSMutableArray *councillorArray;
@property (nonatomic, strong) NSMutableArray *memberArray;

@end

@implementation SQ_SCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar_friendattention"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBtn)];
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self getJsonWithUrlString:@"http://app.www.gov.cn/govdata/gov/home_2.json" json:^(id json) {
        
       
        if (json != NULL) {
            [self initData:json];
            self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
            _tableView.delegate = self;
            _tableView.dataSource = self;
            [self.view addSubview:_tableView];
            [_tableView reloadData];
            
        }
        
    }];
    
    
    
    // Do any additional setup after loading the view.
}


- (void)initData:(id)data {
    
    
    self.premierArray = [NSMutableArray array];
    NSDictionary *preDic = [data valueForKey:@"12"];
    [self initArrayWithDic:preDic andArray:_premierArray];
    self.vicePremierArray = [NSMutableArray array];
    NSDictionary *vpreDic = [data valueForKey:@"14"];
    [self initArrayWithDic:vpreDic andArray:_vicePremierArray];
    self.councillorArray = [NSMutableArray array];
    NSDictionary *councillorDic = [data valueForKey:@"15"];
    [self initArrayWithDic:councillorDic andArray:_councillorArray];

    
}

- (void)initArrayWithDic:(NSDictionary *)dic andArray:(NSMutableArray *)array {
    
    NSArray *keyArray = [dic allKeys];
    NSMutableArray *newsArray = [NSMutableArray array];
    for (int i = 0; i < keyArray.count; i++) {
        SQ_News *news = [SQ_News yy_modelWithDictionary:[dic valueForKey:keyArray[i]]];
        [newsArray addObject:news];
    }
    //将新闻的position排序并加入数组中
    for (int i = 0; i < newsArray.count; i++) {
        for (SQ_News *news in newsArray) {
            if ([news.position intValue] == i) {
                
                [array addObject:news];
            }
            
        }
    }

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  20;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
        return 220;
    }
    if (indexPath.row == 3) {
        
        return 220;
    }
    if (indexPath.row == 4) {
        
        return 130;
    }
    
    
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        static NSString *cellID1 = @"cell1";
        SQ_headCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
        if (nil == cell) {
            
            cell = [[SQ_headCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
            SQ_News *news = _premierArray[0];
            cell.article = news.article;
            
            
        }
        return cell;
    }
    if (indexPath.row == 1) {
        static NSString *cellID2 = @"cell2";
        SQ_normalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID2];
        if (nil == cell) {
            
            cell = [[SQ_normalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];
            SQ_News *news = _premierArray[1];
            cell.article = news.article;
            
            
        }
        return cell;
    }
    if (indexPath.row == 2) {
        static NSString *cellID3 = @"cell3";
        SQ_normalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID3];
        if (nil == cell) {
            
            cell = [[SQ_normalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID3];
            SQ_News *news = _premierArray[2];
            cell.article = news.article;
            
            
        }
        return cell;
    }
    if (indexPath.row == 4) {
        static NSString *cellID5 = @"cell5";
        SQ_SignNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID5];
        if (nil == cell) {
            
            cell = [[SQ_SignNormalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID5];
            SQ_News *news = _vicePremierArray[0];
            cell.article = news.article;
            cell.signName = @"副总理";
            
            
        }
        return cell;
    }
    if (indexPath.row == 5) {
        static NSString *cellID6 = @"cell6";
        SQ_normalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID6];
        if (nil == cell) {
            
            cell = [[SQ_normalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID6];
            SQ_News *news = _vicePremierArray[1];
            cell.article = news.article;
            
            
        }
        return cell;
    }
    if (indexPath.row == 6) {
        static NSString *cellID7 = @"cell7";
        SQ_normalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID7];
        if (nil == cell) {
            
            cell = [[SQ_normalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID7];
            SQ_News *news = _vicePremierArray[2];
            cell.article = news.article;
            
            
        }
        
        return cell;
    }
    
    if (indexPath.row == 7) {
        static NSString *cellID8 = @"cell8";
        SQ_EasyNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID8];
        if (nil == cell) {
            
            cell = [[SQ_EasyNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID8];
            SQ_News *news = _vicePremierArray[3];
            cell.article = news.article;
            
            
        }
        
        return cell;
    }

    else {
        
        static NSString *cellID2 = @"default";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID2];
        if (nil == cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];
            
        }
        return cell;
    }
    
}

-(void)leftBtn{
    //这里的话是通过遍历循环拿到之前在AppDelegate中声明的那个MMDrawerController属性，然后判断是否为打开状态，如果是就关闭，否就是打开(初略解释，里面还有一些条件)
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}



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
