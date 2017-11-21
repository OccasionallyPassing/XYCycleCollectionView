//
//  DeallocTestViewController.m
//  XYCycleCollectionView
//
//  Created by MiPai on 2017/11/20.
//  Copyright © 2017年 wangyu. All rights reserved.
//

#import "DeallocTestViewController.h"
#import "XYScycleCollectionView.h"

@interface DeallocTestViewController ()<XYScycleCollectionViewDelegate>

@end

@implementation DeallocTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray *imagesURLStrings =  @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpg",@"8.jpg"];
    
    XYScycleCollectionView *cycleView = [[XYScycleCollectionView alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 200)];
    cycleView.placeholderImage = [UIImage imageNamed:@"placeholder.jpg"];
    cycleView.currentImage = [UIImage imageNamed:@"detail_tupianlunbo_suiji"];
    cycleView.defaultImage = [UIImage imageNamed:@"detail_piclunbounselec_suiji"];
    cycleView.isCorner = YES;
    cycleView.isShadow = YES;
    cycleView.cornerRadius = 20;
    cycleView.imageWidth = 350.f;
    cycleView.lineSpace = 5;
    cycleView.delegate = self;
    cycleView.imageArr = imagesURLStrings;
    [self.view addSubview:cycleView];
}
    
#pragma mark - XYScycleCollectionViewDelegate
- (void)scycleCollectionView:(XYScycleCollectionView *)scycleCollectionView didScrollToIndex:(NSInteger)index{
    if (index == 1) {
        scycleCollectionView.timerInterval = 10;
    }else{
        scycleCollectionView.timerInterval = 2;
    }
    NSLog(@"DeallocTestController scroll = %ld",index);
}
    
- (void)scycleCollectionView:(XYScycleCollectionView *)scycleCollectionView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"select = %ld",index);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
