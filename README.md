# FVZoomTransition

## Introduction

`FVZoomTransition` provides a new style of push & pop transition.

## Renderings



![effect](img/effect.gif)



## Basic usage

1. Your target vc must conforms To Protocol <FVZoomTransitionProtocol>

2. Create an FVZoomTransition instance troughth specified method, and  passing your navigation controller instance to it. Such as:

   ```objc
   - (void)viewDidLoad
   {
       [super viewDidLoad];
       self.transition = [[FVZoomTransition alloc] initWithNavigationController:self.navigationController];
   }
   ```

3. According to the requirements in the source and target controller to realize the method specified in the FVZoomTransitionProtocol ,As in the sample code

   ```objective-c
   - (UIView *)viewForZoomTransition:(BOOL)isSource
   {
     // Return to the view that you wanted transition
   }
   ```

   ​

## Requirements

iOS 7 or above



