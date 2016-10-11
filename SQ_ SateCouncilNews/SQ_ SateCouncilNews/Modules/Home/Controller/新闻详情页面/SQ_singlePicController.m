//
//  SQ_singlePicController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/10.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_singlePicController.h"
#import "SQ_pictureScrollView.h"
#import "JT3DScrollView.h"

@interface SQ_singlePicController ()
<
UIScrollViewDelegate
>
//图片scrollView
@property (nonatomic, strong) SQ_pictureScrollView *pic;
//下载按钮
@property (nonatomic, strong) __block UIButton *downloadButton;

@property (nonatomic, strong) __block UIButton *backButton;

@property (nonatomic, strong) JT3DScrollView *imageScrollView;
//单个图片scrollView数组
@property (nonatomic, strong) NSMutableArray *picScrollArray;

@property (nonatomic, assign) NSInteger position;
@end

@implementation SQ_singlePicController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_picUrlArray removeLastObject];
    
    //取出点击的图片地址在图片地址数组中的位置
    for (int i = 0; i < _picUrlArray.count; i++) {
        
        if ([_urlString isEqualToString:_picUrlArray[i]]) {
            _position = i;
        }
    }
     self.view.backgroundColor = [UIColor blackColor];
    
    
    //创建一个图片scrollView
    self.imageScrollView = [[JT3DScrollView alloc] initWithFrame:CGRectMake(0, 50, WIDTH, HEIGHT)];
    _imageScrollView.contentSize = CGSizeMake(_picUrlArray.count * WIDTH, HEIGHT );
    _imageScrollView.showsHorizontalScrollIndicator = NO;
    //scrollView翻页样式
    _imageScrollView.effect = 2;
    _imageScrollView.clipsToBounds = YES;
    _imageScrollView.delegate = self;
    _imageScrollView.backgroundColor = [UIColor blackColor];

    
    //初始化picCrollArray
    self.picScrollArray = [NSMutableArray array];
    for (int i = 0; i < _picUrlArray.count; i++) {
        //添加图片scrollView

        SQ_pictureScrollView *picScrollView = [[SQ_pictureScrollView alloc] initWithFrame:CGRectMake(WIDTH * i, 0, WIDTH, HEIGHT) urlString:_picUrlArray[i]];
        [_picScrollArray addObject:picScrollView];
        [_imageScrollView addSubview:picScrollView];

    }
    
    
    _imageScrollView.contentOffset = CGPointMake(_position * WIDTH, 0);
    
    [self.view addSubview:_imageScrollView];
    
    
    
//    _pic = [[SQ_pictureScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) urlString:_urlString];
//    [self.view addSubview:_pic];
    
    
    
    
    
    
    
    
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CGRectMake(10, 20, 60, 40);
    [_backButton setImage:[UIImage imageNamed:@"photoBackButton"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];

    
//    
    self.downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _downloadButton.frame = CGRectMake(WIDTH - 80, 20, 60, 40);
    [_downloadButton setImage:[UIImage imageNamed:@"photoDownload"] forState:UIControlStateNormal];
    [_downloadButton addTarget:self action:@selector(downLoadPic:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_downloadButton];

    
    
  
    
    // Do any additional setup after loading the view.
}


//返回按钮点击事件
- (void)backButton:(UIButton *)button {
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
}


//下载按钮点击事件
- (void)downLoadPic:(UIButton *)button {
    
    NSInteger i  = _imageScrollView.contentOffset.x / WIDTH;
    SQ_pictureScrollView *picScrollView = _picScrollArray[i];
    UIImageWriteToSavedPhotosAlbum(picScrollView.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}


// 成功保存图片到相册中, 必须调用此方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (!error) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        
        
        
        
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存失败!别保存了" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:nil];
        
        
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
