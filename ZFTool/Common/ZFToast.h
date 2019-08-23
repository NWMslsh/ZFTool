//
//  ZFToast.h
//  ZFTool
//
//  Created by fengz on 2018/7/27.
//  Copyright © 2018年 FengZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFToast : UIView
//出现
+ (void)showStatus:(NSString *)status;

/**
 错误提示
 */
+ (void)showCode:(NSInteger)code;
@end
