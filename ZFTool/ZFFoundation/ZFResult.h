//
//  ZFResult.h
//  DSP
//
//  Created by hk on 2019/4/10.
//  Copyright © 2019年 hk. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZFResult<ObjectType> : NSObject

@property(nonatomic,assign)NSInteger code;
@property(nonatomic,strong)ObjectType value;

+ (ZFResult<ObjectType> * (^)(ObjectType value))OK;
+ (ZFResult<ObjectType> * (^)(NSInteger code,NSString *errStr))Fail;
@end


