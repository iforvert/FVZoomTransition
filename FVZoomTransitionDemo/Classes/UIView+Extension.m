//
//  UIView+Extension.m
//  FVZoomTransitionDemo
//
//  Created by iforvert on 2017/5/24.
//  Copyright © 2017年 iforvert. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (UIImage *)toUIImage
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* retImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return retImage;
}

@end
