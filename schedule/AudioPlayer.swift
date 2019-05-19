//
//  AudioPlayer.swift
//  schedule
//
//  Created by sugc on 2019/3/4.
//  Copyright © 2019 魔方. All rights reserved.
//

import Foundation
import AVKit

var player : AVAudioPlayer?
var currentMaterials : NSMutableSet = NSMutableSet()
var playerDic : Dictionary<String, AVAudioPlayer> = Dictionary()

class AudioPlayer : NSObject {
    
    static func star()  {
        player?.play()
    }
    
    static func playerInstance(url : URL!) ->AVAudioPlayer? {
        var playerInstance : AVAudioPlayer?
        do {
            try playerInstance = AVAudioPlayer.init(contentsOf: url)
            player?.numberOfLoops = -1
        }catch {
            print("play audio error")
        }
        return playerInstance
    }
    
    static func star(url:URL!) {
        player = self.playerInstance(url: url)
        player?.play()
    }
    
    static func stop()  {
        player?.stop()
    }
    
    static func pause()  {
        player?.pause()
    }
    
    static func resume()  {
        player?.play()
    }
    
    static func resume(url:URL)  {
        var starTime : TimeInterval = 0
        if player != nil {
            player?.stop()
            starTime = player!.currentTime
        }
        
        player = self.playerInstance(url: url)
        player?.currentTime = starTime
        player?.numberOfLoops = -1
        player?.play()
    }
    
    static func resumeWithModels(models:Array<MusicMaterialModel>) {
        var starTime : TimeInterval = 0
        if player != nil {
            player?.stop()
            starTime = player!.currentTime
        }
        
        currentMaterials.removeAllObjects()
        for model in models {
            guard let path = model.localUrl else {
                continue
            }
            currentMaterials.add(path)
        }
        
        AudioMixTool.mixAudioInPathes(pathes: currentMaterials.allObjects as! Array<String>) { (url) in
            //开始播放
            self.resume(url: url)
        }
    }
    
    
    static func add(model:MusicMaterialModel?) {
        
        guard let model = model else {
            return
        }
        
        //转成路径
        guard let filePath = model.localUrl else {
            return
        }
        
        currentMaterials.add(filePath)
        AudioMixTool.mixAudioInPathes(pathes: currentMaterials.allObjects as! Array<String>) { (url) in
            //开始播放
            self.resume(url: url)
        }
    }
    
    static func add(path:String!) {
        //转成路径
        currentMaterials.add(path)
        AudioMixTool.mixAudioInPathes(pathes: currentMaterials.allObjects as! Array<String>) { (url) in
            //开始播放
            self.resume(url: url)
        }
    }
    
    static func remove(model:MusicMaterialModel?) {
        
        guard let model = model else {
            return
        }
        
        guard let filePath = model.localUrl else {
            return
        }
        
        currentMaterials.remove(filePath)
        if currentMaterials.count <= 0 {
            self.stop()
        }
        
        AudioMixTool.mixAudioInPathes(pathes: currentMaterials.allObjects as! Array<String>) { (url) in
            //开始播放
            self.resume(url: url)
        }
    }
    
    //初始化session
    static func initSession() {
        UIApplication.shared.beginReceivingRemoteControlEvents()
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(AVAudioSessionCategoryPlayback)
            try session.setActive(true)
        }catch {
            
        }
    }
    
    //处理进入后台，耳机插入，电话等事件
    
    static func playWithModels(models:Array<MusicMaterialModel>) {
        
        var dic : Dictionary<String, AVAudioPlayer> = Dictionary()
        
        for model in models {
            guard let path = model.localUrl else {
                continue
            }
            
            if playerDic[path] == nil {
                
            }
            
            
            guard let currentPlayer = playerDic[path] else {
                guard let player = self.playerInstance(url: URL.init(fileURLWithPath: path)) else {
                    continue
                }
                player.prepareToPlay()
                player.play()
                dic[path] = player
                continue
            }
            
            dic[path] = currentPlayer
        }
        playerDic = dic
    }
}
