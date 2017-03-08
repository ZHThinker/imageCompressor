//
//  UIImage+Compresser.m
//  compressImage
//
//  Created by 张衡 on 2017/3/7.
//  Copyright © 2017年 张衡. All rights reserved.
//

#import "UIImage+Compresser.h"

@implementation UIImage (Compresser)

- (UIImage *)compressWithTargetPixel:(NSUInteger)targetPx {
    
    UIImage *newImage = nil;
    
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width * self.scale;
    CGFloat height = imageSize.height * self.scale;
    
    // 是否重绘
    BOOL drawImge = NO;
    
    // 压缩后的尺寸
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetPx;
    CGFloat scaledHeight = targetPx;
    
    // 1. 图片宽高均 ≤ 参照像素，图片尺寸保持不变
    if (width <= targetPx && height <= targetPx) {
        newImage = self;
    }
    
    // 2. 宽或高均 ＞ 参照像素
    else if (width > targetPx && height > targetPx) {
        
        drawImge = YES;
        CGFloat factor = width / height;
        
        if (factor <= 2) {
            // 2.1 图片宽高比 ≤ 2，则将图片宽或者高取大的等比压缩至1280px
            if (width > height) {
                scaleFactor  = targetPx / width;
            } else {
                scaleFactor = targetPx / height;
            }
        } else {
            // 2.2 图片宽高比 ＞ 2时，则宽或者高取小的等比压缩至1280px
            if (width > height) {
                scaleFactor  = targetPx / height;
            } else {
                scaleFactor = targetPx / width;
            }
        }
    }
    
    // 3. 宽高一个 ＞= 1280px，另一个 ＜ 1280px; 宽 >= 1280
    else if (width >= targetPx && height < targetPx ) {
        if (width / height > 2) {
            newImage = self;
        } else {
            drawImge = YES;
            scaleFactor = targetPx / width;
        }
    }
    // 4. 宽高一个 ＞= 1280px，另一个 ＜ 1280px 高 >= 1280
    else if (width < targetPx &&  height >= targetPx) {
        if (height / width > 2) {
            newImage = self;
        } else {
            drawImge = YES;
            scaleFactor = targetPx / height;
        }
    }
    
    if (drawImge == YES) {
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(scaledWidth/self.scale, scaledHeight/self.scale), YES, [UIScreen mainScreen].scale);
        [self drawInRect:CGRectMake(0, 0, scaledWidth/self.scale, scaledHeight/self.scale)];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    if (newImage == nil) {
        newImage = self;
    }
    
    newImage = [UIImage imageWithData:UIImageJPEGRepresentation(newImage, 0.7) scale:newImage.scale];
    
    return newImage;
}
@end
