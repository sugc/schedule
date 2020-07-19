//
//  MusicCollectionViewManager.swift
//  schedule
//
//  Created by sugc on 2019/2/12.
//  Copyright © 2019 魔方. All rights reserved.
//

import Foundation
import AVKit

@objc protocol MusicCollectionDelegate : NSObjectProtocol {
    @objc func didSelectWithModels(selectModels : Array<MusicMaterialModel>)->Void
    @objc func deSelectWithTag(tag : Int, row : Int)->Void
}

class MusicCollectionViewManager : NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    weak var delegate : MusicCollectionDelegate?
    private var selectIndex : Dictionary<String, String> = Dictionary()
    private var selectModels : Array<MusicMaterialModel> = Array()
    
    var player : AVAudioPlayer?
    
    var numberOfCollection : Int {
        get {
            return MusicMaterialManager.getAllMaterail().count;
        }
    }
    
    override init() {
        super.init()
        //读取所有的配置， 拉取线上配置
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let array = MusicMaterialManager.getAllMaterail()
        
        if array.count > collectionView.tag {
            return array[collectionView.tag].count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = NSString.init(format: "MusicCollectionViewCell%ld", collectionView.tag) as String
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! MusicCollectionViewCell
        
        let array = MusicMaterialManager.getAllMaterail()
        if array.count > collectionView.tag {
            let data = array[collectionView.tag]
            if data.count > indexPath.row {
                let model = data[indexPath.row] as! MusicMaterialModel
                cell.title = model.name
                if (model.imageUrl != nil) {
                    cell.image = UIImage.init(named: model.imageUrl!)
                }
                let key = model.name!
                let value : String? = selectIndex[key]
                if value != nil {
                    cell.isShowMask = true
                }
            }
        }
        return cell
    }
    
    //选中
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let model = self.modelInCollectionView(collectionView: collectionView, indexPath: indexPath) else {
            return
        }

        //选中状态
        let key = model.name!
        var value : String? = selectIndex[key]
        if  value == nil {
            value = String.init(format: "%ld,%ld", collectionView.tag,indexPath.row)
            selectIndex[key] = value
        }
    
        
        let cell = collectionView.cellForItem(at: indexPath) as? MusicCollectionViewCell
        cell?.isShowMask = true
        
        
        var rmModel : MusicMaterialModel? = nil
        if selectModels.count >= 3 {
            rmModel = selectModels.removeLast()
            //取消选中
        }
        
        if !selectModels.contains(model) {
            selectModels.append(model)
            
            //
        }
        
        AudioPlayer.playWithModels(models: selectModels)
        
        if delegate?.responds(to: #selector(MusicCollectionDelegate.didSelectWithModels(selectModels:))) ?? false {
            delegate?.didSelectWithModels(selectModels: selectModels)
        }
        
        //获取model
        
        if rmModel != nil {
            self.deSelectWithMode(rmModel: rmModel)
        }
    }
    
    //取消选中
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        guard let model = self.modelInCollectionView(collectionView: collectionView, indexPath: indexPath) else {
            return
        }
        
        //非选中状态
        let key = model.name!
        selectIndex.removeValue(forKey: key)
        let cell = collectionView.cellForItem(at: indexPath) as? MusicCollectionViewCell
        cell?.isShowMask = false
        
        
        selectModels.removeAll { (removeModel) -> Bool in
            return removeModel.localUrl == model.localUrl
        }
        AudioPlayer.playWithModels(models: selectModels)
        
        if delegate?.responds(to: #selector(MusicCollectionDelegate.didSelectWithModels(selectModels:))) ?? false {
            delegate?.didSelectWithModels(selectModels: selectModels)
        }
    }
    
    
    func modelInCollectionView(collectionView : UICollectionView!, indexPath : IndexPath!) -> MusicMaterialModel? {
        let array = MusicMaterialManager.getAllMaterail()
        if array.count > collectionView.tag {
            let data = array[collectionView.tag]
            if data.count > indexPath.row {
                let model = data[indexPath.row] as! MusicMaterialModel
                return model
            }
        }
        return nil
    }
    
    func deSelectWithMode(rmModel : MusicMaterialModel!) {
        
        guard let indexStr = selectIndex[rmModel.name!] else {
            return
        }
    
        
        let index = indexStr.split(separator:",")
        let tag = Int(index.first!)!
        let row = Int(index.last!)!
        
        if delegate?.responds(to: #selector(MusicCollectionDelegate.deSelectWithTag(tag:row:))) ?? false {
            delegate!.deSelectWithTag(tag: tag, row: row)
        }
        
    }
}
