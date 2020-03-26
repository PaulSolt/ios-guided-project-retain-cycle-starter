//
//  LSIComic.h
//  XKCD-Objc
//
//  Created by Paul Solt on 3/26/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIComic : NSObject

// weak
//@property (nonatomic, weak) NSString *title; // title will not be held onto
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSURL *imageURL;
@property (nonatomic, readonly) NSString *alt;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
