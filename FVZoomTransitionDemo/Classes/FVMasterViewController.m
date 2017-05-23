//
//  FVMasterViewController.m
//  FVZoomTransitionDemo
//
//  Created by iforvert on 2017/5/23.
//  Copyright © 2017年 iforvert. All rights reserved.
//

#import "FVMasterViewController.h"
#import "FVProduct.h"
#import "FVProductCell.h"
#import "FVDetailViewController.h"

@interface FVMasterViewController ()
/** 数据源 */
@property (strong, nonatomic) NSArray *products;
@property (nonatomic, strong) FVProductCell *selectedCell;
@end

@implementation FVMasterViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self = [super initWithCollectionViewLayout:layout];
    if (self)
    {
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *products = [NSMutableArray arrayWithCapacity:10];
    for (NSInteger i=0; i<10; i++)
    {
        FVProduct *product = [[FVProduct alloc] init];
        product.title = [NSString stringWithFormat:@"Product %ld", (long)i];
        product.imageName = [NSString stringWithFormat:@"product_%ld.jpg", (long)i];
        [products addObject:product];
    }
    self.products = products;
    
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1.f];
    [self.collectionView registerClass:[FVProductCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _products.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FVProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.product = _products[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedCell = (FVProductCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    FVDetailViewController *detailController = [[FVDetailViewController alloc] initWithProduct:_products[indexPath.row]];
    [self.navigationController pushViewController:detailController animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout Methods

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (self.collectionView.frame.size.width / 2.0) - 10 - (10 / 2.0);
    return CGSizeMake(width, width + 40);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

@end
