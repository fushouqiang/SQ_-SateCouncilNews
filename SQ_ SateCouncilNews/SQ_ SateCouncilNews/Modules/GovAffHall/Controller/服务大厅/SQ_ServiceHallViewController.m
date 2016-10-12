//
//  SQ_ServiceHallViewController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/3.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_ServiceHallViewController.h"

#import "HttpClient.h"
#import "SQ_normalCell.h"
#import "SQ_headCell.h"
#import "MJRefresh.h"
#import "SQ_DetailViewController.h"
#import "SQ_Article.h"
#import "NSObject+YYModel.h"
#import "SQ_CollectionViewCell.h"
#import "SQ_ServiceCell.h"
#import "SQ_CollectionServiceCell.h"
#import "SQ_ServiceChildController.h"
#import "SQ_Classify.h"
#import "SQ_H5ServiceDetailController.h"

static NSString *const cellIdentifier = @"cell";

@interface SQ_ServiceHallViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UICollectionViewDelegate,
UICollectionViewDataSource
>
typedef void (^JsonSuccess)(id json);

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *articleArray;
@property (nonatomic, strong) id result;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) NSArray *childTitleArray;
@property (nonatomic, strong) NSMutableArray *categoriesArray;
@property (nonatomic, strong) NSIndexPath *flagIndex;



@end

@implementation SQ_ServiceHallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"服务大厅";
    NSArray *array = @[@"公民",@"企业",@"外国人",@"社会组织"];
    self.childTitleArray = array;
    self.articleArray = [NSMutableArray array];
    self.categoriesArray = [NSMutableArray array];
    [self createTableView];
    [self handleData];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpChildViewController];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    
}

//创建TableView和footer
- (void)createTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, self.view.bounds.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView ];
    _tableView.backgroundColor = [UIColor whiteColor];
    
    
    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, WIDTH * 1.15)];
    _footerView.backgroundColor = [UIColor whiteColor];
    _tableView.tableFooterView = _footerView;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemW = WIDTH / 4;
    CGFloat itemH = itemW + 10;
    flowLayout.itemSize = CGSizeMake(itemW, itemH);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 10, WIDTH, itemH) collectionViewLayout:flowLayout];
    [_collectionView registerNib:[UINib nibWithNibName:@"SQ_CollectionServiceCell" bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.footerView addSubview:_collectionView];
    self.containView = [[UIView alloc] initWithFrame:CGRectMake(0, itemH, WIDTH, _footerView.bounds.size.height - itemH)];
    [_footerView addSubview:_containView];
    

    //定义一个flag indexPath
    self.flagIndex = [NSIndexPath indexPathForItem:0 inSection:0];
    

}


//添加子控制器
- (void)setUpChildViewController {
    
    for (int i = 0; i < 4; i++) {
        SQ_ServiceChildController *serChildVC = [[SQ_ServiceChildController alloc] init];
        serChildVC.title = _childTitleArray[i];
        [self addChildViewController:serChildVC];
        
    }
    
    
    
    
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
  
    if (_flagIndex != nil) {
        SQ_CollectionServiceCell *cell1  = (SQ_CollectionServiceCell *)[collectionView cellForItemAtIndexPath:_flagIndex];
        cell1.backgroundColor = [UIColor colorWithWhite:0.746 alpha:1.000];
        
    }

    SQ_CollectionServiceCell *cell  = (SQ_CollectionServiceCell *)[collectionView cellForItemAtIndexPath:indexPath];
    self.flagIndex = indexPath;
    cell.backgroundColor = [UIColor whiteColor];

    
    
    //把之前的view移除
    [self.containView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 把对应子控制器的view添加上去
    SQ_ServiceChildController *vc = self.childViewControllers[indexPath.row];
    vc.classify = _categoriesArray[indexPath.row];
    vc.view.frame = self.containView.bounds;
    
    
    [self.containView addSubview:vc.view];

    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
   
    
    
    SQ_CollectionServiceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.imageName = [NSString stringWithFormat:@"hallServiceCategoryIcon%zd",(indexPath.row + 1)];
    cell.labelText = _childTitleArray[indexPath.row];

    if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor whiteColor];
    }
    else
    {
    cell.backgroundColor = [UIColor colorWithWhite:0.746 alpha:1.000];
    }
        return cell;
    
}





//获取数据
- (void)handleData {
    
    
    
    [self getJsonWithUrlString:[NSString stringWithFormat:@"http://app.www.gov.cn/govdata/gov/column_476.json"] json:^(id json) {
        
        if (json != NULL) {
            
            self.result = json;
            //解析上部新闻
            NSDictionary *articlesDic = [json valueForKey:@"articles"];
            
            NSArray *keyArray = [articlesDic allKeys];
            NSMutableArray *array = [NSMutableArray array];
            
                for (int i = 0; i < keyArray.count; i++) {
                    SQ_Article *article = [SQ_Article yy_modelWithDictionary:articlesDic[keyArray[i]]];
                    [array addObject:article];
                
                }
           
            
                
                for (SQ_Article *article in array) {
                    
                    if (4 == [article.contentMode intValue]) {
                        [_articleArray addObject:article];
                       
                    }
                }
            
            for (SQ_Article *article in array) {
                
                if (4 != [article.contentMode intValue]) {
                    [_articleArray addObject:article];
                    
                }
            }
            
            
            

            
            
            //解析下部分类
            
            NSDictionary *catDic = [json valueForKey:@"categories"];
            NSArray *ckeyArray = [catDic allKeys];
            
            NSMutableArray *catArray = [NSMutableArray array];
            
            for (int i = 0; i < ckeyArray.count; i++) {
                
                NSDictionary *dic = [catDic valueForKey:ckeyArray[i]];
                SQ_Classify *classify = [SQ_Classify yy_modelWithDictionary:dic];
                [catArray addObject:classify];
            }
            
            for (int i = 0; i < catArray.count; i++) {
                
                for (SQ_Classify *csify in catArray) {
                    
                    if (i == [csify.position intValue]) {
                        [_categoriesArray addObject:csify];
                    }
                }
            }
            
            [_tableView reloadData];
          
        }
        
        //把下部新闻先添加上去
        
        SQ_ServiceChildController *vc = self.childViewControllers[0];
        vc.classify = _categoriesArray[0];
        vc.view.frame = self.containView.bounds;
        [self.containView addSubview:vc.view];

     
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
    
    if (indexPath.row == 0) {
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

