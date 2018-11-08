//
//  SFJRegularExpression.h
//  LXDCEP
//
//  Created by Experimental Computer on 2018/9/13.
//  Copyright © 2018年 luxondata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFJRegularExpression : NSObject
/**
 *  正则表达式验证Email
 */
+ (BOOL)checkEmail:(NSString *)email;
/**
 *  正则表达式验证TelephoneNumber
 */
+ (BOOL)checkTelephoneNumber:(NSString *)telephoneNumber;
@end
