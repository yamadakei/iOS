//
//  CollectionViewController.m
//  FlickrCollectionView
//
//  Created by 山田 慶 on 2013/01/09.
//  Copyright (c) 2013年 山田 慶. All rights reserved.
//

#import "CollectionViewController.h"
#import "Json.h"

@interface CollectionViewController ()
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)searchFlickrPhotos:(NSString *)text;
@end

NSString *const FlickrAPIKey = @"8cd91e0edba8fa02b50c2eed388b9090";

@implementation CollectionViewController
{
    NSInteger photoIndex;
}

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
    
    // Initialize our arrays
    photoTitles = [[NSMutableArray alloc] init];
    photoSmallImageData = [[NSMutableArray alloc] init];
    photoURLsLargeImage = [[NSMutableArray alloc] init];
    photoLargeImageData = [[NSMutableArray alloc] init];
    [self searchFlickrPhotos:@"fuck"];
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Methods

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Store incoming data into a string
	NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
//    NSLog(@"CALLING:%@", jsonString);
    
    NSLog(@"test");
    
    // Create a dictionary from the JSON string
	NSDictionary *results = [jsonString JSONValue];
	
    // Build an array from the dictionary for easy access to each entry
	NSArray *photos = [[results objectForKey:@"photos"] objectForKey:@"photo"];
    
    // Loop through each entry in the dictionary...
	for (NSDictionary *photo in photos)
    {
        // Build the URL to where the image is stored (see the Flickr API)
        // In the format http://farmX.static.flickr.com/server/id/secret
        // Notice the "_s" which requests a "small" image 75 x 75 pixels
		NSString *photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_s.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
        
        // The performance (scrolling) of the table will be much better if we
        // build an array of the image data here, and then add this data as
        // the cell.image value (see cellForRowAtIndexPath:)
		[photoSmallImageData addObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:photoURLString]]];
        
        // Build and save the URL to the large image so we can zoom
        // in on the image if requested
		NSString *largePhotoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
		[photoURLsLargeImage addObject:[NSURL URLWithString:largePhotoURLString]];
        
        [photoLargeImageData addObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:largePhotoURLString]]];
	}
    
    // （もとい）
    // collectionViewがreloadするデータは、どこで紐付けしてるんですか？
    [self.collectionView reloadData];
    
    [self.activityIndicator stopAnimating];
}

-(void)searchFlickrPhotos:(NSString *)text
{
    [self.activityIndicator startAnimating];
    // Build the string to call the Flickr API
	NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&per_page=15&format=json&nojsoncallback=1", FlickrAPIKey, text];
    
    // Create NSURL string from formatted string, by calling the Flickr API
	NSURL *url = [NSURL URLWithString:urlString];
    
    NSLog(@"%@", url);
    
    // Setup and start async download
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

#pragma mark - UICollectionViewDataSource Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return [photoURLsLargeImage count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
	NSData *imageData = [photoSmallImageData objectAtIndex:indexPath.row];
    
    NSLog(@"cell called... index: %d", indexPath.row);
    
	self.cell.imageView.image = [UIImage imageWithData:imageData];

    return self.cell;
}


#pragma mark - UICollectionViewDelegate Methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    photoIndex = indexPath.row;
    
    [self performSegueWithIdentifier:@"toSecondView" sender:self];
        
}

#pragma mark - StoryBoard Methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toSecondView"]) {
        ImageViewController *destination = segue.destinationViewController;
        NSData *largeImageData = [photoLargeImageData objectAtIndex:photoIndex];
        destination.largeImage = [UIImage imageWithData:largeImageData];
    }
}

@end
