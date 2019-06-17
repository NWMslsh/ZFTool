//
//  ZFKeyChain.h
//  MiPay
//
//  Created by fengz on 2018/3/29.
//  Copyright © 2018年 fengz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface ZFKeyChain : NSObject
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteKeyChain:(NSString *)serviece;
@end
