//
//  FVProductCell.h
//  FVZoomTransitionDemo
//
//  Created by iforvert on 2017/5/23.
//  Copyright © 2017年 iforvert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FVProduct.h"

@interface FVProductCell : UICollectionViewCell

@property (strong, nonatomic) FVProduct *product;
@property (strong, nonatomic, readonly) UIImageView *imageView;

@end
