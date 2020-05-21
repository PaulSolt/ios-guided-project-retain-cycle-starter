//
//  LSIComic.m
//  iOS15-XKCD
//
//  Created by Paul Solt on 5/21/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIComic.h"

@implementation LSIComic

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (!self) { return nil; }
    
    _title = dictionary[@"title"];
    _alt = dictionary[@"alt"];
    
    NSString *imageURLString = dictionary[@"img"];
    _imageURL = [NSURL URLWithString:imageURLString];
    
    return self;
}

@end
