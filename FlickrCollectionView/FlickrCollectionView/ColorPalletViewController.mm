//
//  CollerPalletViewController.m
//  FlickrCollectionView
//
//  Created by 山田 慶 on 2013/01/10.
//  Copyright (c) 2013年 山田 慶. All rights reserved.
//

#import "ColorPalletViewController.h"
#import "opencv2.framework/Headers/opencv.hpp"

@interface ColorPalletViewController ()
- (UIImage *)UIImageFromCVMat:(cv::Mat)cvMat;
- (cv::Mat)cvMatFromUIImage:(UIImage *)image;
- (cv::Mat)kMeansClustering:(cv::Mat)input;
@end

#define MAX_CLUSTERS 2 /* number of cluster */

@implementation ColorPalletViewController
@synthesize inputImage;
@synthesize imageView;

#pragma mark - Custom Methods

- (UIImage *)UIImageFromCVMat:(cv::Mat)cvMat
{
    NSData *data = [NSData dataWithBytes:cvMat.data length:cvMat.elemSize()*cvMat.total()];
    CGColorSpaceRef colorSpace;
    
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
//    cv::Mat p = cv::Mat::zeros(input.cols*input.rows, 5, CV_32F); //5×5のcvMatを0で初期化
//    cv::Mat bestLabels, centers, clustered;
////    cv::vector<cv::Mat> bgr;
//    cv::Mat bgr;
//    input.convertTo(bgr, CV_32FC3);
//    NSLog(@"channels:%d",input.channels());
//    NSLog(@"test-1");
//    bgr = bgr.reshape(1,input.rows*input.cols);
//    NSLog(@"test0");
////    cv::split(input, bgr); //inputをbgrに分割
//    // i think there is a better way to split pixel bgr color
////    for(int i=0; i<input.cols*input.rows; i++) {
////        p.at<float>(i,0) = (i/input.cols) / input.rows;
////        p.at<float>(i,1) = (i%input.cols) / input.cols;
////        p.at<float>(i,2) = bgr[0].data[i] / 255.0;
////        p.at<float>(i,3) = bgr[1].data[i] / 255.0;
////        p.at<float>(i,4) = bgr[2].data[i] / 255.0;
////    }
//    
//    NSLog(@"test1");
//    
//    cv::Mat_<int> clusters(bgr.size(),CV_32SC1);
//    
//    int K = 10;
////    cv::kmeans(bgr, K, bestLabels,
////               cvTermCriteria( CV_TERMCRIT_EPS+CV_TERMCRIT_ITER, 10, 1.0),
////               3, cv::KMEANS_PP_CENTERS, centers);
//    
//    cv::kmeans(bgr, K, clusters,
//               cvTermCriteria( CV_TERMCRIT_EPS+CV_TERMCRIT_ITER, 10, 1.0),
//               1, cv::KMEANS_PP_CENTERS, centers);
//    
//    NSLog(@"test2");
//    
//    cv::Mat dstImg(input.size(),input.type());
//    cv::MatIterator_<cv::Vec3f> itf = centers.begin<cv::Vec3f>();
//    cv::MatIterator_<cv::Vec3b> itd = dstImg.begin<cv::Vec3b>(), itd_end = dstImg.end<cv::Vec3b>();
//    
//    for(int i=0; itd != itd_end; ++itd, ++i) {
//        cv::Vec3f color = itf[clusters(1,i)];
//        (*itd)[0] = cv::saturate_cast<uchar>(color[2]);
//        (*itd)[1] = cv::saturate_cast<uchar>(color[1]);
//        (*itd)[2] = cv::saturate_cast<uchar>(color[0]);
//    }
//    
//    NSLog(@"test3");

    
//    int colors[K];
//    for(int i=0; i<K; i++) {
//        colors[i] = 255/(i+1);//?
//    }
//    // i think there is a better way to do this mayebe some Mat::reshape?
//    clustered = cv::Mat(input.rows, input.cols, CV_32FC3);
//    for(int i=0; i<input.cols*input.rows; i++) {
//        clustered.at<float>(i/input.cols, i%input.cols) = (float)(colors[bestLabels.at<int>(0,i)]);//?
//        //      cout << bestLabels.at<int>(0,i) << " " <<
//        //              colors[bestLabels.at<int>(0,i)] << " " <<
//        //              clustered.at<float>(i/src.cols, i%src.cols) << " " <<
//        //              endl;
//    }
    
//    clustered.convertTo(clustered, CV_8U);
    
//    return dstImg;
    
    cv::Mat samples(input.rows * input.cols, 3, CV_32F);
    for( int y = 0; y < input.rows; y++ )
        for( int x = 0; x < input.cols; x++ )
            for( int z = 0; z < 3; z++)
                samples.at<float>(y + x*input.rows, z) = input.at<cv::Vec3b>(y,x)[z];
    
    
    int clusterCount = 10;
    cv::Mat labels;
    int attempts = 5;
    cv::Mat centers;
    kmeans(samples, clusterCount, labels, cv::TermCriteria(CV_TERMCRIT_ITER|CV_TERMCRIT_EPS, 10, 1.0), attempts, cv::KMEANS_PP_CENTERS, centers );
    
    
    cv::Mat new_image( input.size(), input.type() );
    for( int y = 0; y < input.rows; y++ )
        for( int x = 0; x < input.cols; x++ )
        {
            int cluster_idx = labels.at<int>(y + x*input.rows,0);
            new_image.at<cv::Vec3b>(y,x)[0] = centers.at<float>(cluster_idx, 0);
            new_image.at<cv::Vec3b>(y,x)[1] = centers.at<float>(cluster_idx, 1);
            new_image.at<cv::Vec3b>(y,x)[2] = centers.at<float>(cluster_idx, 2);
        }
    
    return new_image;
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
    imageView.image = [self UIImageFromCVMat:hub2];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
