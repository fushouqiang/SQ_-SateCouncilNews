//
//  NSArray+Categories.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/20.
//  Copyright © 2016年 fu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NSComparisonResult	(^NSMutableArrayCompareBlock)( id left, id right );

@interface NSArray (Categories)

/**
 *  非空校验（nil或者元素个数为0）
 *
 *  @return 是否为空
 */
+(BOOL)isEmpty:(NSArray *)array;

@end

@interface NSArray (Safe)

- (id)safeObjectAtIndex:(NSInteger)index;
- (NSArray *)safeSubarrayWithRange:(NSRange)range;

@end

@interface NSMutableArray (Sort)

- (void)sort;
- (void)sort:(NSMutableArrayCompareBlock)compare;

@end
