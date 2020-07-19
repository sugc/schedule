//
//  MusicCollectionViewCell.swift
//  schedule
//
//  Created by sugc on 2019/2/14.
//  Copyright © 2019 魔方. All rights reserved.
//

import Foundation
import UIKit

class MusicCollectionViewCell : UICollectionViewCell {
    private var imageView : UIImageView!
    private var label : UILabel!
    private var maskImageView : UIImageView!
    
    
    var isShowMask : Bool! = false {
        didSet {
            maskImageView.isHidden = !isShowMask
            if isShowMask {
                //显示高亮图
                
                //文字颜色值
            } else {
                //非高亮图
            }
        }
    }
    
    var title : String? {
        set(newValue) {
            label.text = newValue
        }
        get {
            return label.text
        }
    }
    
    var image : UIImage? {
        set(newValue) {
            imageView.image = newValue
        }
        get {
            return imageView.image
        }
    }
    
//    override var frame: CGRect {
//        set(newValue) {
//           super.frame = newValue
//        }
//
//        get {
//            return super.frame
//        }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() -> Void {
        let size = self.width * 0.5
        let maskFrame = CGRect(x: (self.width - size) / 2.0,
                              y: 0, width: size,
                              height: size)
        
        maskImageView = UIImageView.init(frame: maskFrame)
        maskImageView.layer.cornerRadius = maskImageView.width / 2.0
        maskImageView.layer.masksToBounds = true
        maskImageView.alpha = 0.3
        maskImageView.isHidden = true
        maskImageView.backgroundColor = UIColor.init(red: 100 / 255.0, green: 254 / 255.0, blue: 253 / 255.0, alpha: 1)
        
        //计算
        let imgSize = size  / pow(2, 0.5)
        let imgFrame = CGRect(x: (self.width - imgSize) / 2.0,
                              y: self.maskImageView.top + (self.maskImageView.height - imgSize) / 2.0,
                              width: imgSize,
                              height: imgSize)
        imageView = UIImageView(frame: imgFrame)
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        var labelH = self.height - imageView.bottom
        if labelH > 15 {
            labelH = 15;
        }
        
    
        var labelY = imageView.bottom + 10
        if imageView.bottom + 10 + labelH > self.height {
            labelY = self.height - labelH
        }
        
        label = UILabel(frame: CGRect(x: 0,
                                      y: labelY,
                                      width: self.width,
                                      height: labelH))
        
        
        imageView.image = UIImage.init(named: "icon_light_selected")
        label.text = "sunshime"
        label.textColor = UIColor.lightGray
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 12)
        self.contentView.addSubview(maskImageView)
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(label)
    }
    
}
