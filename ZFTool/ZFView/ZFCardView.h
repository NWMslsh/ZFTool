//
//  CardView.h
//  UniPay
//
//  Created by fengz on 2018/4/25.
//  Copyright © 2018年 FengZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFCardView : UIView

@property(nonatomic , assign) float cornerRadius;
@property(nonatomic , strong)UIColor *shadowColor;
@property(nonatomic , assign)float shadowOffsetHeight;
@property(nonatomic , assign)float shadowOffsetWidth;
@property(nonatomic , assign)float shadowOpacity;
@end
