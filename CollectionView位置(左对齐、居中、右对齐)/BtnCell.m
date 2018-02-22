//
//  BtnCell.m
//  CollectionView位置(左对齐、居中、右对齐)
//
//  Created by 楼某人 on 2018/2/12.
//  Copyright © 2018年 楼某人. All rights reserved.
//

#import "BtnCell.h"

#import <Masonry.h>

@interface BtnCell()

@end

@implementation BtnCell

- (UIButton *)btnOptions
{
    if (!_btnOptions)
    {
        _btnOptions = [UIButton new];
        [_btnOptions setBackgroundColor:[UIColor whiteColor]];
        _btnOptions.titleLabel.font = [UIFont systemFontOfSize:16];
        [_btnOptions setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _btnOptions.layer.cornerRadius = 15;
        _btnOptions.layer.masksToBounds = YES;
        _btnOptions.layer.borderColor = [UIColor grayColor].CGColor;
        _btnOptions.layer.borderWidth = 1;
        
        [self addSubview:_btnOptions];
        [_btnOptions mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
    }
    return _btnOptions;
}

@end
