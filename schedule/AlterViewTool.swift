//
//  AlterViewTool.swift
//  schedule
//
//  Created by sugc on 2018/5/27.
//  Copyright © 2018年 魔方. All rights reserved.
//

import Foundation
import UIKit

func simpleCancelAler(title:String?, message:String?) ->UIAlertController!{
    let alterView = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    let action = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.cancel) { (action) in
        
    }
    alterView.addAction(action)
    return alterView
}
