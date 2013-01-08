//
//  FlickrCollectionViewController.m
//  FlickrAPITest
//
//  Created by 山田 慶 on 2013/01/07.
//  Copyright (c) 2013年 山田 慶. All rights reserved.
//

#import "FlickrCollectionViewController.h"
#import "SBJson.h"

@interface FlickrCollectionViewController ()
- (void) connection : (NSURLConnection *)connection didiRecieveData:(NSData *)data;
- (void) searchFlickrPhotos: (NSString *)text;

@end

NSString *const FlickrAPIKey = @"<8cd91e0edba8fa02b50c2eed388b9090>";

@implementation FlickrCollectionViewController

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
    photoTitles = [[NSMutableArray alloc] init];
    photoSmallImageData = [[NSMutableArray alloc] init];
    photoURLLargeImage = [[NSMutableArray alloc] init];
    [self searchFlickrPhotos:@"iPhone"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [photoTitles count];
    NSLog(@"hello");

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [colloectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSData *imageData = [photoSmallImageData objectAtIndex:indexPath.row];
    
    cell.backgroundColor = [UIColor grayColor];
    
}

#pragma mark - Methods for Flickr

- (void)connection:(NSURLConnection *)connection didiRecieveData:(NSData *)data
{
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *results = [jsonString JSONValue];
    
    NSLog(@"results: %@", results);
    
    NSArray *photos = [[results objectForKey:@"photos"] objectForKey:@"photo"];
    
    for (NSDictionary *photo in photos) {
        NSString *title = [photo objectForKey:@"title"];
        [photoTitles addObject:(title.length > 0 ? title : @"Untitled")];
        NSString *photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_s.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
        [photoURLLargeImage addObject:[NSURL URLWithString:photoURLString]];
        
        NSLog(@"photoURLLargeImage: %@\n\n", photoURLString);
    }
    
    [colloectionView reloadData];
    
}

- (void)searchFlickrPhotos:(NSString *)text
{
    NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&per_page=15&format=json&nojsoncallback=1", FlickrAPIKey, text];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}


@end
