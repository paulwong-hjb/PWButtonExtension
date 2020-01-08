//
//  UIButton+PWResponseRange.m
//  PWButtonExtension
//
//  Created by admin_paul on 2020/1/8.
//  Copyright © 2020年 PaulWong. All rights reserved.
//

#import "UIButton+PWResponseRange.h"
#import <objc/runtime.h>

static const char *kResponseRangeScale = "responseRangeScale";
static const char *kResponseEdgeInset  = "responseEdgeInset";
static const char *kHorizontalScale    = "horizontalScale";
static const char *kVerticalScale      = "verticalScale";

@implementation UIButton (PWResponseRange)

//重载系统方法 改变响应区域
// default returns YES if point is in bounds
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (UIEdgeInsetsEqualToEdgeInsets(self.responseEdgeInset, UIEdgeInsetsZero) ||
        !self.userInteractionEnabled  ||
        !self.enabled                 ||
        self.hidden                   ||
        self.alpha == 0){
        return [super pointInside:point withEvent:event];
    }else{
        CGRect responseFrame = UIEdgeInsetsInsetRect(self.bounds, self.responseEdgeInset);
        return CGRectContainsPoint(responseFrame, point);
    }
}

#pragma mark - SET方法实现
- (void)setResponseEdgeInset:(UIEdgeInsets)responseEdgeInset {
    NSValue *value = [NSValue value:&responseEdgeInset withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, kResponseEdgeInset, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setResponseRangeScale:(CGFloat)responseRangeScale {
    [self.superview layoutIfNeeded];
    CGFloat width  = -self.bounds.size.width * responseRangeScale;
    CGFloat height = -self.bounds.size.height * responseRangeScale;
    self.responseEdgeInset = UIEdgeInsetsMake(height, width, height, width);
    NSNumber *number = [NSNumber numberWithFloat:responseRangeScale];
    objc_setAssociatedObject(self, kResponseRangeScale, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setHorizontalScale:(CGFloat)horizontalScale {
    [self.superview layoutIfNeeded];
    CGFloat width  = -self.bounds.size.width * horizontalScale;
    self.responseEdgeInset = UIEdgeInsetsMake(0, width, 0, width);
    NSNumber *number = [NSNumber numberWithFloat:horizontalScale];
    objc_setAssociatedObject(self, kHorizontalScale, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setVerticalScale:(CGFloat)verticalScale {
    [self.superview layoutIfNeeded];
    CGFloat height = -self.bounds.size.height * verticalScale;
    self.responseEdgeInset = UIEdgeInsetsMake(height, 0, height, 0);
    NSNumber *number = [NSNumber numberWithFloat:verticalScale];
    objc_setAssociatedObject(self, kVerticalScale, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - GET方法实现
-(UIEdgeInsets)responseEdgeInset {
    NSValue *value = objc_getAssociatedObject(self, kResponseEdgeInset);
    if (value) {
        UIEdgeInsets edgeInsets;
        [value getValue:&edgeInsets];
        return edgeInsets;
    }
    return UIEdgeInsetsZero;
}

- (CGFloat)responseRangeScale {
    NSNumber *number = objc_getAssociatedObject(self, kResponseRangeScale);
    if (number) {
        return [number floatValue];
    }
    return 0;
}

- (CGFloat)horizontalScale {
    NSNumber *number = objc_getAssociatedObject(self, kHorizontalScale);
    if (number) {
        return [number floatValue];
    }
    return 0;
}

- (CGFloat)verticalScale {
    NSNumber *number = objc_getAssociatedObject(self, kVerticalScale);
    if (number) {
        return [number floatValue];
    }
    return 0;
}

@end
