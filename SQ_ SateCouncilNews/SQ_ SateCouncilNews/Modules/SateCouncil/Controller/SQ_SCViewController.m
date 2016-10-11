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
#import "SQ_MenuCell.h"
#import "SQ_MemberCell.h"
#import "SQ_Member.h"
#import "SQ_StructureCell.h"
#import "SQ_SearchViewController.h"
#import "SQ_SCGeneralController.h"
#import "SQ_DetailViewController.h"
#import "SQ_SCorgViewController.h"
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
@property (nonatomic, strong) SQ_Member *member;
@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, assign) BOOL flag1;

@end

@implementation SQ_SCViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        [self.mm_drawerController setRightDrawerViewController:nil];
    }];
    self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.mm_drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    _rowHeight = 140;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 25)];
    imageView.image = [UIImage imageNamed:@"navigationLogo"];
    self.navigationItem.titleView = imageView;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationSettingButton"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBtn)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithWhite:0.534 alpha:1.000];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationSearchButton"] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithWhite:0.534 alpha:1.000];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self handleData];
    

    
    
    
    // Do any additional setup after loading the view.
}


- (void)handleData {
    
    [self getJsonWithUrlString:@"http://app.www.gov.cn/govdata/gov/home_2.json" json:^(id json) {
        
        
        if (json != NULL) {
            [self initData:json];
            self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
            _tableView.delegate = self;
            _tableView.dataSource = self;
            [self.view addSubview:_tableView];
            
        }
        
    }];
    
}

- (void)searchAction {
    
    SQ_SearchViewController *searchVC = [[SQ_SearchViewController alloc] init];
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
    
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
    
    self.member = [[SQ_Member alloc] init];
    _member.leadText = [[data valueForKey:@"16"] valueForKey:@"1"];
    _member.memberArray = [[data valueForKey:@"16"] valueForKey:@"2"];
    _member.urlString = [[data valueForKey:@"16"] valueForKey:@"3"];
    _member.isShowText = NO;
    

    
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
                SQ_Article *article = news.article;
                [array addObject:article];
            }
            
        }
    }

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  15;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
        return 240;
    }
    if (indexPath.row == 3) {
        
        return 220;
    }
    if (indexPath.row == 4) {
        
        return 130;
    }
    if (indexPath.row == 7) {
        
        return 80;
    }
    if (indexPath.row == 12) {
        
        return 80;
    }
    if (indexPath.row == 13) {
        
        if (_member.isShowText) {
            return 570;
        }
        
        else {
            return 160;
        }
        
    }
    if (indexPath.row == 14) {

        return 40;
 
    }
    
    
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        static NSString *cellID1 = @"cell1";
        SQ_headCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
        if (nil == cell) {
            
            cell = [[SQ_headCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
            
            cell.article = _premierArray[0];
            
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
   else if (indexPath.row == 1) {
        static NSString *cellID2 = @"cell2";
        SQ_normalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID2];
        if (nil == cell) {
            
            cell = [[SQ_normalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];
            cell.article = _premierArray[1];
            
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
   else if (indexPath.row == 2) {
        static NSString *cellID3 = @"cell3";
        SQ_normalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID3];
        if (nil == cell) {
            
            cell = [[SQ_normalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID3];
            cell.article = _premierArray[2];
            
            
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
   else if (indexPath.row == 3) {
       static NSString *cellID4 = @"cell3";
       SQ_MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID4];
       if (nil == cell) {
           
           cell = [[SQ_MenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID4];
           cell.block = ^(NSString *category){
               
               SQ_SCGeneralController *scGVC = [[SQ_SCGeneralController alloc] init];
               scGVC.category = category;
               scGVC.hidesBottomBarWhenPushed = YES;
               [self.navigationController pushViewController:scGVC animated:YES];
               
               
           };
           
       }
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
       return cell;
   }
   else if (indexPath.row == 4) {
        static NSString *cellID5 = @"cell5";
        SQ_SignNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID5];
        if (nil == cell) {
            
            cell = [[SQ_SignNormalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID5];
            cell.article = _vicePremierArray[0];
            
            cell.signName = @"副总理";
            
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
   else if (indexPath.row == 5) {
        static NSString *cellID6 = @"cell6";
        SQ_normalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID6];
        if (nil == cell) {
            
            cell = [[SQ_normalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID6];
            cell.article = _vicePremierArray[1];
            
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
  else  if (indexPath.row == 6) {
        static NSString *cellID7 = @"cell7";
        SQ_normalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID7];
        if (nil == cell) {
            
            cell = [[SQ_normalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID7];
            cell.article = _vicePremierArray[2];
            
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
   else if (indexPath.row == 7) {
        static NSString *cellID8 = @"cell8";
        SQ_EasyNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID8];
        if (nil == cell) {
            
            cell = [[SQ_EasyNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID8];
            cell.article = _vicePremierArray[3];
            
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
   else if (indexPath.row == 8) {
       static NSString *cellID9 = @"cell9";
       SQ_SignNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID9];
       if (nil == cell) {
           
           cell = [[SQ_SignNormalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID9];
           cell.article = _councillorArray[0];
           cell.signName = @"国务委员";
           
           
       }
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
       return cell;
   }
   else if (indexPath.row == 9) {
       static NSString *cellID10 = @"cell10";
       SQ_normalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID10];
       if (nil == cell) {
           
           cell = [[SQ_normalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID10];
           cell.article = _councillorArray[1];
           
           
       }
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
       return cell;
   }
   else if (indexPath.row == 10) {
       static NSString *cellID11 = @"cell11";
       SQ_normalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID11];
       if (nil == cell) {
           
           cell = [[SQ_normalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID11];
           cell.article = _councillorArray[2];
           
           
       }
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
       return cell;
   }
   else if (indexPath.row == 11) {
       static NSString *cellID12 = @"cell12";
       SQ_normalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID12];
       if (nil == cell) {
           
           cell = [[SQ_normalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID12];
           cell.article = _councillorArray[3];
           
           
       }
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
       return cell;
   }
   else if (indexPath.row == 12) {
       static NSString *cellID13 = @"cell13";
       SQ_EasyNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID13];
       if (nil == cell) {
           
           cell = [[SQ_EasyNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID13];
           cell.article = _councillorArray[4];
           
           
       }
    
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
       return cell;
   }
   else if (indexPath.row == 13) {
       static NSString *cellID14 = @"cell14";
       SQ_MemberCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID14];
       if (nil == cell) {
           
           cell = [[SQ_MemberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID14];
           cell.member = _member;
           cell.selectionStyle = UITableViewCellSelectionStyleBlue;

       }
       
       cell.showMoreTextBlock = ^(SQ_MemberCell *currentCell) {
           NSIndexPath *indexRow = [_tableView indexPathForCell:currentCell];
           [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexRow, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
           
       };
       
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
       return cell;
   }
    
   else if (indexPath.row == 14) {
       static NSString *cellID15 = @"cell15";
       SQ_StructureCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID15];
       if (nil == cell) {
           
           cell = [[SQ_StructureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID15];
        
       }
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
       return cell;
   }

    else {
        
        static NSString *cellID2 = @"default";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID2];
        if (nil == cell) {
            
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];
        
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SQ_DetailViewController *sdVC = [[SQ_DetailViewController alloc] init];

    if (indexPath.row != 14) {
        
        if (indexPath.row < 3) {
            sdVC.article = _premierArray[indexPath.row];
        } else if (indexPath.row <8) {
            sdVC.article = _vicePremierArray[indexPath.row - 4];
        } else if (indexPath.row < 13) {
            sdVC.article = _councillorArray[indexPath.row - 8];
        }
        
        
        sdVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:sdVC animated:YES];
        
    } else {
        SQ_SCorgViewController *scorgVC = [[SQ_SCorgViewController alloc] init];
        scorgVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:scorgVC animated:YES];
    }
  
    
   
    
    
}


-(void)leftBtn{
    //这里的话是通过遍历循环拿到之前在AppDelegate中声明的那个MMDrawerController属性，然后判断是否为打开状态，如果是就关闭，否就是打开(初略解释，里面还有一些条件)
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}



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
