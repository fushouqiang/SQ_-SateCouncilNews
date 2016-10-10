//
//  SQ_CollectionViewCell.m
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/10/1.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "SQ_CollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface SQ_CollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *title;


@end

@implementation SQ_CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setIcon:(SQ_icon *)icon {
    
    if (_icon != icon) {
        _icon = icon;
    }
    
    NSString *urlString = [NSString stringWithFormat:@"http://app.www.gov.cn/govdata/html/%@",icon.icon];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"hallMinistryIconLoading"] options:SDWebImageRetryFailed];
    _title.text = icon.name;
}




@end
