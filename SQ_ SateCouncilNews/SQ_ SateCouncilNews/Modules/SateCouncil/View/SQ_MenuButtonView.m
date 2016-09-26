//
//  SQ_MenuButtonView.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/26.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_MenuButtonView.h"
#define MAS_SHORTHAND_GLOBALS
#define MAS_SHORTHAND

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#import "Masonry.h"
#import "UIButton+Block.h"

@interface SQ_MenuButtonView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@end
@implementation SQ_MenuButtonView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        [_imageView makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.width);
            make.left.equalTo(self.left);
            make.top.equalTo(self.top);
            make.height.equalTo(50);
            
        }];
        

        
        self.label = [[UILabel alloc] init];
        [self addSubview:_label];
        [_label makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(self.width);
            make.left.equalTo(self.left);
            make.top.equalTo(_imageView.bottom);
            make.height.equalTo(20);
            
        }];
        _label.textColor = [UIColor colorWithWhite:0.729 alpha:1.000];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    if (_image != image) {
        _image = image;
        
        _imageView.image = image;
    }
}

- (void)setTitle:(NSString *)title {
    if (_title != title) {
        _title = title;
        _label.text = title;
    }
}

@end
