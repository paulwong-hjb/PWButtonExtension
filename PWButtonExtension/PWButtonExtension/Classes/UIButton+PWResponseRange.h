//
//  UIButton+PWResponseRange.h
//  PWButtonExtension
//
//  Created by admin_paul on 2020/1/8.
//  Copyright © 2020年 PaulWong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (PWResponseRange)

/**
 自定义响应区域  UIEdgeInsetsMake(-20, -20, -20, -20); 响应区域增大
 */
@property (nonatomic,assign) UIEdgeInsets responseEdgeInset;

/**
 按比例设置响应区域
 */
@property (nonatomic,assign) CGFloat      responseRangeScale;

/**
 平响应比例
 */
@property (nonatomic,assign) CGFloat      horizontalScale;

/**
 垂直响应比例
 */
@property (nonatomic,assign) CGFloat      verticalScale;


@end

NS_ASSUME_NONNULL_END
