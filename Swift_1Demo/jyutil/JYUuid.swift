//
//  JYUuid.swift
//  Swift_1Demo
//
//  Created by JianF.Sun on 2017/10/16.
//  Copyright © 2017年 sjf. All rights reserved.
//

import UIKit

class JYUuid: NSObject {

    class func getUuid() ->String{

        let bundleName = Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
        var uuid = SAMKeychain.password(forService: "uuid", account: bundleName)
        if uuid==nil||(uuid?.isEmpty)!{
            uuid = NSUUID().uuidString
            SAMKeychain.setPassword(uuid!, forService: "uuid", account: bundleName)
        }
        return uuid!
    }
}
