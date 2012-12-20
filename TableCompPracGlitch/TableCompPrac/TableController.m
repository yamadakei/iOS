//
//  TableController.m
//  TableCompPrac
//
//  Created by 山田 慶 on 2012/11/20.
//  Copyright (c) 2012年 山田 慶. All rights reserved.
//

#import "TableController.h"
#import <QuartzCore/QuartzCore.h>

@interface TableController ()
{
    NSArray* images;
    NSArray* cityNames;
    NSArray* cityNamesJp;
    UIView* containerVIew;
    int numIdx;
    UIImage *img;
    CustomCell* customCell;
}

@end

@implementation TableController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray* tmpCityNames = [[NSMutableArray alloc]init];
    [tmpCityNames addObject:@"Paris"];
    [tmpCityNames addObject:@"New York"];
    [tmpCityNames addObject:@"Tokyo"];
    [tmpCityNames addObject:@"Shanghai"];
    [tmpCityNames addObject:@"Bangkok"];
    [tmpCityNames addObject:@"LosAngels"];
    [tmpCityNames addObject:@"Madlid"];
    [tmpCityNames addObject:@"London"];
    [tmpCityNames addObject:@"Berlin"];
    [tmpCityNames addObject:@"Babylon"];
    cityNames = [[NSArray alloc] initWithArray:tmpCityNames];
    
    NSMutableArray* tmpCityNamesJp = [[NSMutableArray alloc]init];
    [tmpCityNamesJp addObject:@"パリ"];
    [tmpCityNamesJp addObject:@"ニューヨーク"];
    [tmpCityNamesJp addObject:@"東京"];
    [tmpCityNamesJp addObject:@"上海"];
    [tmpCityNamesJp addObject:@"バンコク"];
    [tmpCityNamesJp addObject:@"ロサンジェルス"];
    [tmpCityNamesJp addObject:@"マドリード"];
    [tmpCityNamesJp addObject:@"ロンドン"];
    [tmpCityNamesJp addObject:@"ベルリン"];
    [tmpCityNamesJp addObject:@"バビロン"];
    cityNamesJp = [[NSArray alloc] initWithArray:tmpCityNamesJp];
    
    NSMutableArray* tmpImages = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        [tmpImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]]];
    }
    images = [[NSArray alloc] initWithArray:tmpImages];
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
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    customCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (customCell == nil) {
        customCell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
        
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *view = [[UIView alloc] initWithFrame:customCell.frame];
    view.backgroundColor = [UIColor colorWithRed:.9 green:.0 blue:.125 alpha:1.0];
    
    customCell.selectedBackgroundView = view;
    
    img = [images objectAtIndex:indexPath.row];
    
    customCell.cityImgView.frame = CGRectMake(customCell.frame.size.width-(img.size.width/2+customCell.frame.size.width/2), 0, img.size.width/2, img.size.height/2);
    
    customCell.cityImgView.image = img;

    customCell.lbl1.font = [UIFont fontWithName:@"Helvetica" size:80];
    customCell.lbl1.text = [cityNames objectAtIndex:indexPath.row];
    customCell.lbl1.center = CGPointMake(customCell.lbl1.center.x, customCell.frame.size.height/2);
    
    customCell.lbl2.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
    customCell.lbl2.text = [cityNamesJp objectAtIndex:indexPath.row];
    int margin_top = 45;
    customCell.lbl2.center = CGPointMake(customCell.lbl2.center.x, customCell.frame.size.height/2+margin_top);
    
    [customCell.cityImgView prepareForGlitch];

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

//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    customCell = [tableView cellForRowAtIndexPath:indexPath];
    [customCell.cityImgView glitch];
    UIView *view = [[UIView alloc] initWithFrame:customCell.frame];
    view.backgroundColor = [UIColor colorWithRed:.9 green:.0 blue:.125 alpha:1.0];
    
    customCell.selectedBackgroundView = view;
//    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewCellEditingStyleNone];


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    img = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",indexPath.row]];
    return img.size.height/2;

}

@end
