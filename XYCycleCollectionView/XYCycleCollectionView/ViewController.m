//
//  ViewController.m
//  XYCycleCollectionView
//
//  Created by MiPai on 2017/11/15.
//  Copyright © 2017年 wangyu. All rights reserved.
//

#import "ViewController.h"
#import "DeallocTestViewController.h"
#import "XYCollectionViewCell.h"
#import "XYCollectionViewFlowLayout.h"
#import "XYScycleCollectionView.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,XYScycleCollectionViewDelegate>
@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"secondPage" style:UIBarButtonItemStylePlain target:self action:@selector(secondPage)];
    self.navigationItem.rightBarButtonItem = item;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"thirdPage" style:UIBarButtonItemStylePlain target:self action:@selector(thirdPage)];
    self.navigationItem.leftBarButtonItem = leftItem;

    
    
    self.imageArray = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpg",@"8.jpg"];
    
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
    XYCollectionViewFlowLayout *flowLayout = [[XYCollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(300, 200);
    flowLayout.minimumInteritemSpacing = 0;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 300) collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:[XYCollectionViewCell class] forCellWithReuseIdentifier:@"XYCollectionViewCell"];
    [self.view addSubview:collectionView];
    
    XYScycleCollectionView *cycleView = [[XYScycleCollectionView alloc]initWithFrame:CGRectMake(0, 330, self.view.frame.size.width, 100)];
    cycleView.placeholderImage = [UIImage imageNamed:@"placeholder.jpg"];
    cycleView.currentImage = [UIImage imageNamed:@"detail_tupianlunbo_suiji"];
    cycleView.defaultImage = [UIImage imageNamed:@"detail_piclunbounselec_suiji"];
    cycleView.isCorner = YES;
    cycleView.isShadow = YES;
    cycleView.cornerRadius = 20;
    cycleView.imageWidth = 350.f;
    cycleView.lineSpace = 5;
    cycleView.delegate = self;
    cycleView.isSameTimerInterval = NO;
    cycleView.imageArr = imagesURLStrings;
    [self.view addSubview:cycleView];
}
    
- (void)secondPage{
    DeallocTestViewController *vc = [[DeallocTestViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
    
- (void)thirdPage{
    DeallocTestViewController *vc = [[DeallocTestViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XYCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"XYCollectionViewCell" forIndexPath:indexPath];
    cell.isCorner = YES;
    cell.cycleImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imageArray[indexPath.row]]];
    return cell;
}

    
#pragma mark - XYScycleCollectionViewDelegate
- (void)scycleCollectionView:(XYScycleCollectionView *)scycleCollectionView didScrollToIndex:(NSInteger)index{
    NSLog(@"viewController scroll = %ld",index);
    if (index == 1) {
        scycleCollectionView.timerInterval = 10;
    }else{
        scycleCollectionView.timerInterval = 2;
    }
}
    
- (void)scycleCollectionView:(XYScycleCollectionView *)scycleCollectionView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"select = %ld",index);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
