//
//  JYToast.swift
//  Swift_1Demo
//
//  Created by JianF.Sun on 17/10/13.
//  Copyright © 2017年 sjf. All rights reserved.
//

import UIKit

class JYToast: NSObject {
    //类方法
    class func showInMidWindow(title:String) {
        
        DispatchQueue.main.async {
            let font = UIFont.systemFont(ofSize: 17)
            let maxwidth = 240.0
            //计算字符串尺寸
            var frame = (title as NSString).boundingRect(with: CGSize.init(width: maxwidth, height: Double(MAXFLOAT)), options:NSStringDrawingOptions.usesLineFragmentOrigin , attributes: [NSAttributedStringKey.font:font], context: nil)
            var newframe = frame
            
            newframe.size.width+=20
            newframe.size.height+=20
            
            //contentView
            let contentview = UIView()
            contentview.frame = newframe
            contentview.center = CGPoint.init(x: WIDTH/2, y: HEIGHT/2)
            contentview.backgroundColor = UIColor.black
            contentview.alpha = 0.8
            
            //label
            let label = UILabel()
            frame.origin.x+=10
            frame.origin.y+=10
            label.frame = frame
            label.backgroundColor = UIColor.clear
            label.textColor = UIColor.white
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.text = title
            label.font = font
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 5
            
            contentview.addSubview(label)
            
            let window = UIApplication.shared.keyWindow
            window?.addSubview(contentview)
            
            
            let dispatch_delay = DispatchQueue.init(label: "toast.delay")
            dispatch_delay.asyncAfter(deadline: DispatchTime.now()+DispatchTimeInterval.seconds(Int(1.5))) {
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.5, animations: {
                        contentview.alpha = 0
                    }) { ( isFinish:Bool) in
                        contentview.removeFromSuperview()
                    }
                }
            }
        }
    }
}
