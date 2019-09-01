//
//  ScheduleItemHeader.swift
//  schedule
//
//  Created by sugc on 2019/7/6.
//  Copyright © 2019 魔方. All rights reserved.
//

import Foundation

typealias  simpelBlock = () -> Void

class ScheduleItemHeader : UICollectionReusableView {
    //a block
    //go edit block
    
    var titleLabel : UILabel?
    var timeLabel : UILabel?
    var editView : UIView?
    var clickBlock : simpelBlock?
    private var swipeGesture : UISwipeGestureRecognizer?
    private var tapGesture : UITapGestureRecognizer?
    
    private var model : ScheduleModel?
    var scheduleModel : ScheduleModel? {
        set (scheduleModel){
            model = scheduleModel
            self.layoutWithFrame(newFrame: self.frame, model: scheduleModel!)
        }
        
        get {
            return model
        }
    }
    
    override var frame: CGRect {
        set(frame) {
            if !frame.equalTo(super.frame) {
                super.frame = frame
                self.layoutWithFrame(newFrame: frame)
            }
        }
        
        get {
            return super.frame
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //
        titleLabel = UILabel()
        timeLabel = UILabel()
        editView = UIView.init()
        
        titleLabel?.textColor = UIColor.black
        timeLabel?.textColor = UIColor.black
        
        self.addSubview(titleLabel!)
        self.addSubview(timeLabel!)
        
        swipeGesture = UISwipeGestureRecognizer.init(target: self, action: #selector(swipe))
        tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tap))
        
        swipeGesture?.direction = UISwipeGestureRecognizer.Direction.left
        tapGesture?.numberOfTapsRequired = 1
        tapGesture?.require(toFail: swipeGesture!)
        
        self.addGestureRecognizer(swipeGesture!)
        self.addGestureRecognizer(tapGesture!)
        
        
        //添加手势
        //
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func layoutWithFrame(newFrame : CGRect) {
        //
        if model != nil {
             layoutWithFrame(newFrame: newFrame, model: model!)
        }
    }
    
    func layoutWithFrame(newFrame : CGRect, model : ScheduleModel) {
        //
        titleLabel?.text = model.eventTitle
        timeLabel?.text = model.getTimeString()
        
        titleLabel?.sizeToFit()
        timeLabel?.sizeToFit()
        
        timeLabel?.left = 15
        timeLabel?.top = 10
        
        titleLabel?.left = timeLabel!.left
        titleLabel?.top = timeLabel!.bottom  + 5
        
        //
    }
    
    @objc func swipe() {
        //
        
    }

    @objc func tap() {
        //
        if clickBlock != nil {
            clickBlock!()
        }
        
    }
}
