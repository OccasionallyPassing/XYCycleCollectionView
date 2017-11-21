//
//  XYCollectionViewFlowLayout.m
//  XYScyleCollectionView
//
//  Created by MiPai on 2017/11/14.
//  Copyright © 2017年 wangyu. All rights reserved.
//

#import "XYCollectionViewFlowLayout.h"

@implementation XYCollectionViewFlowLayout

- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (void)prepareLayout
{
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat inset = (self.collectionView.frame.size.width - self.itemSize.width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *array = [self copyAttributes: [super layoutAttributesForElementsInRect:rect]];
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        CGFloat delta = fabs(attrs.center.x - centerX);
        CGFloat screenScale = delta /self.collectionView.bounds.size.width;
        CGFloat scale = fabs(cos(screenScale * M_PI/4));
        attrs.transform = CGAffineTransformMakeScale(1, scale);
    }
    return array;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.frame.size;
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(minDelta) > ABS(attrs.center.x - centerX)) {
            minDelta = attrs.center.x - centerX;
        }
    }
    proposedContentOffset.x += minDelta;
    return proposedContentOffset;
}

//这里会有个错误This is likely occurring because the flow layout subclass LineLayout is modifying attributes returned by UICollectionViewFlowLayout without copying them
//参考http://blog.csdn.net/xytgr/article/details/49402099
-(NSArray *)copyAttributes:(NSArray  *)arr{
    NSMutableArray *copyArr = [NSMutableArray new];
    for (UICollectionViewLayoutAttributes *attribute in arr) {
        [copyArr addObject:[attribute copy]];
    }
    
    return copyArr;
}

@end
