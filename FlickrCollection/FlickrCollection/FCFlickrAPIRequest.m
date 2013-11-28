//
//  FCFlickrAPIRequest.m
//  FlickrCollection
//
//  Created by MacBook Pro on 11/27/13.
//  Copyright (c) 2013 MacBook Pro. All rights reserved.
//

#import "FCFlickrAPIRequest.h"
#import "FCFlickrPhoto.h"

#define APIKey     @"90140be6fe1324bdf4bc23b98db21e4b"
#define appSecret  @"7f489d621bb84d35"

@implementation FCFlickrAPIRequest


// Constructs and returns the request url for the search term passed in
- (NSURL *)getFlickrSearchRequestURLForSearchTerm:(NSString *)searchTerm
{
    NSString *urlString;
    NSString *endpointString;
    NSURL    *searchURL;
    
    // Flickr endpoint
    // Base URL for any Flickr photo search request
    endpointString = @"https://api.flickr.com/services/rest/?method=flickr.photos.search";
    
    // add our app APIkey and search parameters, all separated by &
    urlString = [NSString stringWithFormat:@"%@&api_key=%@&text=%@&content_type=1&per_page=10&privacy_filter=1&format=json&nojsoncallback=1", endpointString, APIKey, searchTerm];
    
    searchURL = [NSURL URLWithString:urlString];
    return searchURL;
}


// Constructs and returns the request url for the photo passed in
- (NSURL *)flickrPhotoSourceURLForPhoto:(FCFlickrPhoto *)photo withSize:(NSString *)photoSize;
{
    NSString *urlString;
    NSURL    *photoURL;
    
    // If no photoSize, grab the "medium" size photo that is 240 on its longest side
    if (!photoSize) photoSize = @"m";

    urlString = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@_%@.jpg",photo.farm, photo.server, photo.id, photo.secret, photoSize];
    photoURL  = [NSURL URLWithString:urlString];
    
    return photoURL;
}


// Requests the data from flickr and passes the data returned from the request via the completion block
- (void)searchFlickrForTerm:(NSString *)searchTerm completionBlock:(FlickrSearchCompletionBlock)completionBlock
{
    NSURL        *searchURL;
    NSURLRequest *request;
    
    searchURL = [self getFlickrSearchRequestURLForSearchTerm:searchTerm];
    request   = [NSURLRequest requestWithURL:searchURL];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary   *dataDict;
        NSMutableArray *photoDictArray;
        NSMutableArray *flickrPhotoArray;
        
        dataDict = [NSJSONSerialization JSONObjectWithData:data
                                                   options:0
                                                     error:&connectionError];
        
        // If there's an error, send back the completion block with the error
        // Else, pull out the data
        if (connectionError) completionBlock(nil, connectionError);
        
        photoDictArray   = (NSMutableArray *)dataDict[@"photos"][@"photo"];
        flickrPhotoArray = [NSMutableArray new];
        
        for (NSDictionary *photo in photoDictArray)
        {
            FCFlickrPhoto *newPhoto;
            NSURL         *imageURL;
            NSData        *imageData;
            
            // Set the flickr photo's properties
            newPhoto        = [FCFlickrPhoto new];
            newPhoto.id     = photo[@"id"];
            newPhoto.title  = photo[@"tile"];
            newPhoto.farm   = photo[@"farm"];
            newPhoto.secret = photo[@"secret"];
            newPhoto.server = photo[@"server"];
            
            // Fetch the image from flickr
            imageURL           = [self flickrPhotoSourceURLForPhoto:newPhoto withSize:nil];
            imageData          = [NSData dataWithContentsOfURL:imageURL];
            newPhoto.thumbnail = [UIImage imageWithData:imageData];
            
            // Add the photo to the Array
            [flickrPhotoArray addObject:newPhoto];
        }
        
        // Return the loaded flickrPhotoArray
        completionBlock(flickrPhotoArray, nil);
    }];
}





@end
