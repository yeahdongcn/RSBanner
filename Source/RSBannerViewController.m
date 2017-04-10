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

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL     rolling;

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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.rolling) {
        [self startRolling];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self stopRolling];
}

- (void)viewDidLayoutSubviews
{
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    if (!CGSizeEqualToSize(flowLayout.itemSize, self.collectionView.bounds.size)) {
        flowLayout.itemSize = self.collectionView.bounds.size;
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [self pauseRolling];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)([[UIApplication sharedApplication] statusBarOrientationAnimationDuration] * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       [self resumeRolling];
                   });
}

#pragma mark - Setter

- (void)setRollingImages:(NSArray *)rollingImages
{
    _rollingImages = rollingImages;
    
    [self.collectionView reloadData];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        CGPoint contentOffset = CGPointZero;
        contentOffset.x = self.collectionView.bounds.size.width * SHRT_MAX * [self.rollingImages count];
        [self.collectionView setContentOffset:contentOffset animated:NO];
    });
}

#pragma mark - Private

- (void)doRolling
{
    CGPoint contentOffset = self.collectionView.contentOffset;
    contentOffset.x += self.collectionView.bounds.size.width;
    [self.collectionView setContentOffset:contentOffset animated:YES];
}

- (void)pauseRolling
{
    if (self.timer) {
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}

- (void)resumeRolling
{
    if (self.timer) {
        [self.timer setFireDate:[NSDate dateWithTimeInterval:self.rollingInterval sinceDate:[NSDate date]]];
    }
}

#pragma mark - Public

- (void)startRolling
{
    [self stopRolling:NO];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.rollingInterval target:self selector:@selector(doRolling) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    self.rolling = YES;
}

- (void)stopRolling:(BOOL)clearFlag
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    if (clearFlag) {
        self.rolling = NO;
    }
}

- (void)stopRolling
{
    [self stopRolling:YES];
}

- (void)addBannerTapHandler:(RSBannerTapHandler)handler
{
    
}

- (void)setRemoteImageLoadingBlock:(RSBannerRemoteImageLoadingBlock)loadingBlock
{
    
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return SHRT_MAX * [self.rollingImages count] * 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RSBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    if (self.placeHolderImage) {
        [cell.imageView setImage:self.placeHolderImage];
    }
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self pauseRolling];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (decelerate) {
        [self resumeRolling];
    }
}

@end
