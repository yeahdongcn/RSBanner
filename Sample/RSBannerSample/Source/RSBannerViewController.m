//
//  RSBannerViewController.m
//  RSBannerSample
//
//  Created by 叶晓冬 on 2017/4/9.
//  Copyright © 2017年 R0CKSTAR. All rights reserved.
//

#import "RSBannerViewController.h"
#import "RSBannerCell.h"

@interface RSBannerViewController ()

@end

@implementation RSBannerViewController

#pragma mark -

- (instancetype)__init
{
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.headerReferenceSize = CGSizeZero;
    flowLayout.footerReferenceSize = CGSizeZero;
    flowLayout.sectionInset = UIEdgeInsetsZero;
    return [super initWithCollectionViewLayout:flowLayout];
}

- (instancetype)init
{
    return [self __init];
}

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    return [self __init];
}

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // Register cell classes
    [self.collectionView registerClass:[RSBannerCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)viewDidLayoutSubviews
{
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    flowLayout.itemSize = self.collectionView.bounds.size;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return SHRT_MAX * [self.rollingImages count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RSBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    if (self.placeHolderImage) {
        [cell.imageView setImage:self.placeHolderImage];
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
