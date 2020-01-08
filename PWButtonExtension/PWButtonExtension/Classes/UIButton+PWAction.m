//
//  UIButton+PWAction.m
//  PWButtonExtension
//
//  Created by admin_paul on 2020/1/8.
//  Copyright © 2020年 PaulWong. All rights reserved.
//

#import "UIButton+PWAction.h"
#import <objc/runtime.h>
static const char *kEventInterval       = "eventInterval";
static const char *kTempEventInterval   = "tempEventInterval";

@implementation UIButton (PWAction)

+ (void)load {
    MethodSwizzle(self, @selector(sendAction:to:forEvent:), @selector(override_sendAction:to:froEvent:));
}

void MethodSwizzle(Class selfClass,SEL officialSelector,SEL swizzledSelector) {
    Method officialMethod = class_getInstanceMethod(selfClass, officialSelector);
    Method swizzledMethod = class_getInstanceMethod(selfClass, swizzledSelector);
    BOOL addMethodFlag = class_addMethod(selfClass,officialSelector,method_getImplementation(swizzledMethod),method_getTypeEncoding(swizzledMethod));
    if (addMethodFlag) {
        class_replaceMethod(selfClass,swizzledSelector,method_getImplementation(officialMethod),method_getTypeEncoding(officialMethod));
    }else{
        method_exchangeImplementations(officialMethod, swizzledMethod);
    }
}

- (void)setEventInterval:(NSTimeInterval)eventInterval {
    objc_setAssociatedObject(self, kEventInterval, @(eventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)eventInterval {
    NSNumber *number = objc_getAssociatedObject(self, kEventInterval);
    return [number doubleValue];
}

- (void)setTempEventInterval:(NSTimeInterval)tempEventInterval {
    objc_setAssociatedObject(self, kTempEventInterval, @(tempEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)tempEventInterval {
    NSNumber *number = objc_getAssociatedObject(self, kTempEventInterval);
    return [number doubleValue];
}

- (void)override_sendAction:(SEL)action to:(id)target froEvent:(UIEvent *)event {
    if ([NSDate date].timeIntervalSince1970 - self.tempEventInterval < self.eventInterval) {
        return;
    }
    if (self.eventInterval > 0) {
        self.tempEventInterval = [NSDate date].timeIntervalSince1970;
    }
    [self override_sendAction:action to:target froEvent:event];
}

@end
