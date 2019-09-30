//
//  ZFBaseVM.m
//  ZFTool
//
//  Created by fengz on 2019/9/23.
//  Copyright © 2019 fengz. All rights reserved.
//

#import "ZFBaseVM.h"

@implementation ZFBaseVM
- (instancetype)initWithValue:(id)value {
    if (self = [super init]) {
        [self configureParam:value];
    }
    return self;
}
- (void)configureParam:(id)param {
}
+ (instancetype (^)(id param))buildByParam{
    return ^(id param) {
        return [[self alloc]initWithValue:param];
    };
}
+ (instancetype (^)(void))build {
    return ^(void){
        return [[self alloc]initWithValue:nil];
    };
}
@end

@implementation ZFResult
+ (ZFResult<id> * (^)(id value))success{
    return ^(id value){
        ZFResult *result = [[ZFResult alloc]init];
        result.code = 0;
        result.value = value;
        result.isSuccess = true;
        return result;
    };
}
+ (ZFResult<id> * (^)(NSInteger code,NSString *errStr))fail{
    return ^(NSInteger code,NSString *errStr){
        
        ZFResult *result = [[ZFResult alloc]init];
        result.code = code;
        result.isSuccess = !(code == -404);
        result.value = [errStr copy];
        return result;
    };
}
@end
