//
//  LSIComic.h
//  XKCD Comic
//
//  Created by Paul Solt on 2/27/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIComic : NSObject

@property (nonatomic, copy) NSString *alt;
@property (nonatomic, copy) NSString *transcript;
@property (nonatomic, copy) NSString *title;

@property (nonatomic) NSURL *imageURL;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
