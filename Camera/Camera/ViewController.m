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
{
    UIImagePickerController *imagePicker;
    UIImage *image;
}
@synthesize imageVIew;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    image = [UIImage imageNamed:@"transparent_png_sample.png"];
    imageVIew.image = image;
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
    
    CGRect reRect = CGRectMake(0, 0, shrinkedImage.size.width, shrinkedImage.size.height);
    [shrinkedImage drawInRect:reRect];
    [image drawInRect:reRect blendMode:kCGBlendModeNormal alpha:1.0];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    imageVIew.image = result;
    
    if(image != nil)
    {
        UIImageWriteToSavedPhotosAlbum(result, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存終了" message:@"画像を保存しました" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
