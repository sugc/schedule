//
//  DetailFuncTableViewCell.swift
//  schedule
//
//  Created by sugc on 2019/1/27.
//  Copyright © 2019 魔方. All rights reserved.
//

import Foundation

class DetailFuncTableViewCell : UITableViewCell {
    
    private var leftIconView : UIImageView?
    private var rightIconView : UIImageView?
    private var leftLabel : UILabel?
    
   override var frame : CGRect {
        set {
            super.frame = newValue
            self.leftIconView?.centerY = self.height / 2.0
            self.rightIconView?.centerY = self.height / 2.0
            self.leftLabel?.centerY = self.height / 2.0
        }
        get {
            return super.frame
        }
    }
    
    //private var rightLabel : UILabel!

    var leftIconImage : UIImage? {
        set {
            leftIconView?.image = newValue
        }
        
        get {
            return leftIconView?.image
        }
    }
    
    var rightIconImage : UIImage? {
        set {
            rightIconView?.image = newValue
        }
        
        get {
            return rightIconView?.image
        }
    }
    
    var leftTitle : String? {
        set {
            leftLabel?.text = newValue
        }
        get {
            return leftLabel?.text
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layout()
    }
    
    func layout() {
        //
        let iconW : CGFloat = 30
        let leftIconFrame = CGRect.init(x: 20,
                                        y: 10,
                                        width: iconW,
                                        height: iconW)
        let rightIconFrame = CGRect.init(x: ScreenWidth - iconW - 10,
                                        y: 10,
                                        width: 15,
                                        height: 15)
        leftIconView = UIImageView(frame: leftIconFrame)
        rightIconView = UIImageView(frame: rightIconFrame)
        
        let leftLabelFrame = CGRect.init(x: leftIconView!.right + 10,
                                        y: 10,
                                        width: rightIconView!.left - leftIconView!.right - 20,
                                        height: iconW)
//        let rightLabelFrame = CGRect.init(x: 20,
//                                          y: 10,
//                                        width: iconW,
//                                        height: iconW)
        leftLabel = UILabel.init(frame: leftLabelFrame)
        leftLabel!.font = UIFont.systemFont(ofSize: 16)
        
        self.contentView.addSubview(leftIconView!)
        self.contentView.addSubview(rightIconView!)
        self.contentView.addSubview(leftLabel!)
//        self.contentView.addSubview(rightLabel)
    }
    
}
