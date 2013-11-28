//
//  FCFlickrCollectionCell.m
//  FlickrCollection
//
//  Created by MacBook Pro on 11/26/13.
//  Copyright (c) 2013 MacBook Pro. All rights reserved.
//

#import "FCFlickrCollectionCell.h"
#import "FCFlickrPhoto.h"

@interface FCFlickrCollectionCell()

@property (weak, nonatomic) IBOutlet UIView   *mainView;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIView *footerView;

@end

@implementation FCFlickrCollectionCell

@synthesize mainView;
@synthesize button;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    mainView.clipsToBounds       = YES;
    mainView.layer.cornerRadius  = 4.0f;
    mainView.layer.shadowColor   = [UIColor lightGrayColor].CGColor;
    mainView.layer.shadowOpacity = 0.2f;
    mainView.layer.shadowOffset  = CGSizeMake(0, 1.0);
    mainView.layer.shadowPath    = [[UIBezierPath bezierPathWithRoundedRect:mainView.frame cornerRadius:4.0f] CGPath];
    
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
}
                        
                        

@end
