//
//  ZFTool.h
//  ZFTool
//
//  Created by fengz on 2019/1/9.
//  Copyright © 2019年 fengz. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for ZFTool.
FOUNDATION_EXPORT double ZFToolVersionNumber;

//! Project version string for ZFTool.
FOUNDATION_EXPORT const unsigned char ZFToolVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <ZFTool/PublicHeader.h>

#import "Define-header.h"

// ZFView
#import "UIView+ZFView.h"
#import "ZFCardView.h"
#import "UIView+Point.h"
// ZFKit
#import "UIColor+ZFColor.h"
#import "UIFont+ZFFont.h"
#import "UIImage+ZFImage.h"

// ZFFoundation
#import "NSString+ZFString.h"
#import "NSDate+ZFDate.h"
#import "NSObject+ZFObject.h"
#import "ZFResult.h"
// Common
#import "ZFCommon.h"
#import "ZFToast.h"
#import "ZFAppLanguage.h"

/**
<u>RGB 转换成 YUV</u>
Y = (0.257 * R) + (0.504 * G) + (0.098 * B) + 16
Cr = V = (0.439 * R) - (0.368 * G) - (0.071 * B) + 128
Cb = U = -( 0.148 * R) - (0.291 * G) + (0.439 * B) + 128
 
<u>YUV 转换成 RGB</u>
 B = 1.164(Y - 16) + 2.018(U - 128)
 G = 1.164(Y - 16) - 0.813(V - 128) - 0.391(U - 128)
 R = 1.164(Y - 16) + 1.596(V - 128)
 */
