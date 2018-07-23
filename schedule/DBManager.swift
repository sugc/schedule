//
//  DBManager.swift
//  schedule
//
//  Created by sugc on 2018/6/24.
//  Copyright © 2018年 魔方. All rights reserved.
//

import Foundation
import FMDB

let dataBasePath = NSHomeDirectory().appending("/Documents/myDB")
let singleton : DBManager = DBManager.init()

class DBManager  {
    var dbHandler : FMDatabase!
    static func singleTon()->DBManager! {
        return singleton
    }
    
    init() {
        dbHandler = FMDatabase.init(path: dataBasePath)
        dbHandler.open()
        dbHandler.executeStatements("CREATE TABLE IF NOT EXISTS 'EVENT' (Title String, CreateTime INTEGER, RemindTime INTEGER)")
    }
    
    func saveEventToDB(eventModel:EventModel!) {
        //保存到数据库
        let quryStr = "SElECT * FROM EVENT where Title = ? and RemindTime = ?"
        do {
            let result = try dbHandler.executeQuery(quryStr, values: [eventModel.eventTitle, eventModel.remindDate])
            if  result.next() {
                //update, 更新原有的值
            }else {
                //insert 插入新的值
                self.insertEvent(eventModel: eventModel)
            }
        }catch {
            print("qury something wrong")
        }
    }
    
    //
    func insertEvent(eventModel:EventModel!) {
        let sql = "INSERT INTO EVENT VALUES(?,?,?)"
         dbHandler.executeUpdate(sql, withArgumentsIn: [eventModel.eventTitle, eventModel.createDate, eventModel.remindDate])
    }
    
    func deleteEvent(eventModel:EventModel!)  {
        
    }
    
    func allEvent() -> Array<EventModel>? {
        let quryStr = "select * from EVENT ORDER BY CreateTime"
        var array : Array<EventModel> = Array()
        do {
            let result = try dbHandler.executeQuery(quryStr, values: nil)
            while result.next() {
                var eventModel = EventModel()
                eventModel.eventTitle = result.object(forColumn: "Title") as! String
                eventModel.createDate = result.object(forColumn: "CreateTime") as! TimeInterval
                eventModel.remindDate = result.object(forColumn: "RemindTime") as! TimeInterval
                array.append(eventModel)
            }
        }catch {
            print("qury something wrong")
        }
        return array
    }
}
