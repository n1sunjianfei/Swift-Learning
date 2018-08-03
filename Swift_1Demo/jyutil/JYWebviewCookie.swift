//
//  JYWebviewCookie.swift
//  Swift_1Demo
//
//  Created by JianF.Sun on 2017/10/16.
//  Copyright © 2017年 sjf. All rights reserved.
//

import UIKit
let LOGIN_ACCOUNT_COOKIE = "rememberMe"

class JYWebviewCookie: NSObject {

    //获取用户登录cookie
    class func getAccountCookie(domain:NSString) ->HTTPCookie?{
        let cookies = HTTPCookieStorage.shared.cookies
        
        for cookie:HTTPCookie in cookies!{
            if cookie.isKind(of: HTTPCookie.classForCoder())&&cookie.domain==domain as String{
                if cookie.name == LOGIN_ACCOUNT_COOKIE{
                    return cookie
                }
            }
        }
        return nil
    }
    //保存当前登录cookie
    class func saveLoginCookie(domain:String){

        let accountCookie = JYWebviewCookie().writeCookieToLocal(domain: domain)
        if accountCookie==nil {
            return
        }
        let cookieData = NSKeyedArchiver.archivedData(withRootObject: accountCookie ?? "")
    
        UserDefaults.standard.set(cookieData, forKey: LOGIN_ACCOUNT_COOKIE)
    }
    //删除cookie
    class func deleteCookie(domain:String){
        let myCookies = HTTPCookieStorage.shared.cookies
    
        for cookie in myCookies!{
        
            if cookie.domain==domain{
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }
    }
    //重新保存cookie
    class func restoreCookieIfNeeded(){
        let cookieData = JYWebviewCookie().getLocalCookie()
        if cookieData==nil{
            return
        }
        let accountCookie = NSKeyedUnarchiver.unarchiveObject(with: cookieData! as Data)
        HTTPCookieStorage.shared.setCookie(accountCookie as! HTTPCookie)
    }
    //删除所有cookie
    class func deleteAllCookie(){
    
        let cookies = HTTPCookieStorage.shared.cookies
        for cookie:HTTPCookie in cookies!{
            HTTPCookieStorage.shared.deleteCookie(cookie)
        }
    }
 
    //删除cookie文件
    class func deleteCookieFile(){
        let bundleId = Bundle.main.infoDictionary!["CFBundleIdentifier"]
        //删除沙盒自动生成的Cookies.binarycookies文件
        let path = NSHomeDirectory() as NSString
        let com = NSString.init(format: "/Library/Cookies/%@.binarycookies",bundleId as! CVarArg)
        let filePath = path.appendingPathComponent(com as String)
        let filemanager = FileManager.default
        try! filemanager.removeItem(atPath: filePath)
        
//        do{
//            try filemanager.removeItem(atPath: filePath)
//        }catch let error{
//
//        }
    
    }
    func writeCookieToLocal(domain:String) -> HTTPCookie? {
        
        // 判断是否保存当前cookie
        let isExist = self.isExistLocalCookie()
        let remoteCookie = JYWebviewCookie.getAccountCookie(domain: domain as NSString)
        // 如果没有返回当前网页cookie
        if !isExist {
            return remoteCookie
        }
        // 获取本地cookie
        let cookieData = self.getLocalCookie()! as Data
        let localCookie = NSKeyedUnarchiver.unarchiveObject(with: cookieData) as! HTTPCookie
        let localCookieValue = localCookie.value
        
        // 获取网页cookie值
        let remoteCookieValue = remoteCookie?.value
        // 如果本地和网页的cookie不相等,则写入本地
        if !(remoteCookieValue==localCookieValue) {
            return remoteCookie
        }
        return nil
    }
 
    func getLocalCookie() ->NSData?{
        let userDefault = UserDefaults.standard
        let cookieData = userDefault.object(forKey: LOGIN_ACCOUNT_COOKIE) as! NSData
        if (cookieData.length==0){
            return nil
        }else{
            return cookieData
        }
    }
    func isExistLocalCookie() ->Bool{
        let cookieData = self.getLocalCookie()
        if (cookieData != nil) {
            return true
        }else{
            return false
        }
    }
}
