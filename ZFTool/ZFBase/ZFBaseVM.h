//
//  ZFBaseVM.h
//  ZFTool
//
//  Created by fengz on 2019/9/23.
//  Copyright © 2019 fengz. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZFBaseVM : NSObject
+ (instancetype (^)(id param))buildByParam;
+ (instancetype (^)(void))build;
@end


@class ZFResult;
typedef void (^ZFResultBlock)(ZFResult *result);

@interface ZFResult<ObjectType> : NSObject
@property(nonatomic,assign)BOOL isSuccess;
@property(nonatomic,assign)NSInteger code;
@property(nonatomic,strong)ObjectType value;

+ (ZFResult<ObjectType> * (^)(ObjectType value))success;
+ (ZFResult<ObjectType> * (^)(NSInteger code,NSString *errStr))fail;
@end
