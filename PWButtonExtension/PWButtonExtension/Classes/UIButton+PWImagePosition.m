//
//  UIButton+PWImagePosition.m
//  PWButtonExtension
//
//  Created by admin_paul on 2020/1/8.
//  Copyright © 2020年 PaulWong. All rights reserved.
//

#import "UIButton+PWImagePosition.h"

@implementation UIButton (PWImagePosition)

- (void)layoutWithImagePositon:(PWButtonImagePositon)imagePositon imageTitleSpace:(CGFloat)space {
    UIEdgeInsets contentEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets titleEdgeInsets = UIEdgeInsetsZero;
    
    CGSize textSize = [self.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil].size;
    CGSize imageSize = self.imageView.bounds.size;
    
    CGFloat labelWidth  = textSize.width;
    CGFloat labelHeight = textSize.height;
    
    if (imagePositon == PWButtonImagePositonLeft || imagePositon == PWButtonImagePositonRight) {
        if (self.bounds.size.width - imageSize.width - textSize.width < space) {
            space = self.bounds.size.width - imageSize.width - textSize.width;
        }
    }else{
        if (self.bounds.size.height - imageSize.height - textSize.height < space) {
            space = self.bounds.size.height - imageSize.height - textSize.height;
        }
    }
    
    CGFloat imageOffsetX = (imageSize.width + labelWidth)/2 - imageSize.width/2;
    CGFloat imageOffsetY = imageSize.height /2 + space/2;
    CGFloat labelOffsetX = (imageSize.width + labelWidth/2) - (imageSize.width + labelWidth)/2;
    CGFloat labelOffsetY = labelHeight/2 + space/2;
    
    CGFloat changedWidth  = labelWidth + imageSize.width - MAX(labelWidth, imageSize.width);
    CGFloat changedHeight = labelHeight + imageSize.height + space - MAX(labelHeight, imageSize.height);
    
    switch (imagePositon) {
        case PWButtonImagePositonLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2, 0, space/2);
            titleEdgeInsets = UIEdgeInsetsMake(0, space/2, 0, -space/2);
            contentEdgeInsets = UIEdgeInsetsMake(0, space/2, 0, space/2);
        }
            break;
        case PWButtonImagePositonRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + space/2, 0, -(labelWidth + space/2));
            titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + space/2), 0, imageSize.width + space/2);
            contentEdgeInsets = UIEdgeInsetsMake(0, space/2, 0, space/2);
        }
            break;
        case PWButtonImagePositonTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            contentEdgeInsets = UIEdgeInsetsMake(imageOffsetY, -changedWidth/2, changedHeight-imageOffsetY, -changedWidth/2);
        }
            break;
        case PWButtonImagePositonBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            contentEdgeInsets = UIEdgeInsetsMake(changedHeight-imageOffsetY, -changedWidth/2, imageOffsetY, -changedWidth/2);
        }
            break;
        default:
            break;
    }
    self.imageEdgeInsets = imageEdgeInsets;
    self.titleEdgeInsets = titleEdgeInsets;
    self.contentEdgeInsets = contentEdgeInsets;
}

@end
