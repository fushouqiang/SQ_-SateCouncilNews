//
//  SQ_categoriesCell.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/3.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_categoriesCell.h"

@interface SQ_categoriesCell ()
@property (weak, nonatomic) IBOutlet UILabel *myLabel;

@end

@implementation SQ_categoriesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setLabelText:(NSString *)labelText {
    
    
    if (_labelText != labelText) {
        _labelText = labelText;
    }
    
    _myLabel.text = labelText;
    
}

@end
