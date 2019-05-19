//
//  TomatoViewController.swift
//  schedule
//
//  Created by sugc on 2018/9/15.
//  Copyright © 2018年 魔方. All rights reserved.
//

//番茄时钟，可以设置每个番茄时钟的时长，休息时间，以及长休息时间

//休息倒计时

//工作倒计时

//番茄个数显示

import Foundation

class TomatoViewController : UIViewController {
    //一个倒计时时钟
    var countDonwView : CountDownView!
    var isCurrentRestTime : Bool = false //在工作还是休息
    var enterbackGroundTime : Date?      //进入后台的时间
    
    private var mottoTextView : UITextView!
    private var cancelBtn : UIButton!  //
    private var lightBtn : UIButton!   //常亮按钮
    
    private var tomatoModel : Dictionary<String, Any>!
    private var alertVC : UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.initUI()
        
        //读取配置文件， 获取番茄时钟的时长，短休息时长，间隔几次有一个长休息，长休息时长
        
        
        //默认是25分钟，5分钟， 4， 20分钟
        
        
        //成功工作获得一个番茄，否则获得一个烂番茄
        
        
        //好番茄和，烂番茄只保留当天数目
        
        //可以生成使用记录， 考虑使用微信登录

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(enterBackGround),
                                               name: NSNotification.Name.UIApplicationDidEnterBackground,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(enterForeGround),
                                               name: NSNotification.Name.UIApplicationWillEnterForeground,
                                               object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.countDonwView.finishCountDown()
    }
    
    func initUI() {
        self.view.backgroundColor = UIColor.white
        let width = ScreenWidth / 2.0
        let frame = CGRect.init(x: (ScreenWidth - width) / 2.0,
                                y: (ScreenHeight - width) / 2.0,
                                width: width,
                                height: width)
        
        countDonwView = CountDownView.init(frame: frame)
        countDonwView.starCountDown(countDownTimeInterval: TimeInterval(10))
        weak var weakSelf = self
        countDonwView.finishCountDownClosure = {
            weakSelf?.finishCountDonw()
        }
        
        let textFrame = CGRect.init(x: 15,
                                    y: 60 + iPhoneXSafeDistanceTop,
                                    width: ScreenWidth,
                                    height: 30)
        mottoTextView = UITextView.init(frame: textFrame)
        mottoTextView.font = UIFont.boldSystemFont(ofSize: 13)
        mottoTextView.textColor = UIColor.lightGray
        mottoTextView.text = "天才是百分之九十九的汗水加上百分之一的灵感"
        
        let lingtFramS : CGFloat = 40
        let lightFrame = CGRect.init(x: ScreenWidth / 2.0 + 20,
                                     y: ScreenHeight - lingtFramS - 40 - iPhoneXSafeDistanceBottom,
                                     width: lingtFramS,
                                     height: lingtFramS)
        lightBtn = UIButton.init(frame: lightFrame)
        lightBtn.setImage(UIImage.init(named:"icon_light_normal"), for: UIControlState.normal)
        lightBtn.setImage(UIImage.init(named: "icon_light_selected"), for: UIControlState.selected)
        lightBtn.addTarget(self,
                           action: #selector(clickLightBtn),
                           for: UIControlEvents.touchUpInside)
        
        let cancelFrame = CGRect.init(x: ScreenWidth / 2.0 - 20 - lingtFramS,
                                      y: ScreenHeight - lingtFramS - 40 - iPhoneXSafeDistanceBottom,
                                      width: lingtFramS,
                                      height: lingtFramS)
        cancelBtn = UIButton.init(frame: cancelFrame)
        cancelBtn.setImage(UIImage.init(named: "icon_cancel"), for: UIControlState.normal)
        cancelBtn.addTarget(self,
                            action: #selector(closePage),
                            for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(mottoTextView)
        self.view.addSubview(countDonwView)
        self.view.addSubview(lightBtn)
        self.view.addSubview(cancelBtn)
    }
    
    //结束一次计时
    func finishCountDonw() -> Void {
        print("has finished countDown")
        //已经结束， 提示用户， 开始休息的番茄钟
        
        alertVC?.dismiss(animated: false, completion: nil)
        alertVC = nil
        
        
        countDonwView.starCountDown(countDownTimeInterval: TimeInterval(10))
        
        if isCurrentRestTime {
            //判断是否需要进入下一个工作循环
            
        }else {
            //判断是否已经完全全部
            
            //进入休息时间，提示还有下一个循环
        }
        //写入记录
    }
    
    //获取番茄
    func getATomato() {
        //记录番茄数目和时间
        
        //获取番茄动画
    }
    
    //进入后台，不停止计时， 通知提示
    func enterBackGround() -> Void {
        countDonwView.pause()
        
        //是否需要后台保活? 默认开启
        
        if isCurrentRestTime {
            //当前在休息不提示，休息结束时提示继续任务
        }else {
            //当前时间小于10s则不提示
            if countDonwView.remiandTimeInterval > 5 {
               addLocalNotification(title: "退到后台超过5秒即视为任务失败", fireDate: Date.init(timeIntervalSinceNow: 1))
            }
        }
    
    }
    
    //判断进入后台的时间多久，超出则提示失败
    func enterForeGround() -> Void {
        //判断进入后台多久, 暂定5s
        countDonwView.resumeWhenEnterForeGround()
    }
    
    //关闭当前页面
    func closePage() -> Void {
        //判断当前时间
        if isCurrentRestTime || countDonwView.remiandTimeInterval <= 5 {
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        let confirmAction = UIAlertAction.init(title: "确定",
                                               style: UIAlertActionStyle.default,
                                               handler: ({ (action) in
                                                    self.navigationController?.popViewController(animated: true)
                                               }))
        let cancelAction = UIAlertAction.init(title: "取消",
                                              style: UIAlertActionStyle.default,
                                              handler: ({(action)in
                                                
                                              }))
        alertVC = UIAlertController.init(title: "",
                                             message: "退出当前页面视为任务失败，是否确定退出",
                                             preferredStyle: UIAlertControllerStyle.alert)
        alertVC!.addAction(cancelAction)
        alertVC!.addAction(confirmAction)
        self.present(alertVC!, animated: true, completion: nil)

    }
    
    //点击屏幕常亮按钮
    func clickLightBtn() {
        
        lightBtn.isSelected = !lightBtn.isSelected
        var message = "已经关闭屏幕常亮"
        if lightBtn.isSelected {
            message = "已经开启屏幕常亮"
        }
        UIApplication.shared.isIdleTimerDisabled = lightBtn.isSelected
        //显示message
        
    }
    
    deinit {
        //
        
    }
}



