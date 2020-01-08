//
//  UIButton+PWCountDown.m
//  PWButtonExtension
//
//  Created by admin_paul on 2020/1/8.
//  Copyright © 2020年 PaulWong. All rights reserved.
//

#import "UIButton+PWCountDown.h"
#import <objc/runtime.h>

static const char *kUseableColor = "useableColor";
static const char *KUnusableColor = "unusableColor";
static const char *kCountDownTimer = "countDownTimer";

@implementation UIButton (PWCountDown)

- (void)startCountDownWithTitle:(NSString *)title times:(NSInteger)times {
    self.userInteractionEnabled = NO;
    __block NSString *currentTitle = self.currentTitle;
    __block NSInteger timeout = times > 0 ? times : 59;
    __block NSString *countDownTitle = title;
    if (!self.useableColor) {
        self.useableColor = self.currentTitleColor;
    }
    if (!self.countDownTimer) {
        self.countDownTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
        dispatch_source_set_timer(self.countDownTimer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
        dispatch_source_set_event_handler(self.countDownTimer, ^{
            if(timeout <= 0){
                dispatch_source_cancel(self.countDownTimer);
                self.countDownTimer = nil;
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.userInteractionEnabled = YES;
                    [self setTitle:currentTitle forState:UIControlStateNormal];
                    [self setTitleColor:self.useableColor forState:UIControlStateNormal];
                });
            }else{
                int seconds = timeout % 60;
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (countDownTitle) {
                        [self setTitle:[NSString stringWithFormat:@"%@%ds",countDownTitle,seconds] forState:UIControlStateNormal];
                    }else{
                        [self setTitle:[NSString stringWithFormat:@"%ds",seconds] forState:UIControlStateNormal];
                    }
                    if (self.unusableColor && !CGColorEqualToColor(self.currentTitleColor.CGColor, self.unusableColor.CGColor)) {
                        [self setTitleColor:self.unusableColor forState:UIControlStateNormal];
                    }
                });
                timeout--;
            }
        });
    }
    dispatch_resume(self.countDownTimer);
}

- (void)destoryTimer {
    if (self.countDownTimer) {
        dispatch_source_cancel(self.countDownTimer);
        self.countDownTimer = nil;
    }
}

- (void)setCountDownTimer:(dispatch_source_t)countDownTimer {
    objc_setAssociatedObject(self, kCountDownTimer, countDownTimer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (dispatch_source_t)countDownTimer {
    return objc_getAssociatedObject(self, kCountDownTimer);
}

- (void)setUseableColor:(UIColor *)useableColor {
    objc_setAssociatedObject(self, kUseableColor, useableColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)useableColor {
    return objc_getAssociatedObject(self, kUseableColor);
}

- (void)setUnusableColor:(UIColor *)unusableColor {
    objc_setAssociatedObject(self, KUnusableColor, unusableColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)unusableColor {
    return objc_getAssociatedObject(self, KUnusableColor);
}

@end
