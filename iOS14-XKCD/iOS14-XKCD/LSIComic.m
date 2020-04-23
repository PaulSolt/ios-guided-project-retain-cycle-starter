//
//  LSIComic.m
//  iOS14-XKCD
//
//  Created by Paul Solt on 4/23/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIComic.h"

@implementation LSIComic

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _title = dictionary[@"title"];
        NSString *imageURLString = dictionary[@"img"];
        _imageURL = [NSURL URLWithString:imageURLString];
        _alt = dictionary[@"alt"];
    }
    return self;
}

@end
