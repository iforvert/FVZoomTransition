//
//  FVProductCell.m
//  FVZoomTransitionDemo
//
//  Created by iforvert on 2017/5/23.
//  Copyright © 2017年 iforvert. All rights reserved.
//

#import "FVProductCell.h"

@interface FVProductCell ()

@property (strong, nonatomic, readwrite) UIImageView *imageView;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation FVProductCell

#pragma mark - Constructors

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_imageView];
        
        self.titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:13.0];
        _titleLabel.numberOfLines = 2;
        [self.contentView addSubview:_titleLabel];
        
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1.0].CGColor;
    }
    return self;
}

#pragma mark - Setters

- (void)setProduct:(FVProduct *)product
{
    _product = product;
    _titleLabel.text = product.title;
    _imageView.image = [UIImage imageNamed:product.imageName];
    
    [self setNeedsLayout];
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _imageView.frame = CGRectMake(0.0, 0.0, self.contentView.frame.size.width, self.contentView.frame.size.width);
    
    CGFloat labelWidth = self.contentView.frame.size.width - 5.0 - 5.0;
    CGFloat labelHeight = [_titleLabel sizeThatFits:CGSizeMake(labelWidth, CGFLOAT_MAX)].height;
    _titleLabel.frame = CGRectMake(5.0, _imageView.frame.origin.y + _imageView.frame.size.height + 5.0, labelWidth, labelHeight);
}

@end
