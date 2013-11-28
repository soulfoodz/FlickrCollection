//
//  FCFlickrCollectionHeaderView.m
//  FlickrCollection
//
//  Created by MacBook Pro on 11/26/13.
//  Copyright (c) 2013 MacBook Pro. All rights reserved.
//

#import "FCFlickrCollectionHeaderView.h"

@interface FCFlickrCollectionHeaderView()

@property (weak, nonatomic) IBOutlet UIView *mainHeaderView;


@end

@implementation FCFlickrCollectionHeaderView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _mainHeaderView.layer.cornerRadius = 4.0f;
}

@end
