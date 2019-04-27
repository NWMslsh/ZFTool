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

// save username and password to keychain
+ (void)save:(NSString *)service data:(id)data;

// load username and password from keychain
+ (id)load:(NSString *)service;

// delete username and password from keychain
+ (void)delete:(NSString *)serviece;
@end
