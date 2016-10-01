//
//  SQ_StructureCell.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/27.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_StructureCell.h"
@interface SQ_StructureCell ()

@property (nonatomic, strong) UIImageView *structImageView;
@property (nonatomic, strong) UILabel *structLabel;
@end

@implementation SQ_StructureCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        
//        UILabel *backLabel = [[UILabel alloc] init];        
        self.structLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_structLabel];
        self.structImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_structImageView];
        _structImageView.image = [UIImage imageNamed:@"menu1"];
        _structLabel.text = @"国务院组织结构图";
        _structLabel.textColor = [UIColor colorWithRed:0.111 green:0.486 blue:0.885 alpha:1.000];
        _structLabel.font = [UIFont systemFontOfSize:14];
        
        
        
    }
    
    return self;
    
}

- (void)layoutSubviews {
    
    [_structImageView makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.left).offset(WIDTH * 0.2);
        make.width.equalTo(40);
        make.height.equalTo(30);
        make.top.equalTo(self.contentView.top).offset(5);
        
    }];
    
    [_structLabel makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_structImageView.right).offset(10);
        make.top.equalTo(self.contentView.top).equalTo(10);
        make.height.equalTo(20);
        make.right.equalTo(self.contentView.right).offset( - WIDTH * 0.2);
        
    }];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
