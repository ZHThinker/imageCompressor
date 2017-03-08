//
//  UIImage+Compresser.h
//  compressImage
//
//  Created by 张衡 on 2017/3/7.
//  Copyright © 2017年 张衡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Compresser)

- (UIImage *)compressWithTargetPixel:(NSUInteger)targetPx;
@end
