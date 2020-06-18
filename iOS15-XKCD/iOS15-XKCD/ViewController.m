//
//  ViewController.m
//  iOS15-XKCD
//
//  Created by Paul Solt on 5/21/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "ViewController.h"
#import "LSIComic.h"

// Class extension
@interface ViewController ()

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // XKCD
    
    // Comic (parse JSON) -> model
    
    // Network call
    
    // 1. Download JSON
    // 2. Download image

    BOOL mostRecent = NO;
    int comicNumber = 2261; // 417 (portait)

    NSURL *baseURL = [NSURL URLWithString:@"https://xkcd.com/"];
    NSString *endPoint = @"info.0.json";
    
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
            return;
        }
        
        LSIComic *comic = [[LSIComic alloc] initWithDictionary:json];
        
        NSLog(@"comic %@", comic.imageURL);
        
        // update the UI
        dispatch_async(dispatch_get_main_queue(), ^{
//            self.comic = comic;
//            [self updateViews];
            self.titleLabel.text = comic.title;
        });
        
        // make 2nd request
        [self downloadImageWithURL: comic.imageURL];
    }];
    [task resume];
    
//    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
//    redView.userInteractionEnabled = YES;
//    redView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:redView];
//    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:NSSelectorFromString(@"handlePan:")];
//    [redView addGestureRecognizer:panGesture];
}

- (void)handlePan:(UIPanGestureRecognizer *)panGesture {
    // Get the change in translation (delta)
    CGPoint translation = [panGesture locationInView:panGesture.view];
    [panGesture setTranslation:CGPointZero inView:panGesture.view];
    
    // Always check the state (began and ended will be called once for any setup/teardown logic)
    if (panGesture.state == UIGestureRecognizerStateChanged) {
        NSLog(@"Pan: %@", NSStringFromCGPoint(translation));
        CGPoint center = panGesture.view.center;
        CGSize size = panGesture.view.bounds.size;
        [panGesture.view setCenter:CGPointMake(center.x + translation.x - size.width / 2,
                                               center.y + translation.y - size.height / 2)];
    }
}

- (void)updateViews {
    // TODO: pull in data
}

- (void)downloadImageWithURL:(NSURL *)url {
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"url: %@", url);
        
        if (error) { // error != nil // is the error non-zero
            NSLog(@"Error downloading image: %@", error);
            return;
        }
        
        UIImage *image = [UIImage imageWithData:data]; // TODO: check it's valid
        
        // update the UI
        dispatch_async(dispatch_get_main_queue(), ^{
            // [self updateViews];
            self.imageView.image = image;
        });
        
    }];
    [task resume];
}

@end
