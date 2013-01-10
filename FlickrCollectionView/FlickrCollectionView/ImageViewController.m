//
//  ImageViewController.m
//  FlickrCollectionView
//
//  Created by 山田 慶 on 2013/01/09.
//  Copyright (c) 2013年 山田 慶. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()
{
    IBOutlet UIImageView *largeImageView;
    CollectionViewController *collectionVIewController;
}

@end

@implementation ImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    largeImageView.image = collectionVIewController.cell.largeImage;
    
    NSLog(@"%@",collectionVIewController.cell.largeImage);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
