//
//  AboutViewController.swift
//  schedule
//
//  Created by sugc on 2019/5/26.
//  Copyright © 2019 魔方. All rights reserved.
//

import Foundation

class AboutViewController : UIViewController {
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        let leftButton = UIButton(frame: CGRect(x: 15,
                                                y: iPhoneXSafeDistanceTop,
                                                width: 40,
                                                height: 40 ))
        leftButton.setTitle("返回", for: UIControlState.normal)
        leftButton.addTarget(self,
                             action: #selector(goBack) ,
                             for: UIControlEvents.touchUpInside)
        leftButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        self.view.addSubview(leftButton)
        
        
        let imgW : CGFloat = 40
        let imgFrame = CGRect.init(x: (ScreenWidth - imgW) / 2.0,
                                   y: (ScreenHeight - imgW) / 2.0, width: imgW,
                                   height: imgW)
        let imageView = UIImageView.init(frame: imgFrame)
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        self.view.addSubview(imageView)
        
        let labelFrame = CGRect.init(x: 0, y: imageView.bottom + 10, width: ScreenWidth, height: 20)
        let label = UILabel.init(frame: labelFrame)
        label.textAlignment = NSTextAlignment.center
        
        guard let versionCode = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return
        }
        
        label.text = "Schedule v" + versionCode
        label.textColor = UIColor.lightGray
        self.view.addSubview(label)
        
    }
    
    func goBack() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}
