//
//  FVGoodsController.m
//  FVZoomTransitionDemo
//
//  Created by iforvert on 2017/7/26.
//  Copyright © 2017年 iforvert. All rights reserved.
//

#import "FVGoodsController.h"
#import "FVGoodsDetailViewController.h"
#import "FVGoodsInfoCell.h"

static CGFloat const kMargin = 15.f;
static NSString * const kGoodsCellID = @"kGoodsCellID";

@interface FVGoodsController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,FVZoomTransitionProtocol>

@property (nonatomic) UICollectionView *goodsView;
@property (nonatomic) FVZoomTransition *transition;
@property (nonatomic) NSIndexPath *selectedIndexPath;

@end

@implementation FVGoodsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupChildView];
    self.transition = [[FVZoomTransition alloc] initWithNavigationController:self.navigationController];
}

- (void)setupChildView
{
    [self.view addSubview:self.goodsView];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.goodsView.frame = self.view.frame;
}

#pragma mark - ZoomTransitionProtocol

- (UIView *)viewForZoomTransition:(BOOL)isSource
{
    FVGoodsInfoCell * cell = (FVGoodsInfoCell *)[self.goodsView cellForItemAtIndexPath:self.selectedIndexPath];
    return cell.goodsImgView;
}

#pragma mark - <UICollectionViewDelegate,UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 155.f;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FVGoodsInfoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kGoodsCellID forIndexPath:indexPath];
    NSString *imgStr = [NSString stringWithFormat:@"product_%@",@(indexPath.row % 9)];
    cell.goodsImgView.image = [UIImage imageNamed:imgStr];
    
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, kMargin, 0, kMargin);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FVGoodsDetailViewController *detailVC = [[FVGoodsDetailViewController alloc] init];
    FVGoodsInfoCell *cell = (FVGoodsInfoCell *)[collectionView cellForItemAtIndexPath:indexPath];
    self.selectedIndexPath = indexPath;
    detailVC.goodsDetailImg = cell.goodsImgView.image;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - lazy load

- (UICollectionView *)goodsView
{
    if (!_goodsView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat width = ([UIScreen mainScreen].bounds.size.width - 3 * kMargin) / 2;
        CGFloat height = width;
        layout.itemSize = CGSizeMake(width, height);
        layout.minimumLineSpacing = kMargin;
        layout.minimumInteritemSpacing = kMargin;
        _goodsView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_goodsView registerClass:[FVGoodsInfoCell class] forCellWithReuseIdentifier:kGoodsCellID];
        _goodsView.delegate = self;
        _goodsView.dataSource = self;
        _goodsView.backgroundColor = [UIColor whiteColor];
    }
    return _goodsView;
}

@end
