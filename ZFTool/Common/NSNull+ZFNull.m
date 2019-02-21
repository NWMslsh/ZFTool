//
//  NSNull+ZFNull.m
//  ZFTool
//
//  Created by fengz on 2018/7/25.
//  Copyright © 2018年 FengZ. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NSNullObjects @[@"",@0,@{},@[]] 
@implementation NSNull (ZFNull)

- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature* signature = [super methodSignatureForSelector:selector];
    if (!signature) {
        for (NSObject *object in NSNullObjects) {
            signature = [object methodSignatureForSelector:selector];
            if (signature) {
                break;
            }
        }
        
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL aSelector = [anInvocation selector];
    
    for (NSObject *object in NSNullObjects) {
        if ([object respondsToSelector:aSelector]) {
            [anInvocation invokeWithTarget:object];
            return;
        }
    }
    
    [self doesNotRecognizeSelector:aSelector];
}

@end
