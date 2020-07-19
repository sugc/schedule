//
//  SleepyViewController.swift
//  schedule
//
//  Created by sugc on 2019/1/25.
//  Copyright © 2019 魔方. All rights reserved.
//

import Foundation
import UIKit
//import SDWebImage

enum TimeMode : NSInteger{
//    typealias RawValue = Int
    
    case forever = 99999,
        halfAnHour = 30,
        anHour = 60
}



//
class SleepAudioViewController : UIViewController, TopBarManagerDelegate, MusicCollectionDelegate, UIScrollViewDelegate {
    
    private var musicCollectionViews : Array<UICollectionView>!
    private var topBarView : UICollectionView!
    private var lineView : UIView!
    private var playerView : UIImageView!
    private var scrollView : UIScrollView!
    private var topBarManager : TopBarManager! = TopBarManager()
    private var imageViews : Array<UIImageView> = Array()
    private var playBtn : UIButton!
    private var timeBtn : UIButton!
    private var timeMode : TimeMode = TimeMode.forever
    private var timer : Timer?
    
    private var timerCount : Int = 0
    
    private var musicCollectionViewManager : MusicCollectionViewManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.layout()
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func layout() {
        
        musicCollectionViewManager = MusicCollectionViewManager()
        musicCollectionViewManager.delegate = self
        musicCollectionViews = Array.init()
        let topBarViewFrame : CGRect = CGRect.init(x: 0,
                                                   y: iPhoneXSafeDistanceTop + 5,
                                                   width: ScreenWidth,
                                                   height: 44)
        let layout = UICollectionViewFlowLayout()

        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layout.itemSize = CGSize.init(width: 60, height: 44)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        topBarView = UICollectionView.init(frame: topBarViewFrame, collectionViewLayout: layout)
        topBarView.backgroundColor = UIColor.clear
        topBarView.register(TopBarCell.classForCoder(), forCellWithReuseIdentifier: "topBarCell")
        topBarManager.tbBelegate = self
        
        topBarView.delegate = topBarManager
        topBarView.dataSource = topBarManager
        lineView = UIView.init(frame: CGRect.init(x: layout.sectionInset.left, y: topBarView.height - 1, width: layout.itemSize.width - 10, height: 1));
        lineView.backgroundColor = UIColor.red;
        self.updateLineView(ratio: 0)
        topBarView.addSubview(lineView)
        
        let playerFrame = CGRect.init(x: 15,
                                      y: topBarView.bottom + 25,
                                      width: ScreenWidth - 30,
                                      height: (ScreenWidth - 30) * 0.4)
        playerView = UIImageView.init(frame: playerFrame)
        playerView.isUserInteractionEnabled = true
        playerView.backgroundColor = UIColor.blue
        playerView.layer.cornerRadius = 5
        playerView.layer.masksToBounds = true
        playerView.image = UIImage.init(named: "backGroud_sleep_music")
        playerView.contentMode = UIView.ContentMode.scaleAspectFill
        
        //播放视图
        let space : CGFloat = 15
        let imgViewSize : CGFloat = 30
        for i in 0...2 {
            let frame = CGRect.init(x: space + (imgViewSize + space) * CGFloat(i), y: 10, width: imgViewSize, height: imgViewSize)
            let imageView = UIImageView.init(frame: frame)
            imageView.contentMode = UIView.ContentMode.scaleAspectFit
            playerView.addSubview(imageView)
            imageViews.append(imageView)
        }
        
        let timeBtnFrame = CGRect.init(x: playerFrame.size.width - 30 - 20,
                                       y: 15,
                                       width: 30,
                                       height: 30)
        timeBtn = UIButton.init(frame: timeBtnFrame)
        timeBtn.showsTouchWhenHighlighted = false
        timeBtn.addTarget(self, action: #selector(changeTimeMode), for: UIControl.Event.touchUpInside)
        playerView.addSubview(timeBtn)
        
        let playBtnFrame = CGRect.init(x: timeBtn.left - 30 - 10,
                                       y: 15,
                                       width: 30,
                                       height: 30)
        playBtn = UIButton.init(frame: playBtnFrame)
        playBtn.showsTouchWhenHighlighted = false
        playBtn.addTarget(self, action: #selector(playMusic), for: UIControl.Event.touchUpInside)
        playerView.addSubview(playBtn)
        refreshPlayBtn()
        
        let maskView = UIView.init(frame: playerView.frame)
        maskView.layer.shadowOffset = CGSize.init(width: 2, height: 2)
        
        maskView.backgroundColor = UIColor.white
        maskView.layer.cornerRadius = 5
        maskView.layer.shadowRadius = 5
        maskView.layer.shadowColor = UIColor.black.cgColor
        maskView.layer.shadowOpacity = 0.5
        
        let scrollSpace : CGFloat = 25
        let scrollViewFrame : CGRect = CGRect.init(x: 0,
                                                   y: playerView.bottom + scrollSpace,
                                               width: ScreenWidth,
                                               height: ScreenHeight - ((self.tabBarController?.tabBar.height) ?? 0) - playerView.bottom - scrollSpace)
        scrollView = UIScrollView.init(frame: scrollViewFrame)
        scrollView.contentSize = CGSize.init(width: scrollView.width * CGFloat(musicCollectionViewManager.numberOfCollection), height: scrollView.height)
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isDirectionalLockEnabled = true
        self.view.addSubview(topBarView)
        self.view.addSubview(maskView)
        self.view.addSubview(playerView)
        self.view.addSubview(scrollView)
        
        for i in 0...(musicCollectionViewManager.numberOfCollection - 1) {
            let collectionViewLayout = UICollectionViewFlowLayout()
            collectionViewLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
            
            collectionViewLayout.itemSize = CGSize(width: ScreenWidth / 4.0, height: ScreenWidth / 4.0)
            collectionViewLayout.minimumLineSpacing = 0
            collectionViewLayout.minimumInteritemSpacing = 0
            
            let collectionViewFrame : CGRect = CGRect.init(x: CGFloat(i) * scrollView.width,
                                                           y: 0,
                                                           width: ScreenWidth,
                                                           height: ScreenHeight - iPhoneXSafeDistanceBottom - playerView.bottom)
            let musicCollectionView = UICollectionView.init(frame: collectionViewFrame, collectionViewLayout: collectionViewLayout)
            //在代理中根据tag来知道所在位置
            musicCollectionView.tag = i
            let identifier = NSString.init(format: "MusicCollectionViewCell%ld", i) as String
            musicCollectionView.register(MusicCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: identifier)
            musicCollectionView.backgroundColor = UIColor.white
            musicCollectionView.delegate = musicCollectionViewManager
            musicCollectionView.dataSource = musicCollectionViewManager
            musicCollectionView.allowsMultipleSelection = true
            musicCollectionView.bouncesZoom = true
            musicCollectionView.alwaysBounceVertical = true
            self.scrollView.addSubview(musicCollectionView)
            musicCollectionViews.append(musicCollectionView)
        }
    }
    
    @objc func playMusic() {
        //播放音乐
        if AudioPlayer.isPlaying {
            AudioPlayer.pause()
            
        }else {
             AudioPlayer.resume()
        }
        refreshPlayBtn()
        starTimerIfNeed()
    }
    
    @objc func changeTimeMode() {
        
        var timeStr : String? = nil
        switch timeMode {
        case .forever:
        timeMode = .halfAnHour
        timeStr = "30分后自动停止"
        break
        case .halfAnHour:
        timeMode = .anHour
        timeStr = "60分后自动停止"
        break;
        case .anHour:
        timeMode = .forever
        break
        default:
        break
        }
        
        if timeStr != nil {
            UnblockTipsView.showUnblockTipsOnView(view: self.view, title: nil, message: timeStr)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                UnblockTipsView.hideUnblockTipsForView(view: self.view)
            }
        }
        refreshPlayBtn()
        starTimerIfNeed()
    }
    
    func starTimerIfNeed() {
        timer?.invalidate()
        timerCount  = 0
        timer = nil
        if timeMode != .forever && AudioPlayer.isPlaying {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerStopMusic), userInfo: nil, repeats: true)
        }
    }

    @objc func timerStopMusic() {
        timerCount += 1
        if timerCount > timeMode.rawValue * 60 {
            AudioPlayer.pause()
            refreshPlayBtn()
            timer?.invalidate()
            timer = nil
        }
    }
    
    func refreshPlayBtn() {
        playBtn.isHidden = !AudioPlayer.hasPlayItems
        timeBtn.isHidden = !AudioPlayer.hasPlayItems
        let imgName = AudioPlayer.isPlaying ? "icon_pause" : "icon_play"
        playBtn.setBackgroundImage(UIImage.init(named: imgName), for: UIControl.State.normal)
        
        var timeBtnImgName = ""
        switch timeMode {

        case .forever:
            timeBtnImgName = "icon_time_forever"
            break
        case .halfAnHour:
            timeBtnImgName = "icon_time_half_hour"
            break;
        case .anHour:
            timeBtnImgName = "icon_time_an_hour"
            break
        default:
            break
        }
        timeBtn.setBackgroundImage(UIImage.init(named: timeBtnImgName), for: UIControl.State.normal)
    }
    
    func didSelectAtIndex(index : NSInteger)->Void {
        //滚动到某个位置
        scrollView.setContentOffset(CGPoint(x: scrollView.width * CGFloat(index), y: 0), animated: true)
    }
    
    func didSelectWithModels(selectModels: Array<MusicMaterialModel>) {
        //更新视图
        for i in 0...(imageViews.count - 1) {
            if selectModels.count > i {
                let model = selectModels[i]
                guard let imgUrl = model.imageUrl else {
                    continue
                }
                
                if model.type == urlType.remote {
//                    imageViews[i].sd_setImage(with: URL.init(string: imgUrl), placeholderImage: nil, options: SDWebImageOptions.delayPlaceholder, completed: nil)
                }else {
                    imageViews[i].image = UIImage.init(named: imgUrl)
                }
            }else {
                imageViews[i].image = nil
            }
        }
        
        refreshPlayBtn()
    }

    func deSelectWithTag(tag : Int, row : Int) {
        for collectionView in musicCollectionViews {
            if collectionView.tag == tag {
                collectionView.deselectItem(at: IndexPath.init(row: row, section: 0), animated: true)
            
                let cell  = collectionView.cellForItem(at: IndexPath.init(row: row, section: 0)) as? MusicCollectionViewCell
                cell?.isShowMask = false
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //
        let offset = scrollView.contentOffset.x
        let ratio = offset / scrollView.width
        self.updateLineView(ratio: ratio)
    }
    
    func updateLineView(ratio : CGFloat) {
        let layout = topBarView.collectionViewLayout as! UICollectionViewFlowLayout
        lineView.centerX = layout.sectionInset.left + (layout.itemSize.width ) * (ratio + 0.5)
    }
}
