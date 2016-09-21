//
//  NewsViewController.m
//  SQ_SCNews
//
//  Created by FuShouqiang on 16/9/20.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "NewsViewController.h"
#import "AFNetworking.h"
#import "HttpClient.h"
#import "UIImageView+WebCache.h"

#define MAS_SHORTHAND_GLOBALS
#define MAS_SHORTHAND

#import "Masonry.h"
#import "SQ_NewsModel.h"
#import "NSObject+YYModel.h"

typedef void (^JsonSuccess)(id json);

@interface NewsViewController ()

@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)id result;


@end

@implementation NewsViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 200, 200, 200)];
    
    UIImageView *imageView = [[UIImageView alloc] init];
      [self.view addSubview:imageView];
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.bottom.equalTo(self.view.bottom).offset(-100);
        make.bottom.height.equalTo(200);
        
    }];
    
    imageView.backgroundColor = [UIColor blackColor];
  
    
    NSString *urlString = @"http://app.www.gov.cn/govdata/gov/home_1.json";
    [self getJsonWithUrlString:urlString json:^(id json) {
//        NSLog(@"%@",json);
        self.result = [[[[[[json valueForKey:@"1"] valueForKey:@"18156"] valueForKey:@"article"] valueForKey:@"thumbnails"] valueForKey:@"1"] valueForKey:@"file"];
        NSLog(@"%@",_result);
        
        id fsq = [[json valueForKey:@"1"] valueForKey:@"18156"];
        SQ_NewsModel *news = [SQ_NewsModel yy_modelWithJSON:fsq];
        NSLog(@"%@",news.title);
        
//        NSString *urlString = @"http://app.www.gov.cn/govdata/gov/201609/20/389616/thumbnail1_389616@2x.jpg?t=1474380286";
            NSString *urlString = [NSString stringWithFormat:@"http://app.www.gov.cn/govdata/gov/%@",self.result];
//            NSLog(@"%@",urlString);
            NSURL *url = [NSURL URLWithString:urlString];
            [imageView sd_setImageWithURL:url];
            
        
        
    }];
    
 
    
//    [imageView makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(self.view.left).offset(20);
//        make.right.equalTo(self.view.right).offset(-20);
//        make.top.equalTo(self.view.top).offset(200);
//        make.height.equalTo(200);
//    }];
   
    
    
    
    
}



//获取json
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
