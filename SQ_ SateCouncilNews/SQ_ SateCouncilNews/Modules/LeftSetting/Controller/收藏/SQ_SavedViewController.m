//
//  SQ_SavedViewController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/29.
//  Copyright © 2016年 fu. All rights reserved.
//
#define MAS_SHORTHAND_GLOBALS
#define MAS_SHORTHAND

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#import "Masonry.h"
#import "SQ_SavedViewController.h"
#import "SQ_normalCell.h"
#import "SQ_EasyNewsCell.h"
#import "SQ_DetailViewController.h"
#import "SQ_SdetailViewController.h"

@interface SQ_SavedViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong)UITableView *tableView;


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
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:selectButton];
    [selectButton makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.view.right).offset(-10);
        make.top.equalTo(self.view.top).offset(40);
        make.height.equalTo(35);
        make.width.equalTo(45);
    }];
    [selectButton setImage:[UIImage imageNamed:@"backButton"] forState:UIControlStateNormal];
    [selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    // Do any additional setup after loading the view.
}


- (void)selectButtonClick:(UIButton *)button {
    
    _tableView.allowsMultipleSelectionDuringEditing = YES;
    _tableView.editing = !_tableView.editing;
    
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
    return _articleAarray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    SQ_normalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        cell = [[SQ_normalCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier] ;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.article = _articleAarray[indexPath.row];
//    cell.backgroundView = [UIColor grayColor];
    return cell;



}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SQ_SdetailViewController *detailVC = [[SQ_SdetailViewController alloc] init];
    detailVC.article = _articleAarray[indexPath.row];
    detailVC.hidesBottomBarWhenPushed = YES;
    [self presentViewController:detailVC animated:YES completion:nil];
    
}

- (void)setArticleAarray:(NSArray *)articleAarray {
    
    if (_articleAarray != articleAarray) {
        _articleAarray = articleAarray;
        
    }
   
    [self createTableView];
    
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
