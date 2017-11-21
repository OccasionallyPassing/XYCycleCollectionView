//
//  XYCollectionViewCell.h
//  XYScyleCollectionView
//
//  Created by MiPai on 2017/11/14.
//  Copyright © 2017年 wangyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *cycleImage;
@property (nonatomic, assign) BOOL isShadow;
@property (nonatomic, assign) BOOL isCorner;
@property (nonatomic, assign) CGFloat cornerRadius;

@end
