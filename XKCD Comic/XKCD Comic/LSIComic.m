//
//  LSIComic.m
//  XKCD Comic
//
//  Created by Paul Solt on 2/27/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIComic.h"

@implementation LSIComic

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
     
        self.alt = dictionary[@"alt"];
        self.title = dictionary[@"title"];
        
        NSString *transcript = dictionary[@"transcript"];
        
        // TODO: What happens when transcript is nil?
        if ([transcript isKindOfClass:[NSString class]]) {
            self.transcript = transcript;
        } else if ([transcript isKindOfClass:[NSNull class]]) {
            self.transcript = @"";
        }
        
        NSString *imageURLString = dictionary[@"img"];
        self.imageURL = [NSURL URLWithString:imageURLString];
        
        // TODO: failable init later
        
    }
    return self;
}

@end
