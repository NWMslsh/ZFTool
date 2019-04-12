//
//  NSObject+ZFObject.h
//  DSP
//
//  Created by hk on 2019/4/8.
//  Copyright © 2019年 hk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ZFObject)

+ (instancetype(^)(void))zf_init;
@end

NS_ASSUME_NONNULL_END
