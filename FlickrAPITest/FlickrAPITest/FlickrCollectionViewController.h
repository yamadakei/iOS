//
//  FlickrCollectionViewController.h
//  FlickrAPITest
//
//  Created by 山田 慶 on 2013/01/07.
//  Copyright (c) 2013年 山田 慶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlickrCollectionViewController : UICollectionViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    
    UICollectionView *colloectionView;
    
    NSMutableArray *photoTitles;
    NSMutableArray *photoSmallImageData;
    NSMutableArray *photoURLLargeImage;
    
}

@end
