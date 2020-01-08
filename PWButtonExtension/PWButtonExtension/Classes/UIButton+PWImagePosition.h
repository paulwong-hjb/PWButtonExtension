//
//  UIButton+PWImagePosition.h
//  PWButtonExtension
//
//  Created by admin_paul on 2020/1/8.
//  Copyright © 2020年 PaulWong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, PWButtonImagePositon) {
    PWButtonImagePositonLeft,
    PWButtonImagePositonRight,
    PWButtonImagePositonTop,
    PWButtonImagePositonBottom,
};

@interface UIButton (PWImagePosition)

/**
 图文布局
 
 @param imagePositon 布局类型
 @param space 图片文字间距
 */
- (void)layoutWithImagePositon:(PWButtonImagePositon)imagePositon imageTitleSpace:(CGFloat)space;

@end

NS_ASSUME_NONNULL_END
