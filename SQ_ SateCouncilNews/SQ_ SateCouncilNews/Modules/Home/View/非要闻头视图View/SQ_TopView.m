//
//  SQ_TopView.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/22.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_TopView.h"

#define MAS_SHORTHAND_GLOBALS
#define MAS_SHORTHAND

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#import "Masonry.h"

@interface SQ_TopView ()

@property (nonatomic, retain) UILabel *textLabel;
@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *signImageView;

@end

@implementation SQ_TopView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.textLabel = [[UILabel alloc] init];
        [self addSubview:_textLabel];
        [_textLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.left).offset(10);
            make.right.equalTo(self.right).offset(-10);
            make.top.equalTo(self.top);
            make.bottom.equalTo(self.bottom).offset(-30);
            
        }];
        _textLabel.backgroundColor = [UIColor blackColor];
        
        self.timeLabel = [[UILabel alloc] init];
        [self addSubview:_timeLabel];
        [_timeLabel makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.left).offset(10);
            make.width.equalTo(WIDTH / 3);
            make.height.equalTo(20);
            make.top.equalTo(_textLabel.bottom).offset(3);
            
        }];
        _timeLabel.backgroundColor = [UIColor redColor];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
