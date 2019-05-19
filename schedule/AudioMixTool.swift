//
//  AudioMixTool.swift
//  schedule
//
//  Created by sugc on 2019/3/26.
//  Copyright © 2019 魔方. All rights reserved.
//

import Foundation
import AVFoundation

class AudioMixTool : NSObject {
    
    static func mixAudioInPathes(pathes:Array<String>, completion: @escaping (_ url:URL)->Void) {
        var urlArray = Array<URL>()
        
        for path in pathes {
            let url = URL.init(fileURLWithPath: path)
            urlArray.append(url)
        }
        self.mixAudioInUrls(urls: urlArray, completion: completion)
    }
    
    
    static func mixAudioInUrls(urls:Array<URL>, completion: @escaping (_ url:URL)->Void) {
        
        if urls.count == 1 {
            completion(urls.first!)
            return
        }
    
        var assets : Array<AVURLAsset> = Array.init()
        for url in urls {
            let asset = AVURLAsset.init(url: url)
            assets.append(asset)
        }
        self.mixAudioInAssets(assets: assets, completion: completion)
    }
    
    static func mixAudioInAssets(assets:Array<AVURLAsset>, completion: @escaping (_ url:URL)->Void) {
        let composition = AVMutableComposition()
        var durationValue : Float = 10000
        var timeRange : CMTime = CMTime.init()
        for asset in assets {
            let seconds = Float(asset.duration.value) / Float(asset.duration.timescale)
            if seconds < durationValue {
                durationValue = seconds
                timeRange = asset.duration
            }
        }
        
        
        for asset in assets {
            let track = composition.addMutableTrack(withMediaType: AVMediaTypeAudio, preferredTrackID: kCMPersistentTrackID_Invalid)
            let duration = CMTimeRangeMake(kCMTimeZero, asset.duration)
            do {
                try track.insertTimeRange(duration, of: asset.tracks(withMediaType: AVMediaTypeAudio)[0], at: kCMTimeZero)
            }catch {
                //
                print("track error")
            }
        }
        
        let outputPath = NSTemporaryDirectory() + "/temp.m4a"
        let manager = FileManager.init()
        if manager.fileExists(atPath: outputPath) {
            do {
                try manager.removeItem(atPath: outputPath)
            }catch {
                
            }
        }
        
        let exporter = AVAssetExportSession.init(asset: composition, presetName: AVAssetExportPresetAppleM4A)!
        exporter.outputURL = URL.init(fileURLWithPath: outputPath)
        exporter.outputFileType = AVFileTypeAppleM4A
        exporter.timeRange = CMTimeRange.init(start: kCMTimeZero, end: timeRange)
        exporter.exportAsynchronously {
            completion(exporter.outputURL!)
        }
    }
}
