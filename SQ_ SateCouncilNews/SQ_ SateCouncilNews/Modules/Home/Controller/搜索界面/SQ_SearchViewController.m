//
//  SQ_SearchViewController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/30.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_SearchViewController.h"
#import "SQ_SearchDetailController.h"

@interface SQ_SearchViewController ()
<
UITextFieldDelegate
>

@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation SQ_SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    
    
    
    
     self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)createUI {
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(80, 7, 180, 30)];
    
    UIImageView *search = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 25, 25)];
    [search setImage:[UIImage imageNamed:@"navigationSearchButton"]];
    _searchTextField.leftViewMode = UITextFieldViewModeAlways;
    _searchTextField.leftView = search;
    
    [self.navigationController.navigationBar addSubview:_searchTextField];
    _searchTextField.placeholder = @"搜索";
    _searchTextField.layer.borderColor = [UIColor colorWithRed:0.301 green:0.772 blue:0.845 alpha:1.000].CGColor;
    _searchTextField.layer.borderWidth = 2;
    _searchTextField.layer.cornerRadius = 5.0f;
    _searchTextField.returnKeyType = UIReturnKeySearch;
    [_searchTextField clipsToBounds];
    _searchTextField.delegate = self;
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.navigationController.navigationBar addSubview:_cancelButton];
    _cancelButton.frame = CGRectMake(WIDTH - 40, 13, 40, 20);
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, WIDTH, 2)];
    [self.view addSubview:lineLabel];
    lineLabel.backgroundColor = [UIColor colorWithRed:0.137 green:0.399 blue:0.879 alpha:1.000];
    
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH /2 - 20, HEIGHT / 2 - 60, 40, 40)];
    [self.view addSubview:logoImageView];
    logoImageView.image = [UIImage imageNamed:@"searchIcon"];
    
    UILabel *introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, HEIGHT / 2, WIDTH - 80, 30)];
    introduceLabel.text = @"请输入关键字,搜索你感兴趣的内容";
    introduceLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:introduceLabel];
    introduceLabel.font = [UIFont systemFontOfSize:14];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    NSLog(@"%@",_searchTextField.text);
    
    [_searchTextField endEditing:YES];
    SQ_SearchDetailController *sdtVC = [[SQ_SearchDetailController alloc] init];
    sdtVC.serachKey = _searchTextField.text;
    [self.navigationController pushViewController:sdtVC animated:YES];
    
    return YES;
}


- (void)viewWillDisappear:(BOOL)animated {
    
    
    _searchTextField.hidden = YES;
    _cancelButton.hidden = YES;
}


- (void)viewWillAppear:(BOOL)animated {
    
    _searchTextField.hidden = NO;
    _cancelButton.hidden = NO;

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
