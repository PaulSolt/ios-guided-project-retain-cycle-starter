//
//  ViewController.m
//  XKCD-Objc
//
//  Created by Paul Solt on 3/26/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "ViewController.h"
#import "LSIComic.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

/*
 
 Is there an interface for automated systems to access comics and metadata?
 
 Yes. You can get comics through the JSON interface, at URLs like http://xkcd.com/info.0.json (current comic) and http://xkcd.com/614/info.0.json (comic #614).

 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSURL *baseURL = [NSURL URLWithString:@"https://xkcd.com/"];
    
    NSString *endPoint = @"info.0.json";
    int comicNumber = 2261; // 417 (portait)
    
    BOOL mostRecent = NO;
    
    NSURL *url = [baseURL URLByAppendingPathComponent:endPoint]; // http://xkcd.com/info.0.json
    
    if (!mostRecent) { // http://xkcd.com/2261/info.0.json
        NSString *comicNumberString = [NSString stringWithFormat:@"%i", comicNumber];
        url = [[baseURL URLByAppendingPathComponent: comicNumberString] URLByAppendingPathComponent:endPoint];
    }

    NSLog(@"Url: %@", url);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error: %@", error);
            return;
        }
        
        // TODO: data is nil
        
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            NSLog(@"Json error: %@", jsonError);
            return;
        }
        
        LSIComic *comic = [[LSIComic alloc] initWithDictionary:json];
        
        NSLog(@"Comic: %@", comic.title);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // TODO: update the UI here
            self.titleLabel.text = comic.title;
        });
        
        // download the image
        [self downloadImageWithURL:comic.imageURL];
        
    }] resume];
    
}

- (void)downloadImageWithURL:(NSURL *)url {
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error: %@", error);
            return;
        }
        
        // TODO: data is nil
        
//        NSData -> UIImage
        UIImage *image = [[UIImage alloc] initWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // TODO: update the UI here
            
            NSLog(@"Image: %@", NSStringFromCGSize(image.size));
            self.imageView.image = image;
        });
        
    }] resume];
}


@end
