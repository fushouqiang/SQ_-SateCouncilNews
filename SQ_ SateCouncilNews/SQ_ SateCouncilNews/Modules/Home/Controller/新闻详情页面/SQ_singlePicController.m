//
//  SQ_singlePicController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/10.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_singlePicController.h"
#import "SQ_pictureScrollView.h"

@interface SQ_singlePicController ()
//图片scrollView
@property (nonatomic, strong) SQ_pictureScrollView *pic;
//下载按钮
@property (nonatomic, strong) __block UIButton *downloadButton;
@end

@implementation SQ_singlePicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _pic = [[SQ_pictureScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) urlString:_urlString];
    [self.view addSubview:_pic];
    
    self.downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _downloadButton.frame = CGRectMake(WIDTH - 80, 60, 60, 40);
    [_downloadButton setImage:[UIImage imageNamed:@"photoDownload"] forState:UIControlStateNormal];
    [_downloadButton addTarget:self action:@selector(downLoadPic:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:_downloadButton aboveSubview:_pic];

    
    
  
    
    // Do any additional setup after loading the view.
}

- (void)downLoadPic:(UIButton *)button {
    
    UIImageWriteToSavedPhotosAlbum(_pic.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
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
