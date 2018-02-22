//
//  ViewController.m
//  CollectionView位置(左对齐、居中、右对齐)
//
//  Created by 楼某人 on 2018/2/12.
//  Copyright © 2018年 楼某人. All rights reserved.
//

#import "ViewController.h"

#import "BtnCell.h"
#import "CenterSpaceFlowLayout.h"

#import <Masonry.h>

#define G_SCREEN_WIDTH              [UIScreen mainScreen].bounds.size.width
#define G_SCREEN_HEIGHT             [UIScreen mainScreen].bounds.size.height
#define G_SCREEN_WIDTHSCALE         G_SCREEN_WIDTH / 750

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

{
    NSArray *arrOptions;
}

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initView];
}

- (void)initView
{
    
    arrOptions = @[@"养生",@"身体健康",@"健身",@"交朋友",@"事业",@"理财",@"生活",@"学习",@"艺术",@"食疗",@"自然堂",@"建筑",@"养生学习",@"谈健康",@"科学",@"管理",@"理疗"];
    
    CenterSpaceFlowLayout *layout = [[CenterSpaceFlowLayout alloc] initWithType:AligenCenter distanceBetweenCell:10.0];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, G_SCREEN_WIDTH, G_SCREEN_HEIGHT) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[BtnCell class] forCellWithReuseIdentifier:@"btnCell"];
    
}

#pragma mark - UICollectionViewDataSource ----------------------

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrOptions.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BtnCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"btnCell" forIndexPath:indexPath];
    
    [cell.btnOptions setTitle:arrOptions[indexPath.row] forState:UIControlStateNormal];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = [self widthForString:arrOptions[indexPath.row] fontSize:15 andMaxWidth:650 * G_SCREEN_WIDTHSCALE];
    
    return CGSizeMake(width + 90 * G_SCREEN_WIDTHSCALE, 70 * G_SCREEN_WIDTHSCALE);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //放置cell的contentview到边界的距离
    return UIEdgeInsetsMake(20 * G_SCREEN_WIDTHSCALE, 50 * G_SCREEN_WIDTHSCALE, 20 * G_SCREEN_WIDTHSCALE, 50 * G_SCREEN_WIDTHSCALE);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20 * G_SCREEN_WIDTHSCALE;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10 * G_SCREEN_WIDTHSCALE;
}


// 获取文本长度
- (float)widthForString:(NSString *)value fontSize:(float)fontSize andMaxWidth:(float)Maxwidth
{
    UITextView *detailTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, Maxwidth, 0)];
    detailTextView.font = [UIFont systemFontOfSize:fontSize];
    detailTextView.text = value;
    CGSize deSize = [detailTextView sizeThatFits:CGSizeMake(Maxwidth,CGFLOAT_MAX)];
    return deSize.width;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
