//
//  SQ_MemberCell.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/26.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_MemberCell.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface SQ_MemberCell ()

@property (nonatomic, strong) UILabel *leaderLabel;
@property (nonatomic, strong) UILabel *memberLabel;
@property (nonatomic, strong) UIButton *button;

@end

@implementation SQ_MemberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    

}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.leaderLabel = [[UILabel alloc] init];
        _leaderLabel.font = [UIFont systemFontOfSize:14];
        _leaderLabel.textAlignment = NSTextAlignmentCenter;
        _leaderLabel.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
        [self.contentView addSubview:_leaderLabel];
        
        self.memberLabel = [[UILabel alloc] init];
        _memberLabel.font = [UIFont systemFontOfSize:14];
        _memberLabel.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];;
        [self.contentView addSubview:_memberLabel];
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"查看跟多" forState:UIControlStateNormal];
        _button.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];;
        [self.contentView addSubview:_button];
        [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}


- (void)buttonAction:(UIButton *)button {
    
    //每次点击将model的isShowText属性取反
    self.member.isShowText = !self.member.isShowText;
    if (_showMoreTextBlock) {
        self.showMoreTextBlock(self);
 
    }
    
 
    
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    
    self.leaderLabel.frame = CGRectMake(20, 0, WIDTH - 40, 40);
    _leaderLabel.textColor = [UIColor colorWithRed:0.111 green:0.486 blue:0.885 alpha:1.000];
    if (self.member.isShowText) {
        
        _memberLabel.frame = CGRectMake(20, 45, WIDTH - 40, 470);
        _button.frame = CGRectMake(20, 525, WIDTH - 40, 30);
        [_button setTitle:@"收起" forState:UIControlStateNormal];
    }
    else {
        
        _memberLabel.frame = CGRectMake(20, 45, WIDTH - 40, 65);
        _button.frame = CGRectMake(20, 115, WIDTH - 40, 30);
        [_button setTitle:@"查看跟多" forState:UIControlStateNormal];
    }

}








- (void)setMember:(SQ_Member *)member {
    
    if (_member != member) {
        
        _member = member;
        _leaderLabel.text = member.leadText;
        NSArray *array = member.memberArray;
        
        _memberLabel.numberOfLines = array.count;
        NSString *str = @"";
        for (int i = 0; i < array.count; i++) {
            
            str = [str stringByAppendingString:array[i]];
            if (i < (array.count - 1)) {
               str = [str stringByAppendingString:@"\n"];
            }
            
        }
        _memberLabel.textAlignment = NSTextAlignmentCenter;
        _memberLabel.text = str;

        
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
