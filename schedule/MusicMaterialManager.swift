//
//  MusicMaterialManager.swift
//  schedule
//
//  Created by sugc on 2019/2/15.
//  Copyright © 2019 魔方. All rights reserved.
//

//素材管理类
//第一版先完全内置

import Foundation

enum urlType : String {
    case remote = "remote"
    case local = "local"
}

var materials : Array<Array<Any>> = Array()
var materialTypes : Array<String> = Array()
let materialsPath : String! = NSHomeDirectory() + "/MusicMaterial/config.json"

class MusicMaterialManager {
    
    //获取所有素材分类
    static func getMaterailTypes() ->Array<String>{
        if materialTypes.count > 0 {
            return materialTypes
        }
        
        let array = self.getAllMaterailsArray()
        for item in array {
            let dic : Dictionary<String, Any> = item as! Dictionary<String, Any>
            let className = dic["className"] as? String
            if className != nil {
                materialTypes.append(className!)
            }
        }
        return materialTypes
    }
    
    //获取所有的素材
    static func getAllMaterail() ->Array<Array<Any>> {
        
        if materials.count > 0 {
            return materials
        }
        
        let array = self.getAllMaterailsArray()
        
        //解析数据,转换成model
        for item in array {
            var subArray : Array<MusicMaterialModel> = Array()
            let dic : Dictionary<String, Any> = item as! Dictionary<String, Any>
            let data : Array<Any> = dic["data"] as! Array<Any>
            
            for materialModelDic in data {
                let model = MusicMaterialModel.init(dic: materialModelDic as! Dictionary<String, Any>)
                subArray.append(model)
            }
            materials.append(subArray)
        }
        return materials
    }
    
    //
    private static func getAllMaterailsArray() ->Array<Any> {
        //获取所有的素材
        var array : Array<Any>
        if(FileManager.default.fileExists(atPath: materialsPath)) {
            array = NSArray.init(contentsOfFile: materialsPath) as! Array<Any>
        }else {
            array = defaultCofig()
//            (array as NSArray).write(toFile: materialsPath, atomically: true)
        }
        return array
    }
    
    //获取在线素材
    static func getOneLineMaterail() {
        //读取配置
        
    }
    
    //获取本地配置的素材
    static func getLocalMaterail() {
        
    }
    
    //获取自定义素材, 可以第一个版本直接加上
    static func getCustomMaterail() {
        
    }
    
    //下载素材， 进度？
    static func downloadMaterial() {
        
    }
    
    //本地配置？
    static func defaultCofig()->Array<Any> {
        
        let array = [["className":"自然",
                      "data":getNatureMusic() ],
                     ["className":"动物",
                      "data":getAnimalMusic()],
                     ]
        
        
        return array
    }
    
    
    static func getNatureMusic() -> Array<Dictionary<String,Any>>? {

        return self.dataWithType(type: "Natural")
    }
    
    static func getAnimalMusic() -> Array<Dictionary<String,Any>>? {
        return self.dataWithType(type: "Animal")
        
    }
    
    static func dataWithType(type:String) -> Array<Dictionary<String,Any>>? {
        let path = Bundle.main.path(forResource: type, ofType: nil)
//        let path = Bundle.main.path(forResource: "碧海涛声", ofType: ".mp3")
        guard let dic = path else {
            return nil
        }
        
        guard let fileNames = self.pathsWithDic(dic: dic) else {
            return nil
        }
        
        var returnArray : Array<Dictionary<String,Any>> = Array()
        for fileName in fileNames {
            let realName = fileName.replacingOccurrences(of: ".mp3", with: "")
            let imageUrl = "icon_" + realName
            let returnDic = ["imageUrl":imageUrl,
                             "type":urlType.local,
                             "url":dic + "/" + fileName,
                             "Name":realName] as [String : Any]
            returnArray.append(returnDic)
        }
        return returnArray
    }
    
    static func pathsWithDic(dic:String) -> Array<String>? {
        let fileManager = FileManager()
        var paths : Array<String>? = nil
        do {
            try paths = fileManager.subpathsOfDirectory(atPath: dic)
        } catch  {
        }
        return paths;
    }
    
}
