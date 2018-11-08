//
//  UIImage+ExtensionUIImage.m
//  LDWeiBo01
//
//  Created by Experimental Computer on 2017/9/21.
//  Copyright © 2017年 Luxondata. All rights reserved.
//

#import "UIImage+ExtensionUIImage.h"

@implementation UIImage (ExtensionUIImage)

+(UIImage *)imageWithName:(NSString *)name
{
    UIImage *image=nil;
    if(IOS7)
    {
        NSString *newImage=[name stringByAppendingString:@"_os7"];
        image=[UIImage imageNamed:newImage];
    }
    if(image==nil)
        image=[UIImage imageNamed:name];
    
    return image;
}

+(UIImage *)resizeImageWithName:(NSString *)name
{
    UIImage *image=[UIImage imageWithName:name];
    //创建一个内容可拉伸，而边角不拉伸的图片 需要两个参数，第一个是左边不拉伸区域的宽度，第二个参数是上面不拉伸的高度
    return [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];  //左边和顶部一般收到保护
    
}

+(UIImage *)imageWithColor:(UIColor *)aColor
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [aColor CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

// 生成圆形图片
- (instancetype)sfj_circleImage{
    
    // 开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    // 上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪
    CGContextClip(ctx);
    // 绘制图片
    [self drawInRect:rect];
    // 获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)sfj_circleImage:(NSString *)name{
    
    return [[self imageNamed:name] sfj_circleImage];
}
@end
