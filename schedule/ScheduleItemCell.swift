//
//  ScheduleItemCell.swift
//  schedule
//
//  Created by sugc on 2019/6/29.
//  Copyright © 2019 魔方. All rights reserved.
//

import Foundation

class ScheduleItemCell : UICollectionViewCell {
    
    var collectionView : UICollectionView!
    var lineView : UIView?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        collectionView = UICollectionView.init(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        self.contentView.addSubview(collectionView)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = self.bounds
    }
    
    
}

