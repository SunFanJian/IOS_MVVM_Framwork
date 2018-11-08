//
//  SFJRegularExpression.m
//  LXDCEP
//
//  Created by Experimental Computer on 2018/9/13.
//  Copyright © 2018年 luxondata. All rights reserved.
//

#import "SFJRegularExpression.h"

@implementation SFJRegularExpression

+ (BOOL)checkEmail:(NSString *)email {
    NSString *regex   = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:email];
}

+ (BOOL)checkTelephoneNumber:(NSString *)telephoneNumber {
    NSString *MOBILE             = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString *CM                 = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString *CU                 = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString *CT                 = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSString *PHS                = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm     = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu     = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct     = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs    = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    return [regextestmobile evaluateWithObject:telephoneNumber] || [regextestphs evaluateWithObject:telephoneNumber] || [regextestct evaluateWithObject:telephoneNumber] || [regextestcu evaluateWithObject:telephoneNumber] || [regextestcm evaluateWithObject:telephoneNumber];
}

@end
