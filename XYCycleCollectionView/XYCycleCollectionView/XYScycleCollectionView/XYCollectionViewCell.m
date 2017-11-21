//
//  XYCollectionViewCell.m
//  XYScyleCollectionView
//
//  Created by MiPai on 2017/11/14.
//  Copyright © 2017年 wangyu. All rights reserved.
//

#import "XYCollectionViewCell.h"

@interface XYCollectionViewCell()

@property (nonatomic, strong) UIView *shadowView;

@end

@implementation XYCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.isCorner = NO;
        self.isShadow = NO;
        [self.contentView addSubview:self.shadowView];
        [self.contentView addSubview:self.cycleImage];
    }
    return self;
}

- (UIImageView *)cycleImage{
    if (!_cycleImage) {
        _cycleImage = [UIImageView new];
    }
    return _cycleImage;
}

- (UIView *)shadowView{
    if (!_shadowView) {
        _shadowView = [UIView new];
    }
    return _shadowView;
}

- (void)setCornerRadius:(CGFloat)cornerRadius{
    if (cornerRadius <= 0) {
        _cornerRadius = 10;
    }else{
        _cornerRadius = cornerRadius;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect rect = CGRectMake(2, 2, self.contentView.frame.size.width - 4, self.contentView.frame.size.height - 4);
    self.cycleImage.frame = rect;
    if (self.isCorner) {
        self.cycleImage.layer.cornerRadius = self.cornerRadius;
        self.cycleImage.layer.masksToBounds = YES;
    }
    if (self.isShadow) {
        self.shadowView.frame =rect;
        self.shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
        self.shadowView.layer.shadowOffset = CGSizeMake(0, 0);
        self.shadowView.layer.shadowOpacity = 0.8;
        self.shadowView.layer.shadowRadius = 4;
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
        self.shadowView.layer.shadowPath = bezierPath.CGPath;
    }else{
        [self.shadowView removeFromSuperview];;
    }
}

@end
