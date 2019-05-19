//
//  DesignedUtils.swift
//  MagicCamera
//
//  Created by sugc on 2017/11/26.
//  Copyright © 2017年 sugc. All rights reserved.
//

import Foundation
import UIKit

let ScreenSize = UIScreen.main.bounds.size
let ScreenWidth : CGFloat = UIScreen.main.bounds.size.width
let ScreenHeight : CGFloat = UIScreen.main.bounds.size.height

//var iPhoneXSafeDistanceTop = 0
//var iPhoneXSafeDistanceBottom = 0

var iPhoneXSafeDistanceTop : CGFloat {
    get {
        if #available(iOS 11.0, *) {
            return (UIApplication.shared.delegate as! AppDelegate).window!.safeAreaInsets.top
        }
        return 0
    }
}

var iPhoneXSafeDistanceBottom : CGFloat {
    get {
        if #available(iOS 11.0, *) {
            return (UIApplication.shared.delegate as! AppDelegate).window!.safeAreaInsets.bottom
        }
        return 0
    }
}

let iPhoneXSafeDistance : CGFloat = (Double)(UIDevice.current.systemVersion)!  >= 11.0 ? iPhoneXSafeDistanceTop + iPhoneXSafeDistanceBottom : 0

