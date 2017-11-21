//
//  XYScycleCollectionView.m
//  XYScyleCollectionView
//
//  Created by MiPai on 2017/11/14.
//  Copyright © 2017年 wangyu. All rights reserved.
//

#import "XYScycleCollectionView.h"
#import "XYCollectionViewCell.h"
#import "XYCollectionViewFlowLayout.h"
#import "XYPageControl.h"
#import "UIImageView+WebCache.h"

@interface XYScycleCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>{
    NSInteger currentIndex;
    NSInteger count;//真实图片数量
    NSInteger repeatCount;//100*count
    NSTimer *timer;
    CGFloat scrollWidthOnce;
}
@property (nonatomic, strong) UICollectionView *cycleCollectionView;
@property (nonatomic, strong) XYPageControl *pageCtrl;

@end

@implementation XYScycleCollectionView

#pragma mark - lifeCycle
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = self.superview.backgroundColor;
        currentIndex = 0;
        self.imageWidth = 300.f;
        self.lineSpace = 10.f;
        scrollWidthOnce = self.imageWidth + self.lineSpace;
        
        self.timerInterval = 5.f;
        self.isSameTimerInterval = YES;
    }
    return self;
}

- (void)dealloc{
    [timer invalidate];
    timer = nil;
    [self removeObserver:self forKeyPath:@"timerInterval"];
}

#pragma mark - timer
- (void)createTimer {
    __weak typeof(self) weakSelf = self;
    timer = [NSTimer scheduledTimerWithTimeInterval:self.timerInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        [weakSelf timerAction];
        
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)timerAction {
    
    currentIndex++;
    [_cycleCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    timer.fireDate = [NSDate dateWithTimeInterval:[change[@"new"] integerValue] sinceDate:[NSDate date]];
}
    
#pragma mark - private Method
- (NSInteger)scrollViewCurrentIndex:(UIScrollView *)scrollView{
    NSInteger tmpIndex = scrollView.contentOffset.x/scrollWidthOnce;
    if (scrollView.contentOffset.x == 0) {
        tmpIndex = count;
    }else{
        if (tmpIndex%count == 0) {
            tmpIndex = count;
        }else{
            tmpIndex = tmpIndex%count;
        }
    }
    return tmpIndex;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(scycleCollectionView:didScrollToIndex:)]) {
        [self.delegate scycleCollectionView:self didScrollToIndex:[self scrollViewCurrentIndex:scrollView]];
    }
}
    
//代码来调用滑动偏移，同时有animation，animation停止的时候调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.x == (repeatCount + 1)*scrollWidthOnce) {

        [_cycleCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        currentIndex = 1;
    }
    if ([self.delegate respondsToSelector:@selector(scycleCollectionView:didScrollToIndex:)]) {
        [self.delegate scycleCollectionView:self didScrollToIndex:[self scrollViewCurrentIndex:scrollView]];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == (repeatCount + 1)*scrollWidthOnce) {
        
        [_cycleCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        currentIndex = 1;
    } else if (scrollView.contentOffset.x == 0) {

        [_cycleCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:repeatCount inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        currentIndex = repeatCount;
    }
    //避免手动拖动出现快速滑动问题
    currentIndex = scrollView.contentOffset.x/scrollWidthOnce;
    
    _pageCtrl.currentPage = [self scrollViewCurrentIndex:scrollView] - 1;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [timer invalidate];
    timer = nil;
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [self createTimer];
    
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return repeatCount + 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XYCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"XYCollectionViewCell" forIndexPath:indexPath];
    cell.isCorner = self.isCorner;
    cell.isShadow = self.isShadow;
    cell.cornerRadius = self.cornerRadius;
    
    NSString *imagePath = nil;
    if (indexPath.row == 0) {
        imagePath = _imageArr[count - 1];
    } else if (indexPath.row == repeatCount + 1) {
        imagePath = _imageArr[0];
    } else {
        if (indexPath.row%count == 0) {
            imagePath = _imageArr[count - 1];
        }else{
            imagePath = _imageArr[indexPath.row%count - 1];
        }
    }
    
    if ([imagePath hasPrefix:@"http"]) {
        [cell.cycleImage sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:self.placeholderImage];
    }else{
        cell.cycleImage.image = [UIImage imageNamed:imagePath];
    }

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(scycleCollectionView:didSelectItemAtIndex:)]) {
        NSInteger index = indexPath.row;
        if (indexPath.row == repeatCount + 1) {
            index = 1;
        }else if (indexPath.row == 0){
            index = count;
        }else{
            if (indexPath.row%count == 0) {
                index = count;
            }else{
                index = indexPath.row%count;
            }
        }
        [self.delegate scycleCollectionView:self didSelectItemAtIndex:index];
    }
}

#pragma mark - getters and setters
- (void)setImageArr:(NSArray *)imageArr{
    _imageArr = imageArr;
    count = _imageArr.count;
    repeatCount = _imageArr.count*100;
    
    [self addSubview:self.cycleCollectionView];
    
    //设置它的偏移量
    self.cycleCollectionView.contentOffset = CGPointMake(scrollWidthOnce, 0.f);
    
    //开启定时器
    [self createTimer];
    
    //回调个代理
    if ([self.delegate respondsToSelector:@selector(scycleCollectionView:didScrollToIndex:)]) {
        [self.delegate scycleCollectionView:self didScrollToIndex:1];
    }
    
    [self addSubview:self.pageCtrl];
}

- (UICollectionView *)cycleCollectionView{
    if (!_cycleCollectionView) {
        XYCollectionViewFlowLayout *flowLayout = [[XYCollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(self.imageWidth, self.frame.size.height);
        flowLayout.minimumLineSpacing = self.lineSpace;
        _cycleCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:flowLayout];
        _cycleCollectionView.backgroundColor = self.superview.backgroundColor;
        _cycleCollectionView.delegate = self;
        _cycleCollectionView.dataSource = self;
        _cycleCollectionView.bounces = NO;
        _cycleCollectionView.decelerationRate = UIScrollViewDecelerationRateFast;
        _cycleCollectionView.showsVerticalScrollIndicator = NO;
        _cycleCollectionView.showsHorizontalScrollIndicator = NO;
        [_cycleCollectionView registerClass:[XYCollectionViewCell class] forCellWithReuseIdentifier:@"XYCollectionViewCell"];
    }
    return _cycleCollectionView;
}

- (XYPageControl *)pageCtrl{
    if (!_pageCtrl) {
        CGFloat pageHeight = 20.f;
        _pageCtrl = [[XYPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - pageHeight, self.frame.size.width, pageHeight)];
        _pageCtrl.numberOfPages = _imageArr.count;
        if (self.currentImage && self.defaultImage) {
            _pageCtrl.currentImage = self.currentImage;
            _pageCtrl.defaultImage = self.defaultImage;
        }
        _pageCtrl.pageSize = self.pageSize;
    }
    return _pageCtrl;
}

- (void)setIsSameTimerInterval:(BOOL)isSameTimerInterval{
    _isSameTimerInterval = isSameTimerInterval;
    if (isSameTimerInterval) {
        [self addObserver:self forKeyPath:@"timerInterval" options:NSKeyValueObservingOptionNew context:nil];
    }else{
        [self removeObserver:self forKeyPath:@"timerInterval"];
    }
}

- (void)setImageWidth:(CGFloat)imageWidth{
    _imageWidth = imageWidth;
    scrollWidthOnce = _imageWidth + self.lineSpace;
}

- (void)setLineSpace:(CGFloat)lineSpace{
    _lineSpace = lineSpace;
    scrollWidthOnce = self.imageWidth + _lineSpace;
}
@end
