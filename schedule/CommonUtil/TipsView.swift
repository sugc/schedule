//
//  TipsView.swift
//  schedule
//
//  Created by sugc on 2019/6/9.
//  Copyright © 2019 魔方. All rights reserved.
//

import Foundation

class TipsView : UIView {
    
    private var titleLabel : UILabel?
    private var messageLabel : UILabel?
    private var contentView : UIView!
    
    var contentWidth : CGFloat = 120
    var leftSpace : CGFloat = 5
    
    static func showTipsOnView(view:UIView!, title:String?, message:String?){
        
        let tips = TipsView.init(frame: view.bounds)
//        tips.titleLabel?.text = title
//        tips.messageLabel?.text = message
        tips.configWith(title: title, message: message)
        view.addSubview(tips)
        tips.alpha = 0
        UIView.animate(withDuration: 0.5) {
            tips.alpha = 1.0
        }
    }
    
    static func hideTipsForView(view:UIView!){
        for subView in view.subviews {
            if subView.isKind(of: TipsView.classForCoder()) {
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
        if contentWidth > (frame.size.width - 20) {
            contentWidth = frame.size.width - 20
        }
        
        if contentWidth < frame.size.width / 3.0 {
            contentWidth = frame.size.width / 3.0
        }
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.15)
        contentView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: contentWidth, height: 0))
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        titleLabel = UILabel.init(frame: CGRect.init(x: leftSpace, y: 0, width: contentWidth - leftSpace * 2, height: 0))
        messageLabel = UILabel.init(frame: CGRect.init(x: leftSpace, y: 0, width: contentWidth - leftSpace * 2, height: 0))
        titleLabel?.textAlignment = NSTextAlignment.center
        messageLabel?.textAlignment = NSTextAlignment.center
        messageLabel?.textColor = UIColor.lightGray
        titleLabel?.font = UIFont.systemFont(ofSize: 18)
        messageLabel?.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(titleLabel!)
        contentView.addSubview(messageLabel!)
        self.addSubview(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    func configWith(title:String?, message:String?) {
        titleLabel?.text = title
        messageLabel?.text = message
        titleLabel?.sizeToFit()
        messageLabel?.sizeToFit()
        titleLabel?.centerX = contentView.width / 2.0
        messageLabel?.centerX = contentView.width / 2.0
        
        let space : CGFloat = 10
        
        titleLabel?.top = space
        messageLabel?.top = space
        contentView.height = titleLabel!.bottom + space
        if titleLabel!.height > 0 {
            messageLabel?.top = titleLabel!.bottom + space
        }
        
        if messageLabel!.height > 0 {
            contentView.height = messageLabel!.bottom + space
        }
        
        contentView.center = CGPoint.init(x: self.width / 2.0, y: self.height / 2.0)
    }
}
