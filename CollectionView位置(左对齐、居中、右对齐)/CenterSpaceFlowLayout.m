//
//  CenterSpaceFlowLayout.m
//  CollectionView位置(左对齐、居中、右对齐)
//
//  Created by 楼某人 on 2018/2/12.
//  Copyright © 2018年 楼某人. All rights reserved.
//

#import "CenterSpaceFlowLayout.h"

@interface CenterSpaceFlowLayout()
{
    //此行所有cell的宽度总和
    CGFloat _sumCellWidth;
}

@end

@implementation CenterSpaceFlowLayout

- (void)setDistanceBetweenCell:(CGFloat)distanceBetweenCell
{
    _distanceBetweenCell = distanceBetweenCell;
    self.minimumInteritemSpacing = distanceBetweenCell;
}

- (instancetype)init
{
    return [self initWithType:AligenCenter distanceBetweenCell:5.0];
}

- (instancetype)initWithType:(AligenType)typeOfCell
{
    return [self initWithType:typeOfCell distanceBetweenCell:5.0];
}

- (instancetype)initWithType:(AligenType)typeOfCell distanceBetweenCell:(CGFloat)distanceBetweenCell
{
    if (self = [super init])
    {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.minimumLineSpacing = 5;
        self.minimumInteritemSpacing = distanceBetweenCell;
        self.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        _distanceBetweenCell = distanceBetweenCell;
        _TypeOfCell = typeOfCell;
    }
    return self;
}

// 此处进行cell排序：是居左、居中还是居右
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *layoutAttributes_t = [super layoutAttributesForElementsInRect:rect];
    NSArray *layoutAttributes = [[NSArray alloc] initWithArray:layoutAttributes_t copyItems:YES];
    //用于临时存放一行的cell数组
    NSMutableArray *layoutAttributesTemp = [[NSMutableArray alloc] init];
    
    for (NSUInteger index = 0; index < layoutAttributes.count; index++)
    {
        UICollectionViewLayoutAttributes *currentAttr = layoutAttributes[index]; //当前cell的位置信息
        UICollectionViewLayoutAttributes *previousAttr = index == 0 ? nil : layoutAttributes[index - 1]; //上一个cell的位置信息
        UICollectionViewLayoutAttributes *nextAttr = index + 1 == layoutAttributes.count ? nil : layoutAttributes[index + 1]; //下一个cell的位置信息
        
        //加入临时数组
        [layoutAttributesTemp addObject:currentAttr];
        _sumCellWidth += currentAttr.frame.size.width;
        
        CGFloat previousY = previousAttr == nil ? 0 : CGRectGetMaxY(previousAttr.frame); //上一个cell的最大Y值
        CGFloat currentY = CGRectGetMaxY(currentAttr.frame); //当前cell的最大Y值
        CGFloat nextY = nextAttr == nil ? 0 : CGRectGetMaxY(nextAttr.frame); //下一个cell的最大Y值
        
        if (currentY != previousY && currentY != nextY) //当前cell直接占据一行
        {
            if ([currentAttr.representedElementKind isEqualToString:UICollectionElementKindSectionHeader])
            {
                [layoutAttributesTemp removeAllObjects];
                _sumCellWidth = 0.0;
            }
            else if ([currentAttr.representedElementKind isEqualToString:UICollectionElementKindSectionFooter])
            {
                [layoutAttributesTemp removeAllObjects];
                _sumCellWidth = 0.0;
            }
            else
            {
                [self setCellFrameWith:layoutAttributesTemp];
            }
        }
        else if (currentY != nextY) //如果下一个cell不在本行，开始调整frame位置
        {
            [self setCellFrameWith:layoutAttributesTemp];
        }
        
    }
    return layoutAttributes;
}

// 调整属于同一行的cell的位置frame
- (void)setCellFrameWith:(NSMutableArray *)layoutAttributes
{
    CGFloat nowWidth = 0.0;
    switch (_TypeOfCell)
    {
        case AligenLeft: //左对齐
            
            nowWidth = self.sectionInset.left;
            for (UICollectionViewLayoutAttributes *attributes in layoutAttributes)
            {
                CGRect nowFrame = attributes.frame;
                nowFrame.origin.x = nowWidth;
                attributes.frame = nowFrame;
                nowWidth += nowFrame.size.width + self.distanceBetweenCell;
            }
            _sumCellWidth = 0.0;
            [layoutAttributes removeAllObjects];
            
            break;
            
        case AligenCenter: //居中对齐
            
            nowWidth = (self.collectionView.frame.size.width - _sumCellWidth - ((layoutAttributes.count - 1) * _distanceBetweenCell)) / 2;
            for (UICollectionViewLayoutAttributes *attribute in layoutAttributes)
            {
                CGRect nowFrame = attribute.frame;
                nowFrame.origin.x = nowWidth;
                attribute.frame = nowFrame;
                nowWidth += nowFrame.size.width + self.distanceBetweenCell;
            }
            _sumCellWidth = 0.0;
            [layoutAttributes removeAllObjects];
            
            break;
        case AligenRight: //右对齐
            
            nowWidth = self.collectionView.frame.size.width - self.sectionInset.right;
            for (NSInteger index = layoutAttributes.count - 1 ; index >= 0 ; index-- ) {
                UICollectionViewLayoutAttributes * attributes = layoutAttributes[index];
                CGRect nowFrame = attributes.frame;
                nowFrame.origin.x = nowWidth - nowFrame.size.width;
                attributes.frame = nowFrame;
                nowWidth = nowWidth - nowFrame.size.width - _distanceBetweenCell;
            }
            _sumCellWidth = 0.0;
            [layoutAttributes removeAllObjects];
            
            break;
            
        default:
            break;
    }
}

















@end
