//
//  FCFlickrAPIRequest.h
//  FlickrCollection
//
//  Created by MacBook Pro on 11/27/13.
//  Copyright (c) 2013 MacBook Pro. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FCFlickrPhoto;

typedef void (^FlickrSearchCompletionBlock)(NSArray *results, NSError *error);

@interface FCFlickrAPIRequest : NSObject

- (NSURL *)getFlickrSearchRequestURLForSearchTerm:(NSString *)searchTerm;
- (NSURL *)flickrPhotoSourceURLForPhoto:(FCFlickrPhoto *)photo withSize:(NSString *)photoSize;
- (void)searchFlickrForTerm:(NSString *)searchTerm completionBlock:(FlickrSearchCompletionBlock)completionBlock;

@end
