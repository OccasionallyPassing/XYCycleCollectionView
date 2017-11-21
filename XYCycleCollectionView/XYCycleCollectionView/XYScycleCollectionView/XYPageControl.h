//
//  XYPageControl.h
//  XYCycleCollectionView
//
//  Created by MiPai on 2017/11/15.
//  Copyright © 2017年 wangyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYPageControl : UIPageControl

@property (nonatomic)   UIImage * currentImage; //高亮图片
@property (nonatomic)   UIImage * defaultImage; //默认图片
@property (nonatomic,assign)   CGSize pageSize; //图标大小


@end
