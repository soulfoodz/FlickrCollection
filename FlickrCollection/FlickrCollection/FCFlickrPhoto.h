//
//  FCFlickrPhoto.h
//  FlickrCollection
//
//  Created by MacBook Pro on 11/27/13.
//  Copyright (c) 2013 MacBook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCFlickrPhoto : UIImage

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *secret;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *owner;
@property (strong, nonatomic) NSString *server;
@property (strong, nonatomic) NSNumber *farm;
@property (strong, nonatomic) UIImage  *thumbnail;

@end
