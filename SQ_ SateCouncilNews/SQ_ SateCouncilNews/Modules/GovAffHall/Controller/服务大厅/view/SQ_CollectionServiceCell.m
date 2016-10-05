//
//  SQ_CollectionServiceCell.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/3.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_CollectionServiceCell.h"

@interface SQ_CollectionServiceCell ()
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *myLabel;

@end

@implementation SQ_CollectionServiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setImageName:(NSString *)imageName {
    
    if (_imageName != imageName) {
        _imageName = imageName;
    }
    self.myImageView.image = [UIImage imageNamed:imageName];
    
}

- (void)setLabelText:(NSString *)labelText {
    
    if (_labelText != labelText) {
        _labelText = labelText;
    }
    _myLabel.text = _labelText;
    
}




@end
