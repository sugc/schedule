//
//  TopBarCell.swift
//  schedule
//
//  Created by sugc on 2019/1/29.
//  Copyright © 2019 魔方. All rights reserved.
//

import Foundation

class TopBarCell : UICollectionViewCell {
    
    private var titleLabel : UILabel! = UILabel()
    
    var title : String? {
        set(newValue) {
            titleLabel.text = newValue
            titleLabel.sizeToFit()
            titleLabel.center = CGPoint.init(x: self.width / 2.0, y: self.height / 2.0)
        }
        
        get {
            return titleLabel.text
        }
    }
    
    override var frame: CGRect {
            set(newValue) {
                super.frame = newValue
                titleLabel.frame = self.bounds
                titleLabel.textAlignment = NSTextAlignment.center
            }
        
            get {
                return super.frame
            }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(titleLabel)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
}
