//
//  CollectionViewell.h
//  FlickrCollectionView
//
//  Created by 山田 慶 on 2013/01/09.
//  Copyright (c) 2013年 山田 慶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic) UIImage *largeImage;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) NSInteger index;
@end
