//
//  FVZoomTransition.h
//  FVZoomTransitionDemo
//
//  Created by iforvert on 2017/7/26.
//  Copyright © 2017年 iforvert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FVZoomTransitionProtocol.h"

@interface FVZoomTransition : UIPercentDrivenInteractiveTransition<UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning>

@property (nonatomic, weak) UINavigationController *navigationController;
@property (nonatomic, assign) NSTimeInterval transitionDuration;
@property (nonatomic, assign) BOOL handleEdgePanBackGesture;
@property (nonatomic, assign) UIViewKeyframeAnimationOptions transitionAnimationOption;

- (instancetype)initWithNavigationController:(UINavigationController *)nc;

/**
 * 调用该方法用于恢复nc的代理
 */
- (void)reinstateDelegate;

@end
