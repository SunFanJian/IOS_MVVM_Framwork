//
//  NSString+SFJString.m
//  IOS_MVVM_Framwork
//
//  Created by Experimental Computer on 11/8/18.
//  Copyright © 2018 Luxondata. All rights reserved.
//

#import "NSString+SFJString.h"

@implementation NSString (SFJString)

/**
 *  计算文字的高度
 */
+ (CGSize)content:(NSString *)content boundingRectWithSize:(CGSize)size fontSize:(CGFloat)fontSize
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    
    CGSize retSize = [content boundingRectWithSize:size
                                           options:
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                        attributes:attribute
                                           context:nil].size;
    
    return retSize;
}

/**
 * 十六进制转换为普通字符串的。
 */
+ (NSString *)stringFromHexString:(NSString *)hexString {
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    
    return unicodeString;
}

/**
 *普通字符串转换为十六进制的。
 */
+ (NSString *)hexStringFromString:(NSString *)string{
    
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}

/**
 * 将传入的NSData类型转换成NSString并返回
 */
+ (NSString *)hexadecimalString:(NSData *)data{
    NSString *result;
    const unsigned char *dataBuffer = (const unsigned char *)[data bytes];
    if (!dataBuffer) {
        return nil;
    }
    NSUInteger dataLength = [data length];
    NSMutableString *hexString = [NSMutableString stringWithCapacity:(dataLength * 2)];
    for (int i = 0; i<dataLength; i++) {
        //02x 表示两个位置 显示的16进制
        [hexString appendString:[NSString stringWithFormat:@"%02lx",(unsigned long)dataBuffer[i]]];
    }
    result = [NSString stringWithString:hexString];
    
    return result;
    
}

+ (NSString *)jsonStringFromDictionary:(NSDictionary *)dictionaty
{
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionaty options:0 error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
}

+ (NSDictionary *)jsonDictFromJsonstring:(NSString *)jsonString
{
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    return dic;
}
@end
