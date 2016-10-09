//
//  SQ_FileSearchCell.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/9.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_FileSearchCell.h"

@implementation SQ_FileSearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *bacView = [[UIView alloc] init];
        [self.contentView addSubview:bacView];
        [bacView makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.contentView.top);
            make.left.equalTo(self.contentView.left).offset(10);
            make.width.equalTo(WIDTH - 20);
            make.bottom.equalTo(self.contentView.bottom);
        }];
        
        bacView.backgroundColor = [UIColor colorWithRed:0.593 green:0.702 blue:0.777 alpha:1.000];
    }
    
    return  self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
