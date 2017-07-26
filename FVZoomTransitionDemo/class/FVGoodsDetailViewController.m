//
//  FVGoodsDetailViewController.m
//  FVZoomTransitionDemo
//
//  Created by iforvert on 2017/7/26.
//  Copyright © 2017年 iforvert. All rights reserved.
//

#import "FVGoodsDetailViewController.h"
#import "FVZoomTransition.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width

@interface FVGoodsDetailViewController ()<FVZoomTransitionProtocol>

@property (nonatomic) UIImageView *detailImageView;
@property (nonatomic) UIView *naviBar;
@property (nonatomic) UILabel *titleLabel;

@end

@implementation FVGoodsDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupChildView];
}

- (void)setupChildView
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.detailImageView];
    [self.view addSubview:self.naviBar];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.naviBar.frame = CGRectMake(0, 0, kScreenW, 64.f);
    self.detailImageView.frame = CGRectMake(0, 64, kScreenW, kScreenW);
    self.titleLabel.frame = CGRectMake((kScreenW - 100) / 2 , 20, 100, 44);
}

- (void)setGoodsDetailImg:(UIImage *)goodsDetailImg
{
    self.detailImageView.image = goodsDetailImg;
}

- (void)naviToBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ZoomTransitionProtocol

- (UIView *)viewForZoomTransition:(BOOL)isSource
{
    return self.detailImageView;
}

#pragma mark - lazy load

- (UIImageView *)detailImageView
{
    if (!_detailImageView)
    {
        _detailImageView = [[UIImageView alloc] init];
        _detailImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _detailImageView;
}

- (UIView *)naviBar
{
    if (!_naviBar)
    {
        _naviBar = [[UIView alloc] init];
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(10, 24, 40, 40);
        [backBtn setImage:[UIImage imageNamed:@"navi_back"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(naviToBack) forControlEvents:UIControlEventTouchUpInside];
        [_naviBar addSubview:backBtn];
        [_naviBar addSubview:self.titleLabel];
    }
    return _naviBar;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"Goods Detail";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
