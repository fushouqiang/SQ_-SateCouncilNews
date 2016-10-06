//
//  SQ_datacTopCell.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/5.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_datacTopCell.h"

@interface SQ_datacTopCell ()

@property (nonatomic, strong) UIImageView *myImageView;

@end

@implementation SQ_datacTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, self.contentView.bounds.size.width - 10, 180)];
        _myImageView.image = [UIImage imageNamed:@"hallDataBanner"];
        [self.contentView addSubview:_myImageView];
        _myImageView.userInteractionEnabled = YES;
        UIView *bacView =  [[UIView alloc] init];
        [_myImageView addSubview:bacView];
        [bacView makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(_myImageView.bottom);
            make.left.equalTo(_myImageView.left);
            make.right.equalTo(_myImageView.right);
            make.height.equalTo(50);
            
        }];
        bacView.backgroundColor = [UIColor colorWithWhite:0.399 alpha:0.418];
        
        UIButton *writeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        writeButton.tag = 1001;
        [bacView addSubview:writeButton];
        [writeButton makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(bacView.top).offset(10);
            make.left.equalTo(bacView.left).offset(10);
            make.bottom.equalTo(bacView.bottom).offset(-10);
            make.width.equalTo((WIDTH -50) / 3);
        }];
        [writeButton setTitle:@"GDP" forState:UIControlStateNormal];
        writeButton.backgroundColor = [UIColor whiteColor];
        writeButton.layer.cornerRadius = 10.0;
        [writeButton clipsToBounds];
        [writeButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        UIButton *writeBackButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [bacView addSubview:writeBackButton];
        writeBackButton.tag = 1002;
        [writeBackButton makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(bacView.top).offset(10);
            make.left.equalTo(writeButton.right).offset(10);
            make.bottom.equalTo(bacView.bottom).offset(-10);
            make.width.equalTo((WIDTH -50) / 3);
        }];
        
        [writeBackButton setTitle:@"CPI" forState:UIControlStateNormal];
        writeBackButton.backgroundColor = [UIColor whiteColor];
        writeBackButton.layer.cornerRadius = 10.0;
        [writeBackButton clipsToBounds];
        [writeBackButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *writeSelectButton = [UIButton buttonWithType:UIButtonTypeSystem];
        writeSelectButton.tag = 1003;
        [bacView addSubview:writeSelectButton];
        [writeSelectButton makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(bacView.top).offset(10);
            make.left.equalTo(writeBackButton.right).offset(10);
            make.bottom.equalTo(bacView.bottom).offset(-10);
            make.width.equalTo((WIDTH -50) / 3);
        }];
        
        [writeSelectButton setTitle:@"PPI" forState:UIControlStateNormal];
        writeSelectButton.backgroundColor = [UIColor whiteColor];
        writeSelectButton.layer.cornerRadius = 10.0;
        [writeSelectButton clipsToBounds];
        [writeSelectButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
    }
    
    
    
    
    
    
    
    return  self;
    
}


- (void)buttonClick:(UIButton *)button {
    
    
    
    if (_block) {
        
        self.block(button.tag - 1000);
    }
    
    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
