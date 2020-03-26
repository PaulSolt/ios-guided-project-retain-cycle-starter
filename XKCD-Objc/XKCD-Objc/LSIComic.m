//
//  LSIComic.m
//  XKCD-Objc
//
//  Created by Paul Solt on 3/26/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIComic.h"

@implementation LSIComic

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        
        NSString *title = dictionary[@"title"];
        NSString *imageURLString = dictionary[@"img"];
        NSURL *imageURL = [[NSURL alloc] initWithString:imageURLString];
        NSString *alt = dictionary[@"alt"];
        
        // What happens when alt is null ? -> NSNull
        if ([alt isKindOfClass:[NSNull class]]) {
            // alt is missing from json response
            // let's not make alt required, and default to nil
            alt = nil;
        }
        
        // Required properties (subject to change if API has optionals)
        if (!(title && imageURLString && imageURL)) {
            return nil;
        }
        
        _title = title;
        _imageURL = imageURL;
        _alt = alt;
    }
    return self;
}

@end
