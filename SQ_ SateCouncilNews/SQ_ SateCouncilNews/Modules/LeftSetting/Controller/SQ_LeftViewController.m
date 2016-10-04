//
//  SQ_LeftViewController.m
//  SQ_SCNews
//
//  Created by FuShouqiang on 16/9/21.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_LeftViewController.h"
#import "SQ_LeftCell.h"
#import "DataBaseManager.h"
#import "SQ_SavedViewController.h"

static NSString *const cellIdentifier = @"cell";

@interface SQ_LeftViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *imageNameArray;
@property (nonatomic, strong) NSArray *textArray;
@property (nonatomic, strong) DataBaseManager *manager;

@end

@implementation SQ_LeftViewController


//- (void)viewWillAppear:(BOOL)animated {
//    
//    [super viewWillAppear:animated];
//     self.manager = [DataBaseManager shareManager];
//    [_manager openSQLite];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//     [_manager closeSQLite];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createData];
    [self createLogo];
    [self createBottonUi];
    [self createTableView];
    // Do any additional setup after loading the view.
}


- (void) createLogo {
    
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.view addSubview:imageView];
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(80);
        make.left.equalTo(self.view.left).offset(30);
        make.width.equalTo(60);
        make.height.equalTo(30);
    }];
    imageView.image = [UIImage imageNamed:@"sideMenuLeftLogo"];
    self.view.backgroundColor = [UIColor colorWithRed:0.034 green:0.495 blue:0.703 alpha:1.000];
}


- (void)createBottonUi {
 
    UILabel *bottonLabel = [[UILabel alloc] init];
    [self.view addSubview:bottonLabel];
    [bottonLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.bottom);
        make.left.equalTo(self.view.left);
        make.width.equalTo(self.view.width);
        make.height.equalTo(40);
    }];

 
    UIButton *cnButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [bottonLabel addSubview:cnButton];
    [cnButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottonLabel.left).offset(10);
        make.bottom.equalTo(bottonLabel.bottom).offset(-10);
        make.width.equalTo(60);
        make.height.equalTo(20);
    }];
    [cnButton setImage:[UIImage imageNamed:@"sideMenuLeftIconCn"] forState:UIControlStateNormal];
    cnButton.backgroundColor = [UIColor colorWithWhite:0.972 alpha:1.000];
    
    
    UIButton *enButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [bottonLabel addSubview:enButton];
    [enButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottonLabel.right).offset(-10);
        make.bottom.equalTo(bottonLabel.bottom).offset(-10);
        make.width.equalTo(60);
        make.height.equalTo(20);
    }];
    [enButton setImage:[UIImage imageNamed:@"sideMenuLeftIconEn"] forState:UIControlStateNormal];
    enButton.backgroundColor = [UIColor colorWithWhite:0.972 alpha:1.000];

}



- (void)createTableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = [UIColor colorWithRed:0.034 green:0.495 blue:0.703 alpha:1.000];
        _tableView.dataSource  = self;
        [self.view addSubview:_tableView];
        [_tableView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(HEIGHT / 3);
            make.left.equalTo(self.view).offset(20);
            make.height.equalTo(HEIGHT / 2);
            make.width.equalTo(WIDTH / 3);
            
            
        }];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView registerClass:[SQ_LeftCell class] forCellReuseIdentifier:cellIdentifier];
        
    }
    
}

- (void)createData {
    
    self.imageNameArray = @[@"sideMenuLeftSaved",@"sideMenuLeftShare",@"sideMenuLeftCache",@"sideMenuLeftSetting",@"sideMenuLeftAboutus"];
    self.textArray = @[@"我的收藏",@"推荐给朋友",@"离线阅读",@"设置",@"关于我们"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SQ_LeftCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.backgroundColor = [UIColor colorWithRed:0.034 green:0.495 blue:0.703 alpha:1.000];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageName = _imageNameArray[indexPath.row];
    cell.labelText = _textArray[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
       
        
        SQ_SavedViewController *saveVC = [[SQ_SavedViewController alloc] init];
       
     
        [self presentViewController:saveVC animated:YES completion:nil];
//        [self.navigationController pushViewController:saveVC animated:YES];
        
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
