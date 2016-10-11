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
#import <DKNightVersion/DKNightVersion.h>
#import "UIImageView+WebCache.h"
#import "SQ_ suggestViewController.h"

#define CACHEPATH [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]


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
@property (nonatomic, assign) BOOL isNight;
@property (nonatomic, strong) NSString *cache;
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
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}


- (void) createLogo {
    
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.view addSubview:imageView];
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(80);
        make.left.equalTo(self.view.left).offset(40);
        make.width.equalTo(60);
        make.height.equalTo(30);
    }];
    imageView.image = [UIImage imageNamed:@"sideMenuLeftLogo"];
//    self.view.backgroundColor = [UIColor colorWithRed:0.034 green:0.495 blue:0.703 alpha:1.000];
    self.view.dk_backgroundColorPicker = DKColorPickerWithRGB(0x347EB3, 0x343434, 0xfafafa);
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

 
//    UIButton *cnButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [bottonLabel addSubview:cnButton];
//    [cnButton makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(bottonLabel.left).offset(10);
//        make.bottom.equalTo(bottonLabel.bottom).offset(-10);
//        make.width.equalTo(60);
//        make.height.equalTo(20);
//    }];
//    [cnButton setImage:[UIImage imageNamed:@"sideMenuLeftIconCn"] forState:UIControlStateNormal];
//    cnButton.backgroundColor = [UIColor colorWithWhite:0.972 alpha:1.000];
//    
//    
//    UIButton *enButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [bottonLabel addSubview:enButton];
//    [enButton makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(bottonLabel.right).offset(-10);
//        make.bottom.equalTo(bottonLabel.bottom).offset(-10);
//        make.width.equalTo(60);
//        make.height.equalTo(20);
//    }];
//    [enButton setImage:[UIImage imageNamed:@"sideMenuLeftIconEn"] forState:UIControlStateNormal];
//    enButton.backgroundColor = [UIColor colorWithWhite:0.972 alpha:1.000];

}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
         self.cache = [self checkCache];
    });
    

    
   
    
}


- (void)createTableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
//        _tableView.backgroundColor = [UIColor colorWithRed:0.034 green:0.495 blue:0.703 alpha:1.000];
        self.tableView.dk_backgroundColorPicker = DKColorPickerWithRGB(0x347EB3, 0x343434, 0xfafafa);
        self.tableView.dk_separatorColorPicker = DKColorPickerWithKey(SEP);

        _tableView.dataSource  = self;
        [self.view addSubview:_tableView];
        [_tableView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(HEIGHT / 3);
            make.centerX.equalTo(self.view.centerX);
            make.height.equalTo(HEIGHT / 2 + 50);
            make.width.equalTo(WIDTH / 2);
            
            
        }];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView registerClass:[SQ_LeftCell class] forCellReuseIdentifier:cellIdentifier];
        _tableView.rowHeight = 60;
        
    }
    
}

- (void)createData {
    
    self.imageNameArray = @[@"sideMenuLeftChangeColor",@"sideMenuLeftSaved",@"sideMenuLeftClean",@"sideMenuLeftSetting",@"sideMenuLeftAboutus"];
    self.textArray = @[@"主题切换",@"我的收藏",@"清除缓存",@"反馈信息",@"关于我们"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SQ_LeftCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.dk_backgroundColorPicker = DKColorPickerWithRGB(0x347EB3, 0x343434, 0xfafafa);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageName = _imageNameArray[indexPath.row];
    cell.labelText = _textArray[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        _isNight = !_isNight;
        
        
        
        if (_isNight) {
            
            self.dk_manager.themeVersion = DKThemeVersionNight;
        } else {
            self.dk_manager.themeVersion = DKThemeVersionNormal;
        }
        
        
        
        
        //收藏夹
    } else if (indexPath.row == 1) {
        
       
        
        SQ_SavedViewController *saveVC = [[SQ_SavedViewController alloc] init];
       
     
        [self presentViewController:saveVC animated:YES completion:nil];
//        [self.navigationController pushViewController:saveVC animated:YES];
        //清除缓存
    } else if (indexPath.row == 2) {
        
        
        
      [self Clear];
            
        
        
       
        //关于我们
    } else if (indexPath.row == 3) {
        SQ__suggestViewController *suggestVC = [[SQ__suggestViewController alloc] init];
        
        [self presentViewController:suggestVC animated:YES completion:nil];
        
        
    } else if (indexPath.row == 4) {
        
        
        
        [self aboutUS];
        
    }
    
}



//关于我们


- (void)aboutUS {
    
    UIAlertController *aboutUSAlertController = [UIAlertController alertControllerWithTitle:@"fsq制作于2016-09" message:@"仅供学习交流,请于下载后24小时之内自觉删除,作者本人不负任何法律责任" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [aboutUSAlertController addAction:action];
    
    
    [self presentViewController:aboutUSAlertController animated:YES completion:nil];

    
    
}



//计算目录大小
- (CGFloat)floatWithPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *fullPath = [path stringByAppendingPathComponent:fileName];
            folderSize += [self fileSizeAtPath:fullPath];
            //把SDwebImage缓存也加上
            folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        }
    }
    return folderSize;
}


//计算单个文件大小
-(float)fileSizeAtPath:(NSString *)path{
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}

//清除缓存实现
- (void)clearPath {
    
    NSString *path = CACHEPATH;
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] clearDisk];

}


//缓存总大小
- (NSString *)checkCache {
    
//    dispatch_queue_t sqQueue2 = dispatch_queue_create("SQQUEUE", DISPATCH_QUEUE_CONCURRENT);
//    
//    dispatch_async(sqQueue2, ^{
//        
//        
//        
//    });
    

    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    float folderSize = [self floatWithPath:path];
    NSString *cache = [NSString stringWithFormat:@"%.2fM",folderSize];
    return cache;
}



//清除缓存
- (void)Clear {
    
    UIAlertController *clearCacheAlertController = [UIAlertController alertControllerWithTitle:@"当前缓存大小为,确认清除?" message:_cache preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *verifyAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        dispatch_queue_t sqQueue = dispatch_queue_create("SQQUEUE", DISPATCH_QUEUE_CONCURRENT);
        
        
        dispatch_async(sqQueue, ^{
              [self clearPath];
            self.cache = [self checkCache];
            
        });
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self clearDone];
            
        });
        
 
    }];
    
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消 " style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
   
    [clearCacheAlertController addAction:action];
    [clearCacheAlertController addAction:verifyAction];
    
    [self presentViewController:clearCacheAlertController animated:YES completion:nil];
    

    
    
}


- (void)clearDone {
    
    UIAlertController *clearDoneAlertController = [UIAlertController alertControllerWithTitle:@"清除完成" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [clearDoneAlertController addAction:action];
    
    
    [self presentViewController:clearDoneAlertController animated:YES completion:nil];
    
    self.cache = [self cache];
    
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
