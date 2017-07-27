//
//  FVZoomTransition.m
//  FVZoomTransitionDemo
//
//  Created by iforvert on 2017/7/26.
//  Copyright © 2017年 iforvert. All rights reserved.
//

#import "FVZoomTransition.h"
#import "UIView+Sinp.h"

@interface FVZoomTransition()

@property (nonatomic, weak) id <UINavigationControllerDelegate> previousDelegate;
@property (nonatomic, assign) BOOL shouldCompleteTransition;
@property (nonatomic, assign, getter = isInteractive) BOOL interactive;

@end

@implementation FVZoomTransition

- (instancetype)initWithNavigationController:(UINavigationController *)nC
{
    self = [super init];
    if (self)
    {
        self.navigationController = nC;
        self.previousDelegate = nC.delegate;
        nC.delegate = self;
        [self setupInitializeInfo];
    }
    return self;
}

- (void)setupInitializeInfo
{
    self.transitionDuration = 0.35;
    self.handleEdgePanBackGesture = YES;
    self.transitionAnimationOption = UIViewKeyframeAnimationOptionCalculationModeCubic;
}

- (void)reinstateDelegate
{
    self.navigationController.delegate = self.previousDelegate;
}

#pragma mark - <UINavigationControllerDelegate>

- (id)_return:(id)returnValue
           nC:(UINavigationController *)nC
       fromVC:(UIViewController<UIGestureRecognizerDelegate> *)fromVC
         toVC:(UIViewController<UIGestureRecognizerDelegate> *)toVC
{
    if (!returnValue || !self.handleEdgePanBackGesture)
    {
        nC.interactivePopGestureRecognizer.delegate = (id <UIGestureRecognizerDelegate>)toVC;
    }
    return returnValue;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(__kindof UIViewController *)fromVC
                                                 toViewController:(__kindof UIViewController *)toVC
{
    if (!navigationController)
    {
        return [self _return:nil nC:nil fromVC:nil toVC:nil];
    }
    
    if (![fromVC conformsToProtocol:@protocol(FVZoomTransitionProtocol)] ||
        ![toVC conformsToProtocol:@protocol(FVZoomTransitionProtocol)])
    {
        return [self _return:nil nC:navigationController fromVC:fromVC toVC:toVC];
    }
    [fromVC view];
    [toVC view];
    
    if (![(id<FVZoomTransitionProtocol>)fromVC viewForZoomTransition:YES] ||
        ![(id<FVZoomTransitionProtocol>)toVC viewForZoomTransition:NO])
    {
        return [self _return:nil nC:navigationController fromVC:fromVC toVC:toVC];
    }
    
    if (([fromVC respondsToSelector:@selector(shouldAllowZoomTransitionForOperation:fromViewController:toViewController:)] &&
         ![(id<FVZoomTransitionProtocol>)fromVC shouldAllowZoomTransitionForOperation:operation fromViewController:fromVC toViewController:toVC]) ||
        ([toVC respondsToSelector:@selector(shouldAllowZoomTransitionForOperation:fromViewController:toViewController:)] &&
         ![(id<FVZoomTransitionProtocol>)toVC shouldAllowZoomTransitionForOperation:operation fromViewController:fromVC toViewController:toVC]))
    {
        if ([fromVC respondsToSelector:@selector(animationControllerForTransitionToViewController:)])
        {
            id<UIViewControllerAnimatedTransitioning> returnValue = [(id<FVZoomTransitionProtocol>)fromVC animationControllerForTransitionToViewController:toVC];
            return [self _return:returnValue nC:navigationController fromVC:fromVC toVC:toVC];
        }
        else
        {
            return [self _return:nil nC:navigationController fromVC:fromVC toVC:toVC];
        }
    }
    return [self _return:self nC:navigationController fromVC:fromVC toVC:toVC];
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    if (!self.isInteractive)
    {
        return nil;
    }
    return self;
}

#pragma mark - <UIViewControllerAnimatedTransitioning>

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.transitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController <FVZoomTransitionProtocol> * fromVC = (id)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController <FVZoomTransitionProtocol> *toVC = (id)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * containerView = [transitionContext containerView];
    UIView * fromView = [fromVC view];
    UIView * toView = [toVC view];
    [containerView addSubview:fromView];
    [containerView addSubview:toView];
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    
    UIView * fromZoomView = [fromVC viewForZoomTransition:true];
    UIView * toZoomView = [toVC viewForZoomTransition:false];
    
    UIImageView * animatingImageView;
    if ([fromVC respondsToSelector:@selector(initialZoomViewSnapshotFromProposedSnapshot:)])
    {
        animatingImageView = [fromVC initialZoomViewSnapshotFromProposedSnapshot:animatingImageView];
    }
    if (!animatingImageView)
    {
        animatingImageView = [self initialZoomSnapshotFromView:fromZoomView destinationView:toZoomView];
    }
    animatingImageView.frame = CGRectIntegral([fromZoomView.superview convertRect:fromZoomView.frame toView:containerView]);
    
    fromZoomView.alpha = 0;
    toZoomView.alpha = 0;
    
    UIImageView *backgroundView = [self snapshotImageViewFromView:fromView];
    [containerView addSubview:backgroundView];
    
    [containerView addSubview:animatingImageView];
    
    BOOL isGoingForward = [self.navigationController.viewControllers indexOfObject:fromVC] == (self.navigationController.viewControllers.count - 2);
    if (isGoingForward && self.handleEdgePanBackGesture)
    {
        BOOL wasAdded = NO;
        for (UIGestureRecognizer *gr in toVC.view.gestureRecognizers)
        {
            if ([gr isKindOfClass:[UIScreenEdgePanGestureRecognizer class]])
            {
                wasAdded = YES;
                break;
            }
        }
        if (!wasAdded)
        {
            UIScreenEdgePanGestureRecognizer *edgePanRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleEdgePan:)];
            edgePanRecognizer.edges = UIRectEdgeLeft;
            [toVC.view addGestureRecognizer:edgePanRecognizer];
        }
    }
    
    [UIView animateKeyframesWithDuration:self.transitionDuration
                                   delay:0
                                 options:self.transitionAnimationOption
                              animations:^{
                                  animatingImageView.frame = CGRectIntegral([toZoomView.superview convertRect:toZoomView.frame toView:containerView]);
                                  backgroundView.alpha = 0;
                                  
                                  if ([fromVC respondsToSelector:@selector(animationBlockForZoomTransition)])
                                  {
                                      FVZoomAnimationBlock zoomAnimationBlock = [fromVC animationBlockForZoomTransition];
                                      if (zoomAnimationBlock)
                                      {
                                          zoomAnimationBlock(animatingImageView, fromZoomView, toZoomView);
                                      }
                                  }
                              } completion:^(BOOL finished) {
                                  dispatch_block_t completion = ^{
                                      [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                                      [animatingImageView removeFromSuperview];
                                      [backgroundView removeFromSuperview];
                                      fromZoomView.alpha = 1;
                                      toZoomView.alpha = 1;
                                  };
                                  
                                  if ([fromVC respondsToSelector:@selector(completionBlockForZoomTransition)])
                                  {
                                      FVZoomCompletionBlock zoomCompletionBlock = [fromVC completionBlockForZoomTransition];
                                      if (zoomCompletionBlock)
                                      {
                                          zoomCompletionBlock(animatingImageView, fromZoomView, toZoomView, completion);
                                          return;
                                      }
                                  }
                                  completion();
                              }];
}


- (UIImageView *)initialZoomSnapshotFromView:(UIView *)sourceView
                             destinationView:(UIView *)destinationView
{
    return [self snapshotImageViewFromView:(sourceView.bounds.size.width > destinationView.bounds.size.width) ? sourceView : destinationView];
}

- (UIImageView *)snapshotImageViewFromView:(UIView *)view
{
    UIImage * snapshot = [view fv_takeSnapshot];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:snapshot];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    return imageView;
}

- (void)handleEdgePan:(UIScreenEdgePanGestureRecognizer *)gr
{
    CGPoint point = [gr translationInView:gr.view];
    
    switch (gr.state)
    {
        case UIGestureRecognizerStateBegan:
            self.interactive = YES;
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGFloat percent = point.x / gr.view.frame.size.width;
            self.shouldCompleteTransition = (percent > 0.25);
            [self updateInteractiveTransition: (percent <= 0.0) ? 0.0 : percent];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            if (!self.shouldCompleteTransition || gr.state == UIGestureRecognizerStateCancelled)
                [self cancelInteractiveTransition];
            else
                [self finishInteractiveTransition];
            self.interactive = NO;
            break;
        default:
            break;
    }
}


@end
