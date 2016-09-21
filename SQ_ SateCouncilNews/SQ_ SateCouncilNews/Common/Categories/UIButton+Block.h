//
//  UIButton+Block.h
//  SQ_ SateCouncilNews
//
//  Created by FuShouqiang on 16/9/20.
//  Copyright © 2016年 fu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^Callback)();

@interface UIButton (Block)

- (void)handleControlEvent:(UIControlEvents)controlEvent withBlock:(Callback)block;

@end
