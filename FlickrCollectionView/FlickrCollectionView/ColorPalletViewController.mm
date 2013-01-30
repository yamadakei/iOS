//
//  CollerPalletViewController.m
//  FlickrCollectionView
//
//  Created by 山田 慶 on 2013/01/10.
//  Copyright (c) 2013年 山田 慶. All rights reserved.
//

#import "ColorPalletViewController.h"
#import "opencv2.framework/Headers/opencv.hpp"
#import "NSMutableArray+Sort.h"

@interface ColorPalletViewController ()
{
    NSMutableArray *blueArray;
    NSMutableArray *greenArray;
    NSMutableArray *redArray;
}
- (UIImage *)UIImageFromCVMat:(cv::Mat)cvMat;
- (cv::Mat)cvMatFromUIImage:(UIImage *)image;
- (cv::Mat)kMeansClustering:(cv::Mat)input;

@end

@implementation ColorPalletViewController
@synthesize inputImage;
@synthesize firstView;
@synthesize secondView;
@synthesize thirdView;
@synthesize forthView;
@synthesize fifthView;


#pragma mark - Custom Methods

- (UIImage *)UIImageFromCVMat:(cv::Mat)cvMat
{
    NSData *data = [NSData dataWithBytes:cvMat.data length:cvMat.elemSize()*cvMat.total()];
    CGColorSpaceRef colorSpace;
    
    NSLog(@"%ld",8 * cvMat.elemSize());
    
    if (cvMat.elemSize() == 1) {
        colorSpace = CGColorSpaceCreateDeviceGray();
    } else {
        colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    
    // Creating CGImage from cv::Mat
    CGImageRef imageRef = CGImageCreate(cvMat.cols,                                 //width
                                        cvMat.rows,                                 //height
                                        8,                                          //bits per component
                                        8 * cvMat.elemSize(),                       //bits per pixel
                                        cvMat.step[0],                              //bytesPerRow
                                        colorSpace,                                 //colorspace
                                        kCGImageAlphaNone|kCGBitmapByteOrderDefault,// bitmap info
                                        provider,                                   //CGDataProviderRef
                                        NULL,                                       //decode
                                        false,                                      //should interpolate
                                        kCGRenderingIntentDefault                   //intent
                                        );
    
    
    // Getting UIImage from CGImage
    UIImage *finalImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    return finalImage;
}

- (cv::Mat)cvMatFromUIImage:(UIImage *)image
{
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat cvMat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels
    
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,                 // Pointer to  data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    cvMat.step[0],              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpace);
    
    return cvMat;
}

- (cv::Mat)kMeansClustering:(cv::Mat)input
{
    cv::cvtColor(input , input , CV_RGBA2RGB);
    cv::Mat samples(input.rows * input.cols, 3, CV_32F);
    
    for( int y = 0; y < input.rows; y++ ){
        for( int x = 0; x < input.cols; x++ ){
            for( int z = 0; z < 3; z++){
                samples.at<float>(y + x*input.rows, z) = input.at<cv::Vec3b>(y,x)[z];
            }
        }
    }
    
    int clusterCount = 5;
    cv::Mat labels;
    int attempts = 5;
    cv::Mat centers;
    kmeans(samples, clusterCount, labels, cv::TermCriteria(CV_TERMCRIT_ITER|CV_TERMCRIT_EPS, 100, 0.01), attempts, cv::KMEANS_PP_CENTERS, centers );
    
    
    cv::Mat new_image( input.rows, input.cols, input.type());
    
    
    for( int y = 0; y < input.rows; y++ ){
        for( int x = 0; x < input.cols; x++ )
        {
            int cluster_idx = labels.at<int>(y + x*input.rows,0);
            new_image.at<cv::Vec3b>(y,x)[0] = centers.at<float>(cluster_idx, 0);
            new_image.at<cv::Vec3b>(y,x)[1] = centers.at<float>(cluster_idx, 1);
            new_image.at<cv::Vec3b>(y,x)[2] = centers.at<float>(cluster_idx, 2);
        }
    }
    
    return new_image;
}

- (void)createColorPallet:(cv::Mat)input
{
    input = input.reshape(0,1);
    
    blueArray = [[NSMutableArray alloc] init];
    greenArray = [[NSMutableArray alloc] init];
    redArray = [[NSMutableArray alloc] init];
    
    for( int y = 0; y < input.rows; y++ ) {
        // ポインタの取得
        cv::Vec3b* ptr = input.ptr<cv::Vec3b>( y );
        for( int x = 0; x < input.cols; x++ ) {
            // 値の取得
            cv::Vec3b bgr = ptr[x];
            if (ptr[x-1] != ptr[x]) {
                int tempBlue = bgr[0];
                [blueArray addObject: [[NSNumber numberWithUnsignedInt:tempBlue] stringValue]];
                int tempGreen = bgr[1];
                [greenArray addObject: [[NSNumber numberWithUnsignedInt:tempGreen] stringValue]];
                int tempRed = bgr[2];
                [redArray addObject: [[NSNumber numberWithUnsignedInt:tempRed] stringValue]];
            }
        }
    }
    
    [blueArray removeDuplicatedObjects];
    [greenArray removeDuplicatedObjects];
    [redArray removeDuplicatedObjects];
}

- (void) addColorToView:(UIView *)view index:(NSInteger)index
{
    CGFloat red = [[redArray objectAtIndex:index] floatValue]/255;
    CGFloat green = [[greenArray objectAtIndex:index] floatValue]/255;
    CGFloat blue = [[blueArray objectAtIndex:index] floatValue]/255;
    view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

#pragma mark - View LifeCycle

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
    cv::Mat hub = [self cvMatFromUIImage:inputImage];
    cv::Mat hub2 = [self kMeansClustering:(cv::Mat)hub];
    [self createColorPallet:hub2];
    [self addColorToView:firstView index:0];
    [self addColorToView:secondView index:1];
    [self addColorToView:thirdView index:2];
    [self addColorToView:forthView index:3];
    [self addColorToView:fifthView index:4];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
