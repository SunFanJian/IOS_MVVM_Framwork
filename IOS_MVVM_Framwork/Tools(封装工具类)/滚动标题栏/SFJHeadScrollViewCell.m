//
//  SFJHeadScrollViewCell.m
//  SimpleShoppingMall
//
//  Created by Experimental Computer on 2018/8/6.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJHeadScrollViewCell.h"

@interface SFJHeadScrollViewCell()

@end

@implementation SFJHeadScrollViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI
{
    _titleBtn = [[SFJSimpleButton alloc]init];
    [_titleBtn setTitle:_title forState:UIControlStateNormal];
    [_titleBtn setImage:[UIImage imageNamed:_titleImgName] forState:UIControlStateNormal];
    [_titleBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    _titleBtn.enabled = NO;
    
    _titleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleBtn.buttonStyle = imageRight;   //设置 自定义按钮布局样式
    [self addSubview:_titleBtn];

    _bottomLineView = [[UIView alloc]init];
    _bottomLineView.backgroundColor = [UIColor redColor];
    [self addSubview:_bottomLineView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self);
        make.height.mas_equalTo(self.height - 3);
       // make.bottom.equalTo(self).offset(-3);
        make.left.equalTo(self);
        make.top.equalTo(self);
    }];
    
    [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self);
        make.height.equalTo(@3);
        make.left.equalTo(self);
        make.bottom.equalTo(self);
    }];
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    [_titleBtn setTitle:title forState:UIControlStateNormal];
}

-(void)setTitleImgName:(NSString *)titleImgName
{
    _titleImgName = titleImgName;
     [_titleBtn setImage:[UIImage imageNamed:titleImgName] forState:UIControlStateNormal];
}
@end
