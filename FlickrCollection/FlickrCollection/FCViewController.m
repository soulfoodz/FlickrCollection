//
//  FCViewController.m
//  FlickrCollection
//
//  Created by MacBook Pro on 11/26/13.
//  Copyright (c) 2013 MacBook Pro. All rights reserved.
//

#import "FCViewController.h"
#import "FCFlickrCollectionCell.h"
#import "FCFlickrCollectionHeaderView.h"
#import "FCFlickrAPIRequest.h"
#import "FCFlickrPhoto.h"

#define searchTerm @"bear"

@interface FCViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray          *photosArray;

@end

@implementation FCViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.photosArray = [NSMutableArray new];
    
    [self searchFlickrForPhotosMatchingSearchTerm:searchTerm];
    
    // If not using a custom class...
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}


- (void)searchFlickrForPhotosMatchingSearchTerm:(NSString *)term
{
    FCFlickrAPIRequest *searchRequest;
    
    searchRequest = [FCFlickrAPIRequest new];
    [searchRequest searchFlickrForTerm:term
                       completionBlock:^(NSArray *results, NSError *error)
    {
                           if (error)
                               NSLog(@"**ERROR: during search request %@", error);
                           else if (results)
                           {
                               self.photosArray = [NSMutableArray arrayWithArray:results];
                               [_collectionView reloadData];
                           }
    }];
}


#pragma mark - CollectionView DataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.photosArray)
        return self.photosArray.count;
    else
        return 0;
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    FCFlickrCollectionHeaderView *header;
    
    header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                withReuseIdentifier:@"flickerHeader"
                                                       forIndexPath:indexPath];

    return header;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FCFlickrCollectionCell *cell;
    FCFlickrPhoto          *flickrPhoto;
    
    cell = [cv dequeueReusableCellWithReuseIdentifier:@"cell"
                                         forIndexPath:indexPath];
    
    flickrPhoto          = (FCFlickrPhoto *)self.photosArray[indexPath.row];
    cell.imageView.image = flickrPhoto.thumbnail;

    return cell;
}


#pragma mark - CollectionView Delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - CollectionView FlowLayoutDelegate

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(300, 200);
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(12, 12, 12, 12);
}













@end
