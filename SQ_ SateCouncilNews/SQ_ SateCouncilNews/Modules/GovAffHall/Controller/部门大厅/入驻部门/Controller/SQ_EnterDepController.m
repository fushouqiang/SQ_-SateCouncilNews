//
//  SQ_EnterDepController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/1.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_EnterDepController.h"
#import "SQ_CollectionViewCell.h"
#import "HttpClient.h"
#import "SQ_icon.h"
#import "NSObject+YYModel.h"
#import "SQ_departNewsController.h"

static NSString *const cellIdentifier = @"cell";
@interface SQ_EnterDepController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>
typedef void (^JsonSuccess)(id json);
//部门CollectionView
@property (nonatomic, strong) UICollectionView *collectionView;
//模型数组
@property (nonatomic, strong) NSMutableArray *iconArray;

@end

@implementation SQ_EnterDepController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    [self setUpCollectionView];
    self.iconArray = [NSMutableArray array];
    [self handleData];

    
}

//建立CollectionView
- (void)setUpCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //三列
    NSInteger cols = 3;
    //一间距
    CGFloat margin = 1;
    //item宽
    CGFloat itemW = (WIDTH - (cols - 1) * margin) / 3;
    //item高
    CGFloat itemH = itemW + 10;
    layout.itemSize = CGSizeMake(itemW, itemH);
    //间距1
    layout.minimumLineSpacing = margin;
    //间距1
    layout.minimumInteritemSpacing = margin;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 105) collectionViewLayout:layout];
    //注册nib
    [_collectionView registerNib:[UINib nibWithNibName:@"SQ_CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
    [self.view addSubview:_collectionView];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor colorWithWhite:0.808 alpha:1.000];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    return _iconArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SQ_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (_iconArray.count > 0) {
        cell.icon = _iconArray[indexPath.row];
    }
    
    
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SQ_departNewsController *dnVC = [[SQ_departNewsController alloc] init];
    dnVC.icon = _iconArray[indexPath.row];
    [self.navigationController pushViewController:dnVC animated:YES];
    
}


//获取数据
- (void)handleData {
    
    
    
    [self getJsonWithUrlString:[NSString stringWithFormat:@"http://app.www.gov.cn/govdata/html/hall.json"] json:^(id json) {
        
        if (json != NULL) {
            

            NSArray *array = [json allKeys];
            
        
            
            
            
            NSMutableArray *icArray = [NSMutableArray array];
            for (int i = 0; i < array.count; i++) {
                NSDictionary *dic =[json valueForKey:array[i]];
                SQ_icon *icon =  [SQ_icon yy_modelWithDictionary:dic];
                [icArray addObject:icon];
            }
            //按position整理排序
            for (int i = 0; i < 75; i++) {
                
                for (SQ_icon *icon in icArray) {
                    
                    if ([icon.position intValue] == i) {
                        [_iconArray addObject:icon];
                    }
                }
                
            }
            [_collectionView reloadData];
            
            
            
            
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
