//
//  JYDateUtil.swift
//  Swift_1Demo
//
//  Created by JianF.Sun on 2017/10/16.
//  Copyright © 2017年 sjf. All rights reserved.
//

import UIKit

let PCDateYYYY = "yyyy"

let PCDateMM = "MM"

let PCDateYYYYMM = "yyyy-MM"

let PCDateYYYYMMDD = "yyyy-MM-dd"

let PCDateMMDD = "MM-dd"
class JYDateUtil: NSObject {

    
    /// 将指定格式的日期字符串转化为日期
    ///
    /// - Parameters:
    ///   - string: 日期字符串
    ///   - formatter: 日期样式
    /// - Returns: 日期
    class func getNSdate(string:String,formatter:String) -> NSDate{
       
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        let date = dateFormatter.date(from: string)
        return date! as NSDate
    }
    
    /// 将指定日期转换成格式化日期字符串
    ///
    /// - Parameters:
    ///   - formatterString: 格式
    ///   - date: 日期
    /// - Returns: 格式化日期字符串
    class func getDateString(formatterString:String,date:NSDate) ->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatterString
        let dateStr = dateFormatter.string(from: date as Date)
        return dateStr
    }
    
    /// 从日期数据流中获取年份
    ///
    /// - Parameter date: 日期数据流
    /// - Returns: 年份
    class func getYear(date:NSDate) ->NSInteger{
        let dateFormtter = DateFormatter()
        dateFormtter.dateFormat = PCDateYYYY
        let ym = dateFormtter.string(from: date as Date) as NSString
        return ym.integerValue
    }
    
    /// 从日期数据流中获取月份
    ///
    /// - Parameter date: 日起数据流
    /// - Returns: 月份
    class func getMonth(date:NSDate) ->NSInteger{
        let dateFormtter = DateFormatter()
        dateFormtter.dateFormat = PCDateMM
        let ym = dateFormtter.string(from: date as Date) as NSString
        return ym.integerValue
    }
    
    /// 比较当前日期和其他日期
    ///
    /// - Parameters:
    ///   - dateString: 要比较的日期格式字符串
    ///   - formatter: 日期格式字符串
    ///   - timeInterval: 当期日期和需要比较其他的差值,单位：秒
    /// - Returns: 当期时间比其日期大 time 秒，返回YES，否则返回 NO
    class func compareCurrentDateWithOtherDate(dateString:String,formatter:String,timeInterval:TimeInterval) ->Bool{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        let date = dateFormatter.date(from: dateString)
        let distance = NSDate().timeIntervalSince(date!)
        
        if distance>timeInterval{
            return true
        }
        return false
    }
    
     /// 比较当前日期和其他日期,日期格式：yyyyMMdd HH:mm:ss
     ///
     /// - Parameters:
     ///   - dateString: 要比较的日期格式字符串
     ///   - timeInterval: 当期日期和需要比较其他的差值,单位：秒
     /// - Returns: 当期时间比其日期大 time 秒，返回YES，否则返回 NO
     class func compareCurrentDateWithOtherDate(dateString:String,timeInterval:TimeInterval) ->Bool{
        return self.compareCurrentDateWithOtherDate(dateString: dateString, formatter: "yyyyMMdd HH:mm:ss", timeInterval: timeInterval)
    }
}
