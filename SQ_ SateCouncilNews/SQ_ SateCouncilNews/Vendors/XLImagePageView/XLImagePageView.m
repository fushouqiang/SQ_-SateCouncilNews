//
//  XLImagePageView.m
//  XLImagePageDemo
//
//  Created by FuShouqiang on 16/9/20.
//  Copyright © 2016年 fu. All rights reserved.
//

#import "XLImagePageView.h"
#import "XLImagePageDetailCell.h"
#import "UIImageView+XLWebCache.h"

@interface XLImagePageView ()<UICollectionViewDataSource, UICollectionViewDelegate, XLImagePageDetailCellDelegate>


@property (nonatomic, strong)UICollectionView *collectionView;


@end


@implementation XLImagePageView

- (void)dealloc {
    _collectionView.dataSource = nil;
    _collectionView.delegate = nil;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageArray = [NSMutableArray array];

        // Do any additional setup after loading the view.
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = self.bounds.size;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        self.collectionView.pagingEnabled = YES;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self addSubview:self.collectionView];
        
        [self.collectionView registerClass:[XLImagePageDetailCell class] forCellWithReuseIdentifier:@"imagePageDetail"];
    }
    return self;
}

- (void)XLImagePageDetailCellDidSelectedWithIndex:(NSInteger)cellIndex {
    if ([self.delegate respondsToSelector:@selector(XLImagePageView:didSelectPageAtIndex:)]) {
        [self.delegate XLImagePageView:self didSelectPageAtIndex:cellIndex];
    }
    
}


- (void)setImageArray:(NSArray *)imageArray {
    if (_imageArray != imageArray) {
        _imageArray = imageArray;
        [self.collectionView reloadData];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XLImagePageDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imagePageDetail" forIndexPath:indexPath];
    cell.delegate = self;
    cell.tag = 1000 + indexPath.row;
    if ([_imageArray[indexPath.item] isKindOfClass:[NSString class]]) {
        if ([_imageArray[indexPath.item] hasPrefix:@"http"]) {
            [cell.contentImageView xl_setImageWithURL:[NSURL URLWithString:_imageArray[indexPath.item]] placeholderImage:nil];
        } else if ([_imageArray[indexPath.item] hasPrefix:@"/"] || [_imageArray[indexPath.item] hasPrefix:@"file"]) {
            cell.contentImageView.image = [UIImage imageWithContentsOfFile:_imageArray[indexPath.item]];
        
        } else {
            cell.contentImageView.image = [UIImage imageNamed:_imageArray[indexPath.item]];
        }
    
    
    } else if ([_imageArray[indexPath.item] isKindOfClass:[NSURL class]]) {
        [cell.contentImageView xl_setImageWithURL:_imageArray[indexPath.item] placeholderImage:nil];
        
    } else if ([_imageArray[indexPath.item] isKindOfClass:[UIImage class]]) {
        cell.contentImageView.image = self.imageArray[indexPath.item];
    }
    
    
    
    
    
    return cell;
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat content = scrollView.contentOffset.x;
    if (content >= 0 && content <= scrollView.contentSize.width - [UIScreen mainScreen].bounds.size.width) {
        
        //    rect.size.width = [UIScreen mainScreen].bounds.size.width - content / 2;
        
        NSIndexPath *contentIndexPath = [NSIndexPath indexPathForItem:scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width inSection:0];
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width + 1 inSection:0];
        
        XLImagePageDetailCell *contentCell = (XLImagePageDetailCell *)[self.collectionView cellForItemAtIndexPath:contentIndexPath];
        XLImagePageDetailCell *nextCell = (XLImagePageDetailCell *)[self.collectionView cellForItemAtIndexPath:nextIndexPath];
        
        CGRect contentImageViewRect = contentCell.contentImageView.frame;
        CGRect nextImageViewRect = nextCell.contentImageView.frame;
        contentImageViewRect.origin.x = 0 + (content - contentIndexPath.item * [UIScreen mainScreen].bounds.size.width) / 3;
        nextImageViewRect.origin.x = 0 - [UIScreen mainScreen].bounds.size.width / 3 + (content - contentIndexPath.item * [UIScreen mainScreen].bounds.size.width) / 3;
        contentCell.contentImageView.frame = contentImageViewRect;
        nextCell.contentImageView.frame = nextImageViewRect;
    }
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
