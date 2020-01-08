//
//  UIButton+PWCountDown.h
//  PWButtonExtension
//
//  Created by admin_paul on 2020/1/8.
//  Copyright © 2020年 PaulWong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (PWCountDown)

/**
 可用状态字体颜色颜色 如不设置则为默认字体颜色
 */
@property (nonatomic,strong) UIColor *useableColor;

/**
 不可用状态颜色 如不设置则为默认字体颜色
 */
@property (nonatomic,strong) UIColor *unusableColor;

/**
 gcd 定时器
 */
@property (nonatomic,strong) dispatch_source_t __nullable countDownTimer;

/**
 开启倒计时
 
 @param title 倒计时title不包含秒、如果设置nil则title只显示秒
 @param times 倒计时时间  默认值60
 */
- (void)startCountDownWithTitle:(NSString *)title times:(NSInteger)times;


/**销毁定时器*/
- (void)destoryTimer;


@end

NS_ASSUME_NONNULL_END
