//
//  LSIComic.h
//  iOS15-XKCD
//
//  Created by Paul Solt on 5/21/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIComic : NSObject

@property NSString *title;
@property NSString *alt;
@property NSURL *imageURL;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
