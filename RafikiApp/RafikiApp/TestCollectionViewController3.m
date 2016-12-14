//
//  TestCollectionViewController3.m
//  PageMenuDemoStoryboard
//
//  Created by Jin Sasaki on 2015/06/05.
//  Copyright (c) 2015年 Jin Sasaki. All rights reserved.
//


#import "TestCollectionViewController3.h"

@interface TestCollectionViewController3 ()
@property (nonatomic) NSArray *moodArray;
@property (nonatomic) NSArray *backgroundPhotoNameArray;
@property (nonatomic) NSArray *photoNameArray;
@end

@implementation TestCollectionViewController3

static NSString * const reuseIdentifier = @"MoodCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.moodArray = @[@"Fitness", @"Sports", @"Beauty", @"Therapeutic", @"Instruments", @"Education", @"Dining", @"Photography", @"Automotive"];
    self.backgroundPhotoNameArray = @[@"mood1.jpg", @"mood2.jpg", @"mood3.jpg", @"mood4.jpg", @"mood5.jpg", @"mood6.jpg", @"mood7.jpg", @"mood8.jpg", @"mood8.jpg"];
    self.photoNameArray = @[@"my0.png", @"my1.png", @"my2.png", @"my3.png", @"my4.png", @"my5.png", @"my6.png", @"my7.png", @"my8.png"];
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MoodCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MoodCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    cell.moodTitleLabel.text = self.moodArray[indexPath.row];
    cell.backgroundImageView.image = [UIImage imageNamed: self.backgroundPhotoNameArray[indexPath.row]];
    cell.moodIconImageView.image = [UIImage imageNamed: self.photoNameArray[indexPath.row]];
    
    
    return cell;
}
#pragma mark -
#pragma mark - UICollectionViewFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat picDimension = self.view.frame.size.width / 4.0f;
    return CGSizeMake(picDimension, picDimension);
}


@end
