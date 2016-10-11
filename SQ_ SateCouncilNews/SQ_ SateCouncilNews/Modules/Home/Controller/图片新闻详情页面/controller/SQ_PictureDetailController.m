//
//  SQ_PictureDetailController.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/28.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_PictureDetailController.h"
#import "HttpClient.h"
#import "SQ_Article.h"
#import "NSObject+YYModel.h"
#import "SQ_Detail.h"
#import "SQ_Picture.h"
#import "JT3DScrollView.h"
#import "SQ_pictureScrollView.h"
#import "UILabel+SizeToFit_W_H.h"


@interface SQ_PictureDetailController ()
<
UIScrollViewDelegate
>

typedef void (^JsonSuccess)(id json);
//图片模型数组
@property (nonatomic, strong) NSMutableArray *pictureArray;
//图片总scrollView
@property (nonatomic, strong) JT3DScrollView *imageScrollView;
//单个图片scrollView数组
@property (nonatomic, strong) NSMutableArray *picScrollArray;
//下载按钮
@property (nonatomic, strong) __block UIButton *downloadButton;
//返回按钮
@property (nonatomic, strong) __block UIButton *backButton;
//图片文字内容
@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation SQ_PictureDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self createImageScrollView];
    [self createBackButton];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//创建按钮
- (void)createBackButton {
    

    
    self.downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _downloadButton.frame = CGRectMake(WIDTH - 80, 20, 60, 40);
    [_downloadButton setImage:[UIImage imageNamed:@"photoDownload"] forState:UIControlStateNormal];
    [_downloadButton addTarget:self action:@selector(downLoadPic:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_downloadButton];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CGRectMake(10, 20, 60, 40);
    [_backButton setImage:[UIImage imageNamed:@"photoBackButton"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];
    
  
}

//返回按钮点击事件
- (void)backButton:(UIButton *)button {
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
}








//创建图片总ScrollView
- (void)createImageScrollView {
    
    if (_imageScrollView == nil) {
        
        self.imageScrollView = [[JT3DScrollView alloc] initWithFrame:CGRectMake(0, 50, WIDTH, HEIGHT)];
        _imageScrollView.contentSize = CGSizeMake(_pictureArray.count * WIDTH, HEIGHT );
        _imageScrollView.showsHorizontalScrollIndicator = NO;
        //scrollView翻页样式
        _imageScrollView.effect = 2;
        _imageScrollView.clipsToBounds = YES;
        _imageScrollView.delegate = self;
        _imageScrollView.backgroundColor = [UIColor blackColor];
    }
    self.picScrollArray = [NSMutableArray array];
    
    for (int i = 0; i < _pictureArray.count; i++) {
        //添加图片scrollView
        SQ_Picture *pic = _pictureArray[i];
        NSString *urlString = [NSString stringWithFormat:@"http://app.www.gov.cn/govdata/gov/%@",pic.file];
        SQ_pictureScrollView *picScrollView = [[SQ_pictureScrollView alloc] initWithFrame:CGRectMake(WIDTH * i, 0, WIDTH, HEIGHT - 64) urlString:urlString];
        [_picScrollArray addObject:picScrollView];
        [_imageScrollView addSubview:picScrollView];
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, HEIGHT - 200, WIDTH * 0.7, 120)];
        label.text = pic.des;
        //如果label文字为空  就隐藏
        if ([label.text isEqualToString:@""]) {
            
            label.hidden = YES;
        }
        
        label.font = [UIFont fontWithName:@"Helvetica" size:12];
        label.backgroundColor = [UIColor colorWithWhite:0.463 alpha:1];
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 8;
        [picScrollView addSubview:label];
        
        
        
        
        //单个图片scrollView点击block回调
        picScrollView.singleTapBlock = ^{
            
            label.hidden = !label.hidden;
            _backButton.hidden = label.hidden;
            _downloadButton.hidden = label.hidden;
            
        };
        
//        picScrollView.doubleTapBlock = ^{
//            
//            if (label.hidden == NO) {
//                label.hidden = YES;
//            } else if (label.hidden == YES) {
//                label.hidden = NO;
//            }
//            
//        };
      
       
    }
    
    
    
    [self.view addSubview:_imageScrollView];
}

//图片保存到相册
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

- (void)getJsonWithUrlString:(NSString *)urlString json:(JsonSuccess)json{
    
    
    
    
    [HttpClient getWithUrlString:urlString success:^(id data) {
        NSString *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        json(dic);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}




- (void)setArticle:(SQ_Article *)article {
    
    if (_article != article) {
        _article = article;
        self.pictureArray = [NSMutableArray array];
        NSDictionary *dic = article.pictures;
        NSArray *array = [dic allKeys];
        NSMutableArray *picArray = [NSMutableArray array];
        for (int i = 0; i < array.count; i++) {
            SQ_Picture *picture = [SQ_Picture yy_modelWithDictionary:[dic valueForKey:array[i]]];
            [picArray addObject:picture];
        }
        
        for (int i = 0; i < picArray.count; i++) {
            for (SQ_Picture *pic in picArray) {
                if ([pic.position intValue] == i) {
                    
                    [self.pictureArray addObject:pic];
                }
                
            }
        }
        

        
        
        
        
    }
    
    
}


@end
