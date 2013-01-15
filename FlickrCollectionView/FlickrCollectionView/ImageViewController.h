//
//  ImageViewController.h
//  FlickrCollectionView
//
//  Created by 山田 慶 on 2013/01/09.
//  Copyright (c) 2013年 山田 慶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewController.h"

@interface ImageViewController : UIViewController

- (IBAction)createColorPallet:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *largeImageView;
@property (nonatomic) UIImage *largeImage;

@end
