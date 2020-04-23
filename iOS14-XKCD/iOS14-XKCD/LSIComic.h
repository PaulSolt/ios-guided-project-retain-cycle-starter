//
//  LSIComic.h
//  iOS14-XKCD
//
//  Created by Paul Solt on 4/23/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIComic : NSObject

@property NSString *title;
@property NSURL *imageURL;
@property NSString *alt;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
