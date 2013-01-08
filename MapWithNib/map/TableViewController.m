//
//  TableViewController.m
//  map
//
//  Created by 山田 慶 on 2012/12/05.
//  Copyright (c) 2012年 山田 慶. All rights reserved.
//

#import "TableViewController.h"
#import "AppDelegate.h"
#import "CustomCell.h"
#import "AnnotationView.h"


@interface TableViewController ()
{
    NSMutableArray *cityArr;
    CustomCell *customCell;
    NSString* population;
    NSString* cityImgName;
    NSString* cityURL;
    UIActivityIndicatorView *activityView;
}

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate* delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    cityArr = delegate.cityArr;
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [cityArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    customCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    customCell.viewForMap = [[ViewForMap alloc]initWithNib];
    
    [customCell addSubview:customCell.viewForMap];
    
    customCell.viewForMap.center = CGPointMake(customCell.frame.size.width-customCell.viewForMap.frame.size.width/2, customCell.viewForMap.center.y);
    
//    activityView =[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    CGRect frame = activityView.frame;
//    frame.origin = CGPointMake(125, 85);
//    activityView.frame = frame;
//    activityView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
//    activityView.tag = 2;
    
    [customCell.viewForMap.map addSubview:activityView];
    NSDictionary* dict = [cityArr objectAtIndex:indexPath.row];
    NSString* name = [dict objectForKey:@"name"];
    float myLongitude = [[dict objectForKey:@"longitude"] floatValue];
    NSString *tempLog = [NSString stringWithFormat:@"%f",myLongitude];
    float myLatitude = [[dict objectForKey:@"latitude"] floatValue];
    NSString *temLat = [NSString stringWithFormat:@"%f",myLatitude];
    customCell.cityName.text = name;
    customCell.longitude.text = temLat;
    customCell.latitude.text = tempLog;
    
    customCell.viewForMap.map.delegate = self;
    
    CLLocationCoordinate2D loc;
    loc.latitude = myLatitude;
    loc.longitude = myLongitude;
    
//    [activityView startAnimating];
    
    MKCoordinateRegion rangeCoord = customCell.viewForMap.map.region;
    rangeCoord.center = loc;
    [customCell.viewForMap.map setCenterCoordinate:loc animated:YES];
    
    Annotation *annotation;
    
    annotation = [[Annotation alloc] initWithCoordinate:loc];
    
    population = [dict objectForKey:@"population"];
    cityImgName = [dict objectForKey:@"image"];
    cityURL = [dict objectForKey:@"url"];
    customCell.annotationView.annoCityName.text = population;
    customCell.annotationView.annoCityURL.text = cityURL;
    customCell.annotationView.annoCityImg.image = [UIImage imageNamed:cityImgName];
    [customCell.viewForMap.map addAnnotation:annotation];
    
    float mapScale = 0.05;
    rangeCoord.span.latitudeDelta = mapScale;
    rangeCoord.span.longitudeDelta = mapScale;
    
    [customCell.viewForMap.map setRegion:rangeCoord animated:YES];
    
    
    // Configure the cell...
    
    return customCell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - MKMapVIewDelegate
- (AnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation 
{
    AnnotationView *annotationView;
    NSString* identifier = @"test";
    annotationView = (AnnotationView*)[customCell.viewForMap.map dequeueReusableAnnotationViewWithIdentifier:identifier];
    if(nil == annotationView) {
        annotationView = [[AnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier population:population cityImg:cityImgName cityURL:cityURL];
    }
    
    UIImage *tmpImg = [UIImage imageNamed:@"tnm.png"];
    UIImage *pinImg;
    float widthPer = 0.7;
    float heightPer = 0.7;
    
    CGSize imgSize = CGSizeMake(tmpImg.size.width*widthPer,tmpImg.size.height*heightPer);
    UIGraphicsBeginImageContext(imgSize);
    [tmpImg drawInRect:CGRectMake(0, 0, imgSize.width, imgSize.height)];
    pinImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [annotationView setImage:pinImg];
    
    annotationView.annotation = annotation;
    
    return annotationView;
    
}

@end
