//
//  ScheduleViewController.swift
//  schedule
//
//  Created by sugc on 2019/6/29.
//  Copyright © 2019 魔方. All rights reserved.
//

import Foundation

class ScheduleViewController : SimpleBackViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    private var collectionView : UICollectionView!
    private var handerl : ATestHandler = ATestHandler()
    private var data : Array<ScheduleModel>!
    private var reuseIdentifier = "reuseidentifier"
    private var headerReuseIdentifier = "headerReuseIdentifier"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        data = [self.fakeData()]
        
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
    
        collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.frame = CGRect.init(x: 0, y: self.navigateView.bottom, width: ScreenWidth, height: ScreenHeight - self.navigateView.bottom)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(ScheduleItemCell.classForCoder(), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(ScheduleItemHeader.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.view.addSubview(collectionView)
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let model = data[section]
        if model.shoulUnfold {
            return 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
         return CGSize.init(width: ScreenWidth, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: ScreenWidth, height: 100)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath) as! ScheduleItemHeader
            header.scheduleModel = data[indexPath.row]
            //设置点击回调
            
            //reload section
            header.clickBlock = {
                let model = self.data[indexPath.section]
                model.shoulUnfold = !model.shoulUnfold
                self.collectionView.reloadSections([indexPath.section])
            }
            return header
        }
        return UICollectionReusableView.init()
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : ScheduleItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ScheduleItemCell
        cell.backgroundColor =  UIColor.red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
        
    }
    
    
    func fakeData()-> ScheduleModel! {
        
//        var key : NSString!
//        var eventTitle : NSString!
//        var starTime : TimeInterval!
//        var endTime : TimeInterval!
//        var progress : CGFloat!
//        var subModels : Array<ScheduleModel>?
        
        let dic = [
            "key" : "atestKey",
            "eventTitle" : "测试专用",
            "starTime" : 11223344,
            "endTime" : 11223944,
            "progress" : 0.0,
            "subModels" : [
                [
                    "key" : "atestKey",
                    "eventTitle" : "测试专用",
                    "starTime" : 11223344,
                    "endTime" : 11223944,
                    "progress" : 0.0,
                    "subModels" : [
                        
                    ]
                ],
                [
                    "key" : "atestKey",
                    "eventTitle" : "测试专用",
                    "starTime" : 11223344,
                    "endTime" : 11223944,
                    "progress" : 0.0,
                    "subModels" : [
                        
                    ]
                ],
                [
                    "key" : "atestKey",
                    "eventTitle" : "测试专用",
                    "starTime" : 11223344,
                    "endTime" : 11223944,
                    "progress" : 0.0,
                    "subModels" : [
                        
                    ]
                ]
            ]
            ] as [String : Any]
        
        let model = ScheduleModel.init(data: dic)
        return model
    }
    
}

