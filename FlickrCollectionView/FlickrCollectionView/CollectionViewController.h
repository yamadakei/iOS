//
//  CollectionViewController.h
//  FlickrCollectionView
//
//  Created by 山田 慶 on 2013/01/09.
//  Copyright (c) 2013年 山田 慶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewCell.h"
#import "ImageViewController.h"

@interface CollectionViewController : UICollectionViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSMutableArray  *photoTitles;         // Titles of images
    NSMutableArray  *photoSmallImageData; // Image data (thumbnail)
    NSMutableArray  *photoURLsLargeImage; // URL to larger image
    NSMutableArray  *photoLargeImageData;
    
}

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic) CollectionViewCell *cell;

@end
