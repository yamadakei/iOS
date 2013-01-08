//
//  ViewController.m
//  Camera
//
//  Created by 山田 慶 on 2013/01/08.
//  Copyright (c) 2013年 山田 慶. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize imageVIew;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showCameraSheet
{
    UIActionSheet *sheet;
    
    sheet = [[UIActionSheet alloc] initWithTitle:@"Select SorceType" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Photo Library", @"Camera", @"Saved Photos", nil];
    
    [sheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex >= 3) {
        return;
    }
    
    UIImagePickerControllerSourceType sourceType = 0;
    
    switch (buttonIndex) {
        case 0:
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        case 1:
            sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 2:
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            break;
            
        default:
            break;
    }
    
    if(![UIImagePickerController isSourceTypeAvailable:sourceType])
    {
        return;
    }
    
    UIImagePickerController *imagePicker;
    imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.sourceType = sourceType;
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *originalImage;
    originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CGSize size = {300,400};
    UIGraphicsBeginImageContext(size);
    
    CGRect rect;
    rect.origin = CGPointZero;
    
    rect.size = size;
    [originalImage drawInRect:rect];
    
    UIImage* shrinkedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    imageVIew.image = shrinkedImage;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
