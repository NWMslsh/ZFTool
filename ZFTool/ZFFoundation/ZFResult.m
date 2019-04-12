//
//  ZFResult.m
//  DSP
//
//  Created by hk on 2019/4/10.
//  Copyright © 2019年 hk. All rights reserved.
//

#import "ZFResult.h"

@implementation ZFResult
+ (ZFResult<id> * (^)(id value))OK{
    return ^(id value){
        ZFResult *result = [[ZFResult alloc]init];
        result.code = 0;
        result.value = value;
        return result;
    };
}
+ (ZFResult<id> * (^)(NSInteger code,NSString *errStr))Fail{
    return ^(NSInteger code,NSString *errStr){
        
        ZFResult *result = [[ZFResult alloc]init];
        result.code = code;
        result.value = [errStr copy];
        return result;
    };
}
@end
