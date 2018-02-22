//
//  CenterSpaceFlowLayout.h
//  CollectionView位置(左对齐、居中、右对齐)
//
//  Created by 楼某人 on 2018/2/12.
//  Copyright © 2018年 楼某人. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AligenType) {
    AligenLeft,
    AligenCenter,
    AligenRight
};

@interface CenterSpaceFlowLayout : UICollectionViewFlowLayout

// 两个cell之间的距离
@property (nonatomic, assign) CGFloat distanceBetweenCell;
// cell的排列方式
@property (nonatomic, assign) AligenType TypeOfCell;

- (instancetype)initWithType:(AligenType) typeOfCell;

- (instancetype)initWithType:(AligenType)typeOfCell distanceBetweenCell:(CGFloat)distanceBetweenCell;

@end
