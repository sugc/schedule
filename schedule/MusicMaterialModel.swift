//
//  MusicMaterialModel.swift
//  schedule
//
//  Created by sugc on 2019/2/15.
//  Copyright © 2019 魔方. All rights reserved.
//

import Foundation
let localDic = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!

class MusicMaterialModel : NSObject {
    var type : urlType?
    var url : String?
    var name : String?
    var imageUrl : String?
    var localUrl : String? {
        get {
            var returnUrl : String? = nil
            if url != nil {
                if type == urlType.local {
                    returnUrl = url
                }else {
                    //获取url最后一段
                    let parts = url?.components(separatedBy: "/")

                    if parts != nil && parts!.count > 0 {
                        returnUrl = localDic + parts!.last!
                    }
                }
            }
            
            guard let finalUrl = returnUrl else {
                return nil
            }
            
            if FileManager.default.fileExists(atPath: finalUrl) {
                return finalUrl
            }
            
            return nil
        }
    }
    
    var hasDownLoaded : Bool {
        get {
            if type == urlType.remote {
                //
                return false
            }
            return true
        }
    }
    
    override init() {
        super.init()
    }
    
    convenience init(dic : Dictionary<String, Any>) {
        self.init()
        url = dic["url"] as? String
        name = dic["Name"] as? String
        imageUrl = dic["imageUrl"] as? String
        type = dic["type"] as? urlType
    }
}
