//
//  SQ_ServiceChildController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/3.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_ServiceChildController.h"
#import "NSObject+YYModel.h"
#import "SQ_ChildClassify.h"
#import "SQ_categoriesCell.h"
#import "SQ_ServiceDetailViewController.h"


static NSString *const cellIdentifier = @"cell";

@interface SQ_ServiceChildController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation SQ_ServiceChildController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_label];
    
}


- (void)createCollectionView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat itemW = WIDTH / 3 - 1;
    CGFloat itemH = itemW / 2;
    flowLayout.itemSize = CGSizeMake(itemW, itemH);
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing = 1;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 400) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"SQ_categoriesCell" bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
    [self.view addSubview:_collectionView];
    _collectionView.backgroundColor = [UIColor colorWithWhite:0.897 alpha:1.000];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SQ_categoriesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    SQ_ChildClassify *childClassify = _dataArray[indexPath.row];
    
    cell.labelText = childClassify.title;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataArray.count;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SQ_ServiceDetailViewController *SdVC = [[SQ_ServiceDetailViewController alloc] init];
    SdVC.childClassify = _dataArray[indexPath.row];
    SdVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:SdVC animated:YES];
    
    
}


- (void)setClassify:(SQ_Classify *)classify {
    
    if (_classify != classify) {
        _classify = classify;
    }
    self.dataArray = [NSMutableArray array];
    NSDictionary *catDic = classify.categories;
    NSArray *keyArray = [catDic allKeys];
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < keyArray.count; i++) {
        NSDictionary *dic = [catDic valueForKey:keyArray[i]];
        SQ_ChildClassify *child = [SQ_ChildClassify yy_modelWithDictionary:dic];
        [array addObject:child];
    }
    
    for (int i = 0; i < array.count; i++) {
        
        for (SQ_ChildClassify *child in array) {
            
            if (i == [child.position intValue]) {
                [_dataArray addObject:child];
            }
        }
        
    }
    
    [self  createCollectionView];
    

    
    
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
