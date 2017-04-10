//
//  RSBannerViewController.h
//  RSBannerSample
//
//  Created by 叶晓冬 on 2017/4/9.
//  Copyright © 2017年 R0CKSTAR. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RSBannerTapHandler)(NSInteger whichIndex);

typedef void(^RSBannerRemoteImageLoadingBlock)(UIImageView *imageView, NSString *imageURLString, UIImage *placeHolderImage);

@interface RSBannerViewController : UICollectionViewController

/// Images for the rolling banner, can be a remote URL or UIImage
@property (nonatomic, copy)   NSArray       *rollingImages;

/// Time interval between the rolling
@property (nonatomic, assign) NSTimeInterval rollingInterval;

/// The placeHolder image
@property (nonatomic, copy)   UIImage       *placeHolderImage;

/// Start rolling
- (void)startRolling;

/// Stop rolling
- (void)stopRolling;

/// Handler for banner tap event
- (void)addBannerTapHandler:(RSBannerTapHandler)handler;

/// Handler for remote image loading event
- (void)setRemoteImageLoadingBlock:(RSBannerRemoteImageLoadingBlock)loadingBlock;

@end
