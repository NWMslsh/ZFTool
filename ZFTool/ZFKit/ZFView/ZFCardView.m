//  ZFCardView
//  UniPay
//
//  Created by fengz on 2018/4/25.
//  Copyright © 2018年 FengZ. All rights reserved.

#import "ZFCardView.h"
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface ZFCardView()

@end

@implementation ZFCardView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configureView];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self configureView];
    }
    return self;
}
- (instancetype)init{
    if (self = [super init]) {
        [self configureView];
    }
    return self;
}

- (void)configureView{
    
    self.shadowColor = [UIColor blackColor];
    self.cornerRadius = 0;
    self.shadowOffsetHeight = 1;
    self.shadowOffsetWidth = 1;
    self.shadowOpacity = 0.2f;
    [self SetupCar];
}

- (void)SetupCar
{
    CALayer *layer = self.layer;
    layer.masksToBounds = false;
    layer.shadowColor = self.shadowColor.CGColor;
    layer.shadowOffset = CGSizeMake(_shadowOffsetWidth, _shadowOffsetHeight);
    layer.shadowOpacity = self.shadowOpacity;
    layer.cornerRadius = _cornerRadius;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:_cornerRadius];
    layer.shadowPath = path.CGPath;
    

}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self SetupCar];
}
@end
