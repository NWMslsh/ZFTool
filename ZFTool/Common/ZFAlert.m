//
//  ZFAlert.m
//  ZFTool
//
//  Created by fengz on 2018/7/27.
//  Copyright © 2018年 FengZ. All rights reserved.
//

#import "ZFAlert.h"
#import "Define-header.h"
@interface ZFAlert()


@end
@implementation ZFAlert

+ (UIAlertController *)alertWihtTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel otherTitle:(NSArray *)titles preferredStyle:(UIAlertControllerStyle)preferredStyle otherAction:(AlertOtherAction)otherAction cancelAction:(AlertCancelAction)cancelAction{
    
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    
    for (int i = 0; i < titles.count; i ++) {
        NSString *otherTitle = titles[i];
        
        UIAlertAction *otherA = [UIAlertAction actionWithTitle:otherTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
             BLOCK_EXEC(otherAction,i);
            
        }];
        [vc addAction:otherA];
    }
    
    UIAlertAction *cancelA = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        BLOCK_EXEC(cancelAction);
        
    }];
    [vc addAction:cancelA];
    return vc;
    
}
@end
