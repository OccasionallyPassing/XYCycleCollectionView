//
//  XYScycleCollectionView.h
//  XYScyleCollectionView
//
//  Created by MiPai on 2017/11/14.
//  Copyright © 2017年 wangyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYScycleCollectionView;

@protocol XYScycleCollectionViewDelegate <NSObject>

@optional

- (void)scycleCollectionView:(XYScycleCollectionView *)scycleCollectionView didSelectItemAtIndex:(NSInteger)index;

- (void)scycleCollectionView:(XYScycleCollectionView *)scycleCollectionView didScrollToIndex:(NSInteger)index;

@end

@interface XYScycleCollectionView : UIView
//占位图
@property (nonatomic, strong) UIImage *placeholderImage;

//时间间隔，KVO监听，可以改变。
@property (nonatomic, assign) CGFloat timerInterval;

//如果时间间隔相同，不必添加KVO。默认YES
@property (nonatomic, assign) BOOL isSameTimerInterval;

//The space between the view of UIImage
@property (nonatomic, assign) CGFloat lineSpace;

//The width of the view of UIImage
@property (nonatomic, assign) CGFloat imageWidth;

//pageControl当前索引图片
@property (nonatomic, strong) UIImage *currentImage;

//pageControl默认索引图片
@property (nonatomic, strong) UIImage *defaultImage;

//pageControl大小
@property (nonatomic, assign) CGSize pageSize;

//图片是否有阴影，默认无阴影
@property (nonatomic, assign) BOOL isShadow;

//图片是否有圆角，默认无圆角
@property (nonatomic, assign) BOOL isCorner;

//图片圆角大小，默认是10
@property (nonatomic, assign) CGFloat cornerRadius;

//设置图片数组存放图片名或者图片URL，
//该属性尽量在所有属性设置之后设置，避免无法预估错误
@property (nonatomic, strong) NSArray *imageArr;

@property (nonatomic, weak) id <XYScycleCollectionViewDelegate> delegate;

//ps：轮播 不适合同时在内存中存在两个能改变timerInterval的XYScycleCollectionView对象，否则KVO监测会出现问题
@end
