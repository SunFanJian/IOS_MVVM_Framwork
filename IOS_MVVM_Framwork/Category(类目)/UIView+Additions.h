//
//  UIView+Additions.h
//  QMQZ_Rebuild
//
//  Created by chengdengjian on 15/8/20.
//  Copyright (c) 2015年 CL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Additions)
//x坐标属性
@property (nonatomic,assign)CGFloat x;
//y坐标
@property (nonatomic,assign)CGFloat y;
//宽度
@property (nonatomic,assign)CGFloat width;
//高度
@property (nonatomic,assign)CGFloat height;
//大小
@property (nonatomic,assign)CGSize size;
//位置
@property (nonatomic,assign)CGPoint origin;
//中心点x
@property (nonatomic,assign)CGFloat centerX;
//中心点y
@property (nonatomic,assign)CGFloat centerY;
//右侧 X
@property (nonatomic,assign)CGFloat rightX;
//底部 Y
@property (nonatomic,assign,readonly)CGFloat bottomY;
/**
 获取Y的最大值
 */
- (CGFloat)maxY;

/**
 设置layer的边框样式
 */
- (void)layerBordeColor:(UIColor *)color borderWidth:(CGFloat)borderWidth roundedCornerWith:(CGFloat)cornerRadius;

/**
 获取子视图
 */
- (UIView *)subViewOfClassName:(NSString *)className;

/**
 *  查找视图的父单元格
 *
 *  @return 父单元格
 */
- (UITableViewCell *)findSupercell;

/** 从XIB创建view*/
+(instancetype)viewFromXib;
@end
