//
//  UIButton+PWAction.h
//  PWButtonExtension
//
//  Created by admin_paul on 2020/1/8.
//  Copyright © 2020年 PaulWong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (PWAction)

/**
 重复点击时间间隔
 */
@property (nonatomic,assign) NSTimeInterval eventInterval;

/**
 用于计算时间的临时变量
 */
@property (nonatomic,assign) NSTimeInterval tempEventInterval;

@end

NS_ASSUME_NONNULL_END
