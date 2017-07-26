//
//  UIView+Sinp.m
//  FVZoomTransitionDemo
//
//  Created by iforvert on 2017/7/27.
//  Copyright © 2017年 iforvert. All rights reserved.
//

#import "UIView+Sinp.h"

@implementation UIView (Sinp)

- (UIImage *)fv_takeSnapshot
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:ctx];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshot;
}

@end
