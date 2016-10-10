//
//  SQ_DataChinaMoreCell.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/6.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_DataChinaMoreCell.h"

@implementation SQ_DataChinaMoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, WIDTH - 20, 40)];
        label.backgroundColor = [UIColor colorWithWhite:0.852 alpha:1.000];
        label.text = @"更多";
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
    }
    
    
    return self;
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
