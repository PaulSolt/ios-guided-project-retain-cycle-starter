//
//  ViewController.m
//  iOS14-XKCD
//
//  Created by Paul Solt on 4/23/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "ViewController.h"
#import "LSIComic.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // Comic object
    
    // URLSession dataTask
    
    // 1. download comic json
    
    // 2. download image
    
    NSURL *baseURL = [NSURL URLWithString:@"https://xkcd.com/"];
    
    NSString *endPoint = @"info.0.json";
    int comicNumber = 2261; // 417 (portait)
    
    BOOL mostRecent = NO;
    
    NSURL *url = [baseURL URLByAppendingPathComponent:endPoint]; // http://xkcd.com/info.0.json
    
    if (!mostRecent) { // http://xkcd.com/2261/info.0.json
        NSString *comicNumberString = [NSString stringWithFormat:@"%i", comicNumber];
        url = [[baseURL URLByAppendingPathComponent: comicNumberString] URLByAppendingPathComponent:endPoint];
    }
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"Url: %@", url);
        
        if (error) {
            NSLog(@"Error: %@", error);
            return;
        }
        
        // TODO: data is not nil
        
        // sometimes you must check for type
        // isKindOfClass method
        
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

        if (jsonError) {
            NSLog(@"JSON Error: %@", jsonError);
            return;
        }

        LSIComic *comic = [[LSIComic alloc] initWithDictionary:json];

        NSLog(@"comic: %@", comic.imageURL);
        
        // Display text content
        dispatch_async(dispatch_get_main_queue(), ^{
            self.titleLabel.text = comic.title;
        });
        
        // It is possible to load image data with dataWithContents of URL, just be careful that this is
        // either done to sanity check an API, or for super quick and dirty MVP
        // It will block UI updates if done on the main thread
        
//        NSData *imageData = [NSData dataWithContentsOfURL:comic.imageURL]; // sync call (we have to wait until it finishes
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.imageView.image = // image
//        });

        [self downloadImage:comic.imageURL]; //async
        
    }] resume];
    
}

- (void)downloadImage:(NSURL *)imageURL {
    [[NSURLSession.sharedSession dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"imageURL: %@", imageURL);
        
        if (error) {
            NSLog(@"Error: %@", error);
            return;
        }
        
        // TODO: data is not nil
        
        // NSData object with image data
        UIImage *image = [UIImage imageWithData:data];
        
        NSLog(@"image.size: %@", NSStringFromCGSize(image.size));
        
        // Display image based content
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });

    }] resume];
}


@end
