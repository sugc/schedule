//
//  SimpleBackViewController.swift
//  schedule
//
//  Created by sugc on 2019/6/9.
//  Copyright © 2019 魔方. All rights reserved.
//

import Foundation
import UIKit

class SimpleBackViewController : UIViewController {
    
    var navigateView : UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        navigateView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 44 + iPhoneXSafeDistanceTop))
        navigateView.backgroundColor = UIColor.white
        let backBtn = UIButton.init(frame: CGRect.init(x: 15, y: iPhoneXSafeDistanceTop + 10, width: 24, height: 24 ))
        backBtn.setImage(UIImage.init(named: "icon_back"), for: UIControl.State.normal)
        backBtn.addTarget(self, action: #selector(goBack), for: UIControl.Event.touchUpInside)
        navigateView.addSubview(backBtn)
        self.view.addSubview(navigateView)
        let lineView = UIView.init(frame: CGRect.init(x: 0, y: navigateView.bottom, width: navigateView.width, height: 1))
        lineView.backgroundColor = UIColor.lightGray
        navigateView.addSubview(lineView)
    }
    
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
        
    }
}
