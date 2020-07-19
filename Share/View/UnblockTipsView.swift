//
//  UnblockTipsView.swift
//  schedule
//
//  Created by sugc on 2019/6/11.
//  Copyright © 2019 魔方. All rights reserved.
//

import Foundation
import UIKit

class UnblockTipsView : TipsView {
    
    static func showUnblockTipsOnView(view:UIView!, title:String?, message:String?){
        
        let tips = UnblockTipsView.init(frame: view.bounds)
        //        tips.titleLabel?.text = title
        //        tips.messageLabel?.text = message
        tips.configWith(title: title, message: message)
        view.addSubview(tips)
        tips.alpha = 0
        UIView.animate(withDuration: 0.5) {
            tips.alpha = 1.0
        }
    }
    
    static func hideUnblockTipsForView(view:UIView!){
        for subView in view.subviews {
            if subView.isKind(of: UnblockTipsView.classForCoder()) {
                UIView.animate(withDuration: 0.5, animations: {
                    subView.alpha = 0.0
                }) { (isComplete) in
                    subView.removeFromSuperview()
                }
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        titleLabel?.textColor = UIColor.white
        messageLabel?.textColor = UIColor.white
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        //
        for view in self.subviews {
            if view.frame.contains(point) {
                return view.hitTest(self.convert(point, to: view), with: event)
            }
        }
        return nil
    }
}
