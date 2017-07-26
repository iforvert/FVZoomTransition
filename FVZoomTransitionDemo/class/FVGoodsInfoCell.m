//
//  FVGoodsInfoCell.m
//  FVZoomTransitionDemo
//
//  Created by iforvert on 2017/7/26.
//  Copyright © 2017年 iforvert. All rights reserved.
//

#import "FVGoodsInfoCell.h"

@implementation FVGoodsInfoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView
{
    [self.contentView addSubview:self.goodsImgView];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.goodsImgView.frame = self.contentView.frame;
}

- (UIImageView *)goodsImgView
{
    if (!_goodsImgView)
    {
        _goodsImgView = [[UIImageView alloc] init];
    }
    return _goodsImgView;
}

@end
