//
//  NSObject+ZFObject.m
//  DSP
//
//  Created by hk on 2019/4/8.
//  Copyright © 2019年 hk. All rights reserved.
//

#import "NSObject+ZFObject.h"

@implementation NSObject (ZFObject)

+ (instancetype(^)(void))zf_init{
    return ^(){
        id obj = [[self alloc]init];
        return obj;
    };
}
@end
