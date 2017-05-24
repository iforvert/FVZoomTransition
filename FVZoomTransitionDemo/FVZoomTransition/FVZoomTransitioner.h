//
//  FVZoomTransitioner.h
//  FVZoomTransitionDemo
//
//  Created by iforvert on 2017/5/24.
//  Copyright © 2017年 iforvert. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FVZoomTransitionerDelegate <NSObject>

@optional

- (UIImage *)snapshot;
- (void)setCoverCard:(UIView *)view;

@end

@interface FVZoomTransitioner : NSObject <UINavigationControllerDelegate>

@property (nonatomic, strong) UIView *transitCard;

@end
