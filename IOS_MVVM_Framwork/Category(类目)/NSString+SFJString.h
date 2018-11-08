//
//  NSString+SFJString.h
//  IOS_MVVM_Framwork
//
//  Created by Experimental Computer on 11/8/18.
//  Copyright © 2018 Luxondata. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (SFJString)

/**
 *  计算文字的Size
 *
 *  @param content  所需要计算的文字的内容
 *  @param size     文字的宽高尺寸
 *  @param fontSize 文字的size
 *
 *  @return 整个内容的size
 */
+ (CGSize)content:(NSString *)content boundingRectWithSize:(CGSize)size fontSize:(CGFloat)fontSize;

/** 十六进制转换为普通字符串*/
+ (NSString *)stringFromHexString:(NSString *)hexString;

/** 普通字符串转换为十六进制 */
+ (NSString *)hexStringFromString:(NSString *)string;

/** 将传入的NSData类型转换成NSString */
+ (NSString *)hexadecimalString:(NSData *)data;

/** 字典转JSON字符串*/
+ (NSString *)jsonStringFromDictionary:(NSDictionary *)dictionaty;

/** JSON字符串转i字典*/
+ (NSDictionary *)jsonDictFromJsonstring:(NSString *)jsonString;
@end

NS_ASSUME_NONNULL_END
