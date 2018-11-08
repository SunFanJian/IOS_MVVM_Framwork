//
//  SFJSimpleTool.m
//  SimpleShoppingMall
//
//  Created by Experimental Computer on 2018/8/1.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJSimpleTool.h"

@implementation SFJSimpleTool

+(id)sfj_chageControlCircularWith:(id)anyControl AndSetCornerRadius:(NSInteger)radius SetBorderWidth:(NSInteger)width SetBorderColor:(UIColor *)borderColor canMasksToBounds:(BOOL)can
{
    CALayer *icon_layer=[anyControl layer];
    [icon_layer setCornerRadius:radius];
    [icon_layer setBorderWidth:width];
    [icon_layer setBorderColor:[borderColor CGColor]];
    [icon_layer setMasksToBounds:can];
    
    return anyControl;
}

+(id)sfj_setSomeOneChangeColor:(UILabel *)label SetSelectArray:(NSArray *)arrray SetChangeColor:(UIColor *)color
{
    if (label.text.length == 0) {
        return 0;
    }
    int i;
    NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:label.text];
    for (i = 0; i < label.text.length; i ++) {
        NSString *a = [label.text substringWithRange:NSMakeRange(i, 1)];
        NSArray *number = arrray;
        if ([number containsObject:a]) {
            [attributeString setAttributes:@{NSForegroundColorAttributeName:color} range:NSMakeRange(i, 1)];
        }
    }
    label.attributedText = attributeString;
    return label;
}

#pragma mark -  根据传入字体大小计算字体宽高
+(CGSize)sfj_calculateTextSizeWithText:(NSString *)text WithTextFont:(NSInteger)textFont WithMaxW:(CGFloat)maxW
{
    CGFloat textMaxW = maxW;
    CGSize textMaxSize = CGSizeMake(textMaxW, MAXFLOAT);
    
//    CGSize textSize = [text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:PFR size:textFont]} context:nil].size;
    CGSize textSize = [text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:textFont]} context:nil].size;
    
    return textSize;
}

#pragma mark - 触动
+ (void)sfj_callFeedback
{
    if (@available(iOS 10.0, *)) {
        UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle: UIImpactFeedbackStyleHeavy];
        [generator prepare];
        [generator impactOccurred];
    }    
}

#pragma mark - 首行缩进
+ (void)sfj_setUpLabel:(UILabel *)label Content:(NSString *)content IndentationFortheFirstLineWith:(CGFloat)emptylen
{
    NSMutableParagraphStyle *paraStyle01 = [[NSMutableParagraphStyle alloc] init];
    paraStyle01.firstLineHeadIndent = emptylen;//首行缩进
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:content attributes:@{NSParagraphStyleAttributeName:paraStyle01}];
    
    label.attributedText = attrText;
}

#pragma mark - 下划线
+ (void)sfj_setUpAcrossPartingLineWith:(UIView *)view WithColor:(UIColor *)color WithWidthRatio:(CGFloat)ratio
{
    if (ratio == 0) { // 默认1
        ratio = 1;
    }
    
    UIView *cellAcrossPartingLine = [[UIView alloc] init];
    cellAcrossPartingLine.backgroundColor = color;
    [view addSubview:cellAcrossPartingLine];
    
    [cellAcrossPartingLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
       // make.left.mas_equalTo(view);
        make.centerX.mas_equalTo(view);
        make.bottom.mas_equalTo(view);
        make.size.mas_equalTo(CGSizeMake(view.width * ratio, 1));
        
    }];
    
}
#pragma mark - 竖线
+ (void)sfj_setUpLongLineWith:(UIView *)view WithColor:(UIColor *)color WithHightRatio:(CGFloat)ratio;
{
    if (ratio == 0) { // 默认1
        ratio = 1;
    }
    UIView *cellLongLine = [[UIView alloc] init];
    cellLongLine.backgroundColor = color;
    [view addSubview:cellLongLine];
    
    [cellLongLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(view);
        make.centerY.mas_equalTo(view);
        make.size.mas_equalTo(CGSizeMake(1, view.height * ratio));
        
    }];
}

#pragma mark - 字符串加星处理
+ (NSString *)sfj_encryptionDisplayMessageWith:(NSString *)content WithFirstIndex:(NSInteger)findex
{
    if (findex <= 0) {
        findex = 2;
    }else if (findex + findex > content.length) {
        findex --;
    }
    return [NSString stringWithFormat:@"%@***%@",[content substringToIndex:findex],[content substringFromIndex:content.length - findex]];
}

@end
