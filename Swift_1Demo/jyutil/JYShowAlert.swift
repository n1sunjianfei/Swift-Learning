//
//  JYShowAlert.swift
//  ApplicationSwift
//
//  Created by JianF.Sun on 17/10/13.
//  Copyright © 2017 liyaoyao. All rights reserved.
//

import UIKit

typealias AlertHandler = (_ action:UIAlertAction) -> ()

class JYShowAlert: NSObject {
    // 提示框,一个事件
    class func showAlert(alertTitle:String,message:String,actionTitle:String,handler:@escaping AlertHandler){
        let alertVC = UIAlertController.init(title:alertTitle, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let confirm = UIAlertAction.init(title: actionTitle, style: UIAlertActionStyle.cancel, handler: handler)
        alertVC.addAction(confirm)
        let rootVC = UIApplication.shared.keyWindow?.rootViewController
        if ((rootVC?.presentedViewController) != nil){
            rootVC?.presentedViewController?.present(alertVC, animated: true, completion: nil)
        }else{
            rootVC?.present(alertVC, animated: true, completion: nil)
        }

    }
    //提示框,一个事件,无alert title
    class func showAlert(message:String,actionTitle:String,handler:@escaping AlertHandler){
        self.showAlert(alertTitle: "", message: message, actionTitle: actionTitle, handler: handler)
    }
    //提示框多个action
    class func showAlert(alertTitle:String ,message:String ,actions:[UIAlertAction]){
        let alertVC = UIAlertController.init(title:alertTitle, message: message, preferredStyle: UIAlertControllerStyle.alert)
        for alertAction in actions{
            alertVC.addAction(alertAction)
        }
        DispatchQueue.main.async {
            let rootVC = UIApplication.shared.keyWindow?.rootViewController
            if ((rootVC?.presentedViewController) != nil){
                rootVC?.presentedViewController?.present(alertVC, animated: true, completion: nil)
            }else{
                rootVC?.present(alertVC, animated: true, completion: nil)
            }
        }
        
    }

    //提示框，无事件
    class func showAlert(alertTile:String,message:String,actionTitle:String){
        let confirm = UIAlertAction.init(title: actionTitle, style: UIAlertActionStyle.default) { (action:UIAlertAction) in
        
        }

        self.showAlert(alertTitle: alertTile, message: message, actions: [confirm])
        
    }
    
}
