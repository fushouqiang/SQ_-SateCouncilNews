//
//  MyCollectionViewCell.h
//  Animation
//
//  Created by FuShouqiang on 16/9/20.
//  Copyright © 2016年 fu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XLImagePageDetailCellDelegate <NSObject>

- (void)XLImagePageDetailCellDidSelectedWithIndex:(NSInteger)cellIndex;

@end


@interface XLImagePageDetailCell : UICollectionViewCell

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *contentImageView;
@property (nonatomic, weak) id<XLImagePageDetailCellDelegate>delegate; 

@end
