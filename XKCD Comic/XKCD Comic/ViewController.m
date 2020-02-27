//
//  ViewController.m
//  XKCD Comic
//
//  Created by Paul Solt on 2/27/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "ViewController.h"
#import "LSIComic.h"

// Class extension (anonymous category)
@interface ViewController ()

// private property
@property (nonatomic) LSIComic *comic;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //     Is there an interface for automated systems to access comics and metadata?
    //    Yes. You can get comics through the JSON interface, at URLs like http://xkcd.com/info.0.json (current comic) and http://xkcd.com/614/info.0.json (comic #614).
    //    https://.xkcd.com/comics/worst_thing_that_could_happen.png
    // http://xkcd.com/info.0.json = 2261
    
    NSURL *baseURL = [NSURL URLWithString:@"https://xkcd.com/"];

    NSString *endPoint = @"info.0.json";
    int comicNumber = 2261; // 417 (portait)

    BOOL mostRecent = NO;

    NSURL *url = [baseURL URLByAppendingPathComponent:endPoint]; // http://xkcd.com/info.0.json

    if (!mostRecent) { // http://xkcd.com/2261/info.0.json
        NSString *comicNumberString = [NSString stringWithFormat:@"%i", comicNumber];
        url = [[baseURL URLByAppendingPathComponent: comicNumberString] URLByAppendingPathComponent:endPoint];
    }

    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"URL: %@", url);
        
        if (error) {
            NSLog(@"Error: %@", error);
            return;
        }
        
        if (!data) {
            NSLog(@"Error no data!");
            return;
        }
        
        // parse data
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            NSLog(@"Error parsing JSON data: %@", json);
            return;
        }
        
        LSIComic *comic = [[LSIComic alloc] initWithDictionary:json];
        
        NSLog(@"comic: %@", comic.imageURL);
        // update UI
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.titleLabel.text = comic.title;
        });
        
        [self downloadImageURL:comic.imageURL];
        
    }] resume];
    
    
}

- (void)downloadImageURL:(NSURL *)imageURL {
    
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"imageURL: %@", imageURL);
        
        if (error) {
            NSLog(@"Error: %@", error);
            return;
        }
        
        if (!data) {
            NSLog(@"Error no data!");
            return;
        }
        
        // parse data
        UIImage *image = [UIImage imageWithData:data];
        
        if (!image) {
            NSLog(@"Error no image with data: %@", data);
            return;
        }
        
        // update UI
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Downloaded image: %@", image);
            self.imageView.image = image;
        });
        
    }] resume];
}



@end
