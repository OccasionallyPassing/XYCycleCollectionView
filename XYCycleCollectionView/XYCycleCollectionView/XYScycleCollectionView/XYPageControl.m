//
//  XYPageControl.m
//  XYCycleCollectionView
//
//  Created by MiPai on 2017/11/15.
//  Copyright © 2017年 wangyu. All rights reserved.
//

#import "XYPageControl.h"

@interface XYPageControl()

@property (nonatomic) CGSize size;

@end

@implementation XYPageControl

- (instancetype)init{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = NO;
    }
    return self;
}

-(void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
    
    if (self.currentImage && self.defaultImage) {
        self.size = self.currentImage.size;
    }else {
        self.size = CGSizeMake(7, 7);
    }
    
    if (self.pageSize.height && self.pageSize.width) {
        self.size = self.pageSize;
    }
    
    for (int i = 0; i < [self.subviews count]; i++) {
        UIView* dot = [self.subviews objectAtIndex:i];
        
        [dot setFrame:CGRectMake(dot.frame.origin.x, dot.frame.origin.y, self.size.width, self.size.width)];
        if ([dot.subviews count] == 0) {
            UIImageView * view = [[UIImageView alloc]initWithFrame:dot.bounds];
            [dot addSubview:view];
        };
        UIImageView * view = dot.subviews[0];
        
        if (i == self.currentPage) {
            if (self.currentImage) {
                view.image=self.currentImage;
                dot.backgroundColor = [UIColor clearColor];
            }else {
                view.image = nil;
                dot.backgroundColor = self.currentPageIndicatorTintColor;
            }
        }else if (self.defaultImage) {
            view.image=self.defaultImage;
            dot.backgroundColor = [UIColor clearColor];
        }else {
            view.image = nil;
            dot.backgroundColor = self.pageIndicatorTintColor;
        }
    }
}
@end
