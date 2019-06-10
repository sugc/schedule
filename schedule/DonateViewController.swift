//
//  DonateViewController.swift
//  schedule
//
//  Created by sugc on 2019/6/9.
//  Copyright © 2019 魔方. All rights reserved.
//

import Foundation

class DonateViewController : SimpleBackViewController {
    
    //ali pay
    
    //看广告
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel.init(frame: CGRect.init(x: 20, y: navigateView.bottom + 30, width: ScreenWidth - 40, height: 30))
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.text = "打开支付宝首页搜“552315477”领红包, 感谢您的支持"
        label.sizeToFit()
        
        let copyBtn  = UIButton.init(frame: CGRect.init(x: 30, y: label.bottom + 20, width: ScreenWidth - 60, height: 40))
        copyBtn.layer.cornerRadius = 5
        copyBtn.clipsToBounds = true
        copyBtn.setTitle("点击复制红包码", for: UIControl.State.normal)
        copyBtn.layer.borderWidth = 1.0
        copyBtn.layer.borderColor = UIColor.lightGray.cgColor
        copyBtn.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
        copyBtn.addTarget(self, action: #selector(copyCode), for: UIControl.Event.touchUpInside)
        
        self.view.addSubview(label)
        self.view.addSubview(copyBtn)
        
        let adView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        adView.left = 0
        adView.bottom = ScreenHeight - iPhoneXSafeDistanceBottom
        adView.adUnitID = "ca-app-pub-9435427819697575/5296181912"
        adView.rootViewController = self
        self.view.addSubview(adView)
        adView.load(GADRequest())
        
    }
    
    
    @objc func copyCode() {
        UIPasteboard.general.string = "552315477"
        //复制成功
        
        //提示
        TipsView.showTipsOnView(view: self.view, title: "复制成功", message: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//            TipsView.hideTipsForView(view: self.view)
            self.goBack()
        }
    }
}
