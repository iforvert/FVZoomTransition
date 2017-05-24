//
//  FVZoomTransitioner.m
//  FVZoomTransitionDemo
//
//  Created by iforvert on 2017/5/24.
//  Copyright © 2017年 iforvert. All rights reserved.
//

#import "FVZoomTransitioner.h"
#import "UIView+Extension.h"
#import "UIImage+Extension.h"

@interface BukaOpenCardAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong) UIView *transitTargetView;
@property (nonatomic, assign) BOOL isPresentation;

@end

@implementation BukaOpenCardAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView* fromView = fromVC.view;
    UIViewController* toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView* toView = toVC.view;
    
    UIView *containerView = [transitionContext containerView];
    CGRect toFrame = [transitionContext finalFrameForViewController:toVC];
    if (CGRectIsEmpty(toFrame))
    {
        toFrame = containerView.bounds;
    }
    toView.frame = toFrame;
    
    UIView *transitview = self.transitTargetView;
    if (!transitview)
    {
        transitview = self.isPresentation ? fromView : toView;
    }
    
    CGRect originrect = [containerView convertRect:transitview.frame fromView:transitview.superview];
    
    UIImageView *shadow = [UIImageView new];
    
    UIImage *transitimage;
    if ([transitview isKindOfClass:[UIImageView class]])
    {
        transitimage = [(UIImageView *)transitview image];
    }
    else
    {
        transitimage = [transitview toUIImage];
    }
    
    if (self.isPresentation)
    {
        BOOL savetransitviewhidden = transitview.hidden;
        transitview.hidden = YES;
        
        CGFloat savetoViewalpha = toView.alpha;
        toView.alpha = 0;
        [containerView addSubview:toView];
        
        shadow.frame = originrect;
        shadow.backgroundColor = [UIColor clearColor];
        [containerView addSubview:shadow];
        
        UIImage *tranimage;
        if ([toVC conformsToProtocol:@protocol(FVZoomTransitionerDelegate)])
        {
            if ([toVC respondsToSelector:@selector(snapshot)])
            {
                tranimage = [(id<FVZoomTransitionerDelegate>)toVC snapshot];
            }
        }
        
        if (!tranimage)
        {
            tranimage = [UIImage fv_imageWithColor:[UIColor lightGrayColor]];
        }
        
        UIImageView *blurshadow = [[UIImageView alloc] initWithImage:tranimage];
        blurshadow.contentMode = UIViewContentModeScaleToFill;
        blurshadow.frame = shadow.bounds;
        blurshadow.alpha = 0;
        [shadow addSubview:blurshadow];
        
        UIImageView *transitvshadow = [[UIImageView alloc] initWithImage:transitimage];
        transitvshadow.contentMode = UIViewContentModeScaleAspectFill;
        transitvshadow.frame = shadow.bounds;
        [shadow addSubview:transitvshadow];
        shadow.clipsToBounds = YES;
        
        [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext]
                                       delay:0
                                     options:UIViewKeyframeAnimationOptionCalculationModeCubic
                                  animations:^{
                                      
                                      //shadow
                                      [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 animations:^{
                                          shadow.frame = containerView.bounds;
                                          blurshadow.frame = shadow.bounds;
                                          transitvshadow.frame = shadow.bounds;
                                      }];
                                      
                                      [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
                                          transitvshadow.alpha = 0;
                                          blurshadow.alpha = 1;
                                      }];
                                      
                                      [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:1 animations:^{
                                          toView.alpha = 1;
                                      }];
                                      
                                  }
                                  completion:^(BOOL finished) {
                                      
                                      [UIView animateKeyframesWithDuration:0.2 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic
                                                                animations:^{
                                                                    [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 animations:^{
                                                                        blurshadow.alpha = 0;
                                                                    }];
                                                                }
                                                                completion:^(BOOL finished) {
                                                                    [shadow removeFromSuperview];
                                                                    toView.alpha = savetoViewalpha;
                                                                    transitview.hidden = savetransitviewhidden;
                                                                    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                                                                }];
                                  }];
    }
    else
    {
        [containerView insertSubview:toView belowSubview:fromView];
        
        shadow.frame = fromView.frame;
        [containerView addSubview:shadow];
        
        shadow.backgroundColor = [UIColor clearColor];
        UIImageView *fromvshadow = [[UIImageView alloc] initWithImage:[fromView toUIImage]];
        fromvshadow.contentMode = UIViewContentModeScaleToFill;
        fromvshadow.frame = shadow.bounds;
        [shadow addSubview:fromvshadow];
        
        UIImageView *transitvshadow = [[UIImageView alloc] initWithImage:transitimage];
        transitvshadow.contentMode = UIViewContentModeScaleAspectFill;
        transitvshadow.alpha = 0;
        transitvshadow.frame = shadow.bounds;
        [shadow addSubview:transitvshadow];
        shadow.clipsToBounds = YES;
        
        CGFloat savefromviewalpha = fromView.alpha;
        fromView.alpha = 0;
        
        CGFloat savetransitviewalpha = transitview.alpha;
        transitview.alpha = 0;
        
        [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext]
                                       delay:0
                                     options:UIViewKeyframeAnimationOptionCalculationModeLinear
                                  animations:^{
                                      [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 animations:^{
                                          shadow.frame = originrect;
                                          transitvshadow.frame = shadow.bounds;
                                          fromvshadow.frame = shadow.bounds;
                                      }];
                                      
                                      [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.7 animations:^{
                                          transitvshadow.alpha = 0.2;
                                      }];
                                      
                                      [UIView addKeyframeWithRelativeStartTime:0.7 relativeDuration:0.8 animations:^{
                                          transitvshadow.alpha = 0.5;
                                          fromvshadow.alpha = 0.5;
                                      }];
                                      
                                      [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:1 animations:^{
                                          transitvshadow.alpha = 1;
                                          transitview.alpha = savetransitviewalpha;
                                      }];
                                  }
                                  completion:^(BOOL finished) {
                                      [shadow removeFromSuperview];
                                      transitview.alpha = savetransitviewalpha;
                                      fromView.alpha = savefromviewalpha;
                                      
                                      [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                                  }];
    }
}

@end

@implementation FVZoomTransitioner


- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush)
    {
        BukaOpenCardAnimatedTransitioning* trans = [BukaOpenCardAnimatedTransitioning new];
        trans.transitTargetView = self.transitCard;
        trans.isPresentation = YES;
        return trans;
    }
    else if (operation == UINavigationControllerOperationPop)
    {
        BukaOpenCardAnimatedTransitioning* trans = [BukaOpenCardAnimatedTransitioning new];
        trans.transitTargetView = self.transitCard;
        trans.isPresentation = NO;
        return trans;
    }
    else
    {
        return nil;
    }
}

@end
