//
//  ViewController.m
//  iOS15-XKCD
//
//  Created by Paul Solt on 5/21/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "ViewController.h"
#import "LSIComic.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // XKCD
    
    // Comic (parse JSON) -> model
    
    // Network call
    
    //    1. Download JSON
    // 2. Download image

    NSURL *baseURL = [NSURL URLWithString:@"https://xkcd.com/"];
    
    NSString *endPoint = @"info.0.json";
    int comicNumber = 2261; // 417 (portait)
    
    BOOL mostRecent = NO;
    
    NSURL *url = [baseURL URLByAppendingPathComponent:endPoint]; // http://xkcd.com/info.0.json
    
    if (!mostRecent) { // http://xkcd.com/2261/info.0.json
        NSString *comicNumberString = [NSString stringWithFormat:@"%i", comicNumber];
        url = [[baseURL URLByAppendingPathComponent: comicNumberString] URLByAppendingPathComponent:endPoint];
    }

    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"url: %@", url);
        
        if (error) { // error != nil // is the error non-zero
            NSLog(@"Error downloading comic json: %@", error);
        }
        
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            NSLog(@"JSON error: %@", error);
        }
        
        LSIComic *comic = [[LSIComic alloc] initWithDictionary:json];
        
        NSLog(@"comic %@", comic.imageURL);
        
    }];
    [task resume];
    
}


@end
