//
//  RSBannerCell.m
//  RSBannerSample
//
//  Created by 叶晓冬 on 2017/4/9.
//  Copyright © 2017年 R0CKSTAR. All rights reserved.
//

#import "RSBannerCell.h"

@interface RSBannerCell ()

@end

@implementation RSBannerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect bounds = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.imageView = [[UIImageView alloc] initWithFrame:bounds];
        self.imageView.autoresizingMask = (  UIViewAutoresizingFlexibleWidth
                                           | UIViewAutoresizingFlexibleHeight);
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

@end
