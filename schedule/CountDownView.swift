//
//  CountDownView.swift
//  schedule
//
//  Created by sugc on 2018/9/15.
//  Copyright © 2018年 魔方. All rights reserved.
//

//倒计时控件
import Foundation

class CountDownView : UIView {
    //倒计时总时间
    var countDownTimeInterval : TimeInterval!
    var progressLayer : CAShapeLayer!
    var finishCountDownClosure : (()->Void)?
    //当前剩余时间
    var remiandTimeInterval : TimeInterval! {
        get {
            return remiandCountDown
        }
    }
    
    //进入后台再进入前台是否需要继续
    var shouldResignWhenEnterForeGroud : Bool {
        set {
            if self.shouldResignWhenEnterForeGroud {
                //添加通知
            }else {
                NotificationCenter.default.removeObserver(self)
            }
        }
        
        get {
            return self.shouldResignWhenEnterForeGroud
        }
    }
    
    private var remiandCountDown : TimeInterval!
    private var countDownLabel : UILabel!
    private var starTime : Date?
    private var timer : DispatchSourceTimer?
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        countDownLabel = UILabel.init(frame: self.bounds)
        countDownLabel.textAlignment = NSTextAlignment.center
        countDownLabel.textColor = UIColor.black
        self.addSubview(countDownLabel)
        progressLayer = CAShapeLayer.init()
        let size = frame.width > frame.height ? frame.height : frame.width
        progressLayer.frame = CGRect.init(x: (frame.width - size) / 2.0,
                                          y: (frame.height - size) / 2.0,
                                          width: size,
                                          height: size)
        progressLayer.path = UIBezierPath.init(roundedRect: CGRect.init(x: 0, y:0 , width: size, height: size), cornerRadius: size / 2.0).cgPath
        progressLayer.lineWidth = 3.0
        progressLayer.strokeColor = UIColor.red.cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = 1
        self.layer.addSublayer(progressLayer)
    }
    
    func showLabelWithRemindCountDown(remindTime : TimeInterval) {
        //显示
        let hour : Int = Int(remindTime / 60 / 60)
        let min : Int = Int((remindTime - Double(hour * 60 * 60)) / 60)
        let second = Int(remindTime - Double(hour * 60 * 60 + min * 60))
        var str : String = String.init(format: "%02ld:%02ld", min,second)
        if hour > 0 {
            str = String.init(format: "%02ld:%02ld:%02ld", hour,min,second)
        }
        self.countDownLabel.text = str
        self.progressLayer.strokeStart = CGFloat(1.0 - self.remiandCountDown / self.countDownTimeInterval)
    }
    
    func starCountDown(countDownTimeInterval : TimeInterval) {
        self.countDownTimeInterval = countDownTimeInterval
        self.remiandCountDown = countDownTimeInterval
        //取消动画
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        self.showLabelWithRemindCountDown(remindTime: countDownTimeInterval)
        CATransaction.commit()
        self.starCountDown()
    }
    
    private func starCountDown() {
        //设置初始的状态
        remiandCountDown = countDownTimeInterval
        self.showLabelWithRemindCountDown(remindTime: self.remiandCountDown)
        //记录开始时间
        starTime = Date()
        timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
        timer!.setEventHandler {
            //处理倒计时
            if (self.remiandCountDown > 0) {
                self.remiandCountDown = self.remiandCountDown - 1;
            }else {
                self.finishCountDown()
            }
            DispatchQueue.main.async {
                self.showLabelWithRemindCountDown(remindTime: self.remiandCountDown)
            }
        }
        timer!.scheduleRepeating(deadline: DispatchTime.now(), interval: DispatchTimeInterval.seconds(1), leeway: DispatchTimeInterval.seconds(0))
        dispatch_queue_main_t.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.timer!.resume()
        }
    }
    
    func pause() -> Void {
        timer?.suspend()
    }
    
    func resumeWhenEnterForeGround() -> Void {
        let date = Date()
        let timeInterval = date.timeIntervalSince(starTime!)
        if timeInterval > (countDownTimeInterval - remiandCountDown) {
            remiandCountDown = countDownTimeInterval - timeInterval
        }
        self.showLabelWithRemindCountDown(remindTime: remiandCountDown)
        timer?.resume()
    }
    
    func cancelCountDown() {
        timer?.cancel()
        timer = nil
    }
    
    //
    func finishCountDown() -> Void {
        timer?.cancel()
        timer = nil
        if (self.finishCountDownClosure != nil) {
            self.finishCountDownClosure!()
        }
    }
    
}
