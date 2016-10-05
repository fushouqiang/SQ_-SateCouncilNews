//
//  SQ_SectionHeadView.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/5.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_SectionHeadView.h"

@interface SQ_SectionHeadView ()


@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation SQ_SectionHeadView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        [label makeConstraints:^(MASConstraintMaker *make) {
        
            make.top.equalTo(self.top);
            make.right.equalTo(self.right).offset(-5);
            make.height.equalTo(2);
            make.left.equalTo(self.left).offset(5);
        }];
        label.backgroundColor =  [UIColor colorWithRed:0.034 green:0.495 blue:0.703 alpha:1.000];
        
        self.titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
        [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label.bottom).offset(5);
            make.height.equalTo(18);
            make.left.equalTo(self.left).offset(5);
            make.width.equalTo(WIDTH / 2);
        }];
        _titleLabel.textColor = [UIColor colorWithRed:0.034 green:0.495 blue:0.703 alpha:1.000];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        
        
    }
    return self;
}





- (void)setTitleText:(NSString *)titleText {
    
    
    if (_titleText != titleText) {
        _titleText = titleText;
    }
    _titleLabel.text = titleText;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
