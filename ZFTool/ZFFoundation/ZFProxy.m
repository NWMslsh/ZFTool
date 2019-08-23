//
//  ZFProxy.m
//  USDT
//
//  Created by fengz on 2019/5/7.
//  Copyright © 2019年 Fengz. All rights reserved.
//

#import "ZFProxy.h"


@implementation ZFProxy
+ (instancetype)proxyWithTarget:(id)target {
    ZFProxy *proxy = [ZFProxy alloc];
    proxy.target = target;
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}
@end
