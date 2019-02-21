//
//  ZFAlert.h
//  ZFTool
//
//  Created by fengz on 2018/7/27.
//  Copyright © 2018年 FengZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^AlertOtherAction)(NSInteger index);
typedef void (^AlertCancelAction)(void);
@interface ZFAlert : NSObject

+ (UIAlertController *)alertWihtTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel otherTitle:(NSArray *)titles preferredStyle:(UIAlertControllerStyle)preferredStyle otherAction:(AlertOtherAction)otherAction cancelAction:(AlertCancelAction)cancelAction;
@end
