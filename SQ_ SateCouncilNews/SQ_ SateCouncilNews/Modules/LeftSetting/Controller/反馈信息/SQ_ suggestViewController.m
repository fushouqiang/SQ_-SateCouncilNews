//
//  SQ_ suggestViewController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/11.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_ suggestViewController.h"

@interface SQ__suggestViewController ()
<
UITextViewDelegate
>

//建议textField
@property (nonatomic, strong) UITextView *textView;
//提交建议button
@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, strong) UILabel *headLabel;


@end

@implementation SQ__suggestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
    
    
    
    
}


- (void)createUI {
    
    self.textView = [[UITextView alloc] init];
    [self.view addSubview:_textView];
    [_textView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.top).offset(90);
        make.height.equalTo(HEIGHT / 3);
        make.width.equalTo(WIDTH - 60);
        make.centerX.equalTo(self.view.centerX);
    }];
//    _textView.placeholder = @"请输入您要反馈的信息";
    _textView.backgroundColor = [UIColor colorWithWhite:0.756 alpha:1.000];
    _textView.layer.cornerRadius = 5.0;
    _textView.clipsToBounds = YES;
    _textView.font = [UIFont systemFontOfSize:20];
    _textView.delegate = self;
    _textView.returnKeyType = UIReturnKeyDone;
    
    self.submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_submitButton];
    [_submitButton makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_textView.bottom).offset(30);
        make.width.equalTo(_textView.width);
        make.height.equalTo(50);
        make.centerX.equalTo(self.view.centerX);
        
    }];
    
    [_submitButton setTitle:@"提交建议" forState:UIControlStateNormal];
    _submitButton.layer.cornerRadius = 5.0;
    _submitButton.clipsToBounds = YES;
    _submitButton.backgroundColor = [UIColor colorWithRed:0.440 green:0.596 blue:0.807 alpha:1.000];
    [_submitButton addTarget:self action:@selector(submitButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(15, 30, 60, 45);
    [self.view addSubview:backButton];
    [backButton setImage:[UIImage imageNamed:@"backButton"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.headLabel = [[UILabel alloc] init];
    _headLabel.frame = CGRectMake(85, 30, 150, 45);
    _headLabel.text = @"反馈建议";
    _headLabel.font = [UIFont systemFontOfSize:20];
    _headLabel.textAlignment = NSTextAlignmentCenter;
    _headLabel.textColor = [UIColor colorWithWhite:0.686 alpha:1.000];
    [self.view addSubview:_headLabel];
}

- (void)backButtonAction {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


- (void)submitButtonAction:(UIButton *)button {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提交成功!" message:@"您的每一句建议都是我们前进的动力!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _textView.text = @"谢谢您的提交";
        _textView.textColor = [UIColor colorWithRed:1.000 green:0.307 blue:0.111 alpha:1.000];
        _textView.font = [UIFont systemFontOfSize:20];
        [_textView setEditable: NO];
        
        _headLabel.text = @"Thank You!";
        _headLabel.textColor = [UIColor colorWithWhite:0.257 alpha:1.000];
        _submitButton.userInteractionEnabled = NO;
    }];
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
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
