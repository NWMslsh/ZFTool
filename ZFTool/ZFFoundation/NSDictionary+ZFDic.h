//
//  NSDictionary+ZFDic.h
//  ZFTool
//
//  Created by hk on 2019/3/16.
//  Copyright © 2019年 fengz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (ZFDic)
+ (NSString *)getJsonStr:(NSDictionary *)dic;
+ (NSDictionary *)getJsonDic:(NSString *)jsonStr;


@end

NS_ASSUME_NONNULL_END
