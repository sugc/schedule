//
//  TopBarManager.swift
//  schedule
//
//  Created by sugc on 2019/1/29.
//  Copyright © 2019 魔方. All rights reserved.
//

import Foundation
import UIKit

@objc protocol TopBarManagerDelegate : NSObjectProtocol {
    @objc func didSelectAtIndex(index : NSInteger)->Void
}

class TopBarManager : NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    weak var tbBelegate : TopBarManagerDelegate?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MusicMaterialManager.getMaterailTypes().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topBarCell", for: indexPath) as! TopBarCell
        if indexPath.row < MusicMaterialManager.getMaterailTypes().count {
            cell.title = MusicMaterialManager.getMaterailTypes()[indexPath.row]
        }else {
            cell.title = ""
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if  delegate!.responds(to: #selector(didSelectAtIndex(index:))) {
//
//        }
        tbBelegate?.responds(to: #selector(TopBarManagerDelegate.didSelectAtIndex(index:)))
        tbBelegate?.didSelectAtIndex(index: indexPath.row)
    }
    
    
    func hahaha() {
        
    }
    
    //
}
