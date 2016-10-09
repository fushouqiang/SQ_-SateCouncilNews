//
//  SQ_SavedViewController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/29.
//  Copyright © 2016年 fu. All rights reserved.
//
#import "SQ_SavedViewController.h"
#import "SQ_normalCell.h"
#import "SQ_EasyNewsCell.h"
#import "SQ_DetailViewController.h"
#import "SQ_SdetailViewController.h"
#import "DataBaseManager.h"
#import "SQ_SavedCell.h"
#import <DKNightVersion/DKNightVersion.h>
@interface SQ_SavedViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) __block NSArray *articleArray;
@property (nonatomic, strong) DataBaseManager *manager;

@end

@implementation SQ_SavedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:backButton];
    [backButton makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.left).offset(10);
        make.top.equalTo(self.view.top).offset(40);
        make.height.equalTo(35);
        make.width.equalTo(45);
    }];
    [backButton setImage:[UIImage imageNamed:@"backButton"] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [self.view addSubview:titleLabel];
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view.centerX);
        make.top.equalTo(self.view.top).offset(40);
        make.height.equalTo(35);
        make.width.equalTo(150);

        
    }];
    titleLabel.dk_backgroundColorPicker = DKColorPickerWithRGB(0x347EB3, 0x343434, 0xfafafa);
    titleLabel.text = @"您的收藏如下";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    
    
    
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:deleteButton];
    [deleteButton makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.view.right).offset(-10);
        make.top.equalTo(self.view.top).offset(40);
        make.height.equalTo(35);
        make.width.equalTo(45);
    }];
    [deleteButton setImage:[UIImage imageNamed:@"deleteButton"] forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //操作数据库赋值
    self.manager = [DataBaseManager shareManager];
    [_manager openSQLite];
    self.articleArray =[NSArray arrayWithArray:[_manager selectAllArticle] ];
    
    [self createTableView];
    
    
    // Do any additional setup after loading the view.
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [_manager closeSQLite];
    
}


//清空
- (void)deleteButtonClick:(UIButton *)button {
    
    UIAlertController *clearSavedAlertController = [UIAlertController alertControllerWithTitle:@"确认要清空收藏夹吗?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *verifyAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [_manager dropTable];
        [_manager createSQLite];
        _articleArray = nil;
        [_tableView reloadData];
    }];
    
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消 " style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [clearSavedAlertController addAction:action];
    [clearSavedAlertController addAction:verifyAction];
    
    [self presentViewController:clearSavedAlertController animated:YES completion:nil];
    
    
    
}



- (void)backButtonClick:(UIButton *)button {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)createTableView {
    
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:_tableView ];
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.view.top).offset(120);
        make.width.equalTo(WIDTH);
        make.height.equalTo(HEIGHT - 100);
        make.left.equalTo(self.view.left);
        
    }];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    

    _tableView.rowHeight = 120;
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _articleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    SQ_SavedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        cell = [[SQ_SavedCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier] ;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_articleArray.count > 0) {
        cell.article = _articleArray[indexPath.row];
    }
    
    
    return cell;



}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_articleArray.count > 0) {
        SQ_SdetailViewController *detailVC = [[SQ_SdetailViewController alloc] init];
        detailVC.article = _articleArray[indexPath.row];
        detailVC.hidesBottomBarWhenPushed = YES;
        [self presentViewController:detailVC animated:YES completion:nil];
    }
    
    
    
}
//
//- (void)setArticleAarray:(NSArray *)articleAarray {
//    
//    if (_articleAarray != articleAarray) {
//        _articleAarray = articleAarray;
//        
//    }
//   
//    [self createTableView];
//    
//}

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
