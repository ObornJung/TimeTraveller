//
//  TTStyle.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/28/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import UIKit
import OBUIKit

// 字体颜色（深色）
let TT_BlackText_Color = UIColor.ob_colorWithRGB(0x222222);
// 字体颜色（浅色）
let TT_GrayText_Color  = UIColor.ob_colorWithRGB(0x7E7E7E);
// 模块间 0.5dp 分割线
let TT_Separator_Color = UIColor.ob_colorWithRGB(0xAFABA2);
// 背景底色
let TT_GrayBg_Color    = UIColor.ob_colorWithRGB(0xEEEEEE);

class TTStyle: NSObject {
    
    class func font(fontSize: CGFloat, weight: CGFloat = UIFontWeightRegular) -> UIFont {
        return UIFont.systemFontOfSize(fontSize, weight: weight);
    }
    
    class func boldFontOfSize(fontSize: CGFloat) -> UIFont {
        return UIFont.boldSystemFontOfSize(fontSize);
    }

}
