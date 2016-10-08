//
//  SQ_LeftCell.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/24.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_LeftCell.h"
#import <DKNightVersion/DKNightVersion.h>
@interface SQ_LeftCell ()

@property (nonatomic, strong) UIImageView *settingImageView;
@property (nonatomic, strong) UILabel *settingTextLabel;

@end
@implementation SQ_LeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.settingImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_settingImageView];
        [_settingImageView makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView.left);
            make.width.equalTo(20);
            make.height.equalTo(20);
            make.top.equalTo(self.contentView.top).offset(5);
        }];
        
        self.settingTextLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_settingTextLabel];
        _settingTextLabel.textColor = [UIColor whiteColor];


        [_settingTextLabel makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_settingImageView.right);
            make.width.equalTo(120);
            make.height.equalTo(20);
            make.top.equalTo(self.contentView.top).offset(5);
            
        }];
//        _settingTextLabel.backgroundColor = [UIColor redColor];
        
    }
    return  self;
}

- (void)setImageName:(NSString *)imageName {
    if (_imageName != imageName) {
        _imageName = imageName;
        _settingImageView.image = [UIImage imageNamed:imageName];
    }
}

- (void)setLabelText:(NSString *)labelText {
    if (_labelText != labelText) {
        _labelText = labelText;
        _settingTextLabel.text = labelText;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
