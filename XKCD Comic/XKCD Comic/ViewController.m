//
//  ViewController.m
//  XKCD Comic
//
//  Created by Paul Solt on 2/27/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    //     Is there an interface for automated systems to access comics and metadata?
    //    Yes. You can get comics through the JSON interface, at URLs like http://xkcd.com/info.0.json (current comic) and http://xkcd.com/614/info.0.json (comic #614).
        //    https://.xkcd.com/comics/worst_thing_that_could_happen.png
        // http://xkcd.com/info.0.json = 2261

        NSURL *baseURL = [NSURL URLWithString:@"https://xkcd.com/"];




}


@end
