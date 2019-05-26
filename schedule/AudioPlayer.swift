//
//  AudioPlayer.swift
//  schedule
//
//  Created by sugc on 2019/3/4.
//  Copyright © 2019 魔方. All rights reserved.
//

import Foundation
import AVKit

var currentMaterials : NSMutableSet = NSMutableSet()
var playerDic : Dictionary<String, AVAudioPlayer> = Dictionary()

class AudioPlayer : NSObject {
    
    static var isPlaying : Bool{
        get {
            for player in playerDic.values {
                if player.isPlaying {
                    return true
                }
            }
            return false
        }
    }
    
    static var hasPlayItems : Bool{
        get {
            return playerDic.values.count > 0
        }
    }
    static func playerInstance(url : URL!) ->AVAudioPlayer? {
        var playerInstance : AVAudioPlayer?
        do {
            try playerInstance = AVAudioPlayer.init(contentsOf: url)
            playerInstance?.numberOfLoops = -1
        }catch {
            print("play audio error")
        }
        return playerInstance
    }
    
    static func stop()  {
        for player in playerDic.values {
            player.stop()
        }
    }
    
    static func pause() {
        for player in playerDic.values {
            player.pause()
        }
    }
    
    static func resume() {
        for player in playerDic.values {
            player.play()
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
