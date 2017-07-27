//
//  FVZoomTransitionProtocol.h
//  FVZoomTransitionDemo
//
//  Created by iforvert on 2017/7/26.
//  Copyright © 2017年 iforvert. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FVZoomAnimationBlock)(UIImageView * animatedSnapshot, UIView * sourceView, UIView * destinationView);
typedef void(^FVZoomCompletionBlock)(UIImageView * animatedSnapshot, UIView * sourceView, UIView * destinationView, void(^completion)(void));

@protocol FVZoomTransitionProtocol <NSObject>

- (UIView *)viewForZoomTransition:(BOOL)ornot;

@optional

-(UIImageView *)initialZoomViewSnapshotFromProposedSnapshot:(UIImageView *)snapshot;

-(BOOL)shouldAllowZoomTransitionForOperation:(UINavigationControllerOperation)operation
                          fromViewController:(UIViewController *)fromVC
                            toViewController:(UIViewController *)toVC;

-(FVZoomAnimationBlock)animationBlockForZoomTransition;

-(FVZoomCompletionBlock)completionBlockForZoomTransition;;

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForTransitionToViewController:(UIViewController *)toVC;

@end
