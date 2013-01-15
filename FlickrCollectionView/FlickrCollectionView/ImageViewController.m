//
//  ImageViewController.m
//  FlickrCollectionView
//
//  Created by 山田 慶 on 2013/01/09.
//  Copyright (c) 2013年 山田 慶. All rights reserved.
//

#import "ImageViewController.h"
#import "ColorPalletViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController
@synthesize largeImage;

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
    self.largeImageView.image = largeImage;
    
    NSLog(@"%@",largeImage);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createColorPallet:(id)sender {

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toThirdView"]) {
        ColorPalletViewController *secondDestination = segue.destinationViewController;
        secondDestination.inputImage = largeImage;
    }
}
@end
