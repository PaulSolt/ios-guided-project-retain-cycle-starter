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

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *alt;
@property (nonatomic) NSURL *imageURL;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
