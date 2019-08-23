//
//  ZFProxy.h
//  USDT
//
//  Created by fengz on 2019/5/7.
//  Copyright © 2019年 Fengz. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZFProxy : NSProxy
+ (instancetype)proxyWithTarget:(id)target;
@property (weak, nonatomic) id target;
@end


