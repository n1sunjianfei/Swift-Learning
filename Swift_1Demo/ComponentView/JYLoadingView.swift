//
//  JYLoadingView.swift
//  Swift_1Demo
//
//  Created by JianF.Sun on 17/10/13.
//  Copyright © 2017年 sjf. All rights reserved.
//

import UIKit

class DottedView: UIView {

    var view1:UIView!
    var view2:UIView!
    var view3:UIView!
    var isAnimation:Bool!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    func setupSubviews(){
        let sepWidth = self.bounds.size.width/6
        let midY = self.bounds.size.height/2
        let color = UIColor.blue
        self.view1 = self.addDoctedView(bounds: CGRect.init(x: 0, y: 0, width: 30, height: 30), center: CGPoint.init(x: sepWidth*1, y: midY), bgColor: color)
        self.view2 = self.addDoctedView(bounds: CGRect.init(x: 0, y: 0, width: 30, height: 30), center: CGPoint.init(x: sepWidth*3, y: midY), bgColor: color)
        self.view3 = self.addDoctedView(bounds: CGRect.init(x: 0, y: 0, width: 30, height: 30), center: CGPoint.init(x: sepWidth*5, y: midY), bgColor: color)
        self.addSubview(self.view1)
        self.addSubview(self.view2)
        self.addSubview(self.view3)
    }
    func addDoctedView(bounds:CGRect,center:CGPoint,bgColor:UIColor) ->UIView{
        let view = UIView.init(frame: bounds)
        view.center = center
        view.layer.masksToBounds = true
        view.layer.cornerRadius = bounds.size.width/2
        view.backgroundColor = bgColor
        return view
    }
    
    func startAnimation(){
        repeat {
            
        } while(isAnimation)
    }
    func stopAnimation(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
}

class JYLoadingView: NSObject {

    class func showLoadingview(){
        DispatchQueue.main.async {
            let window = UIApplication.shared.keyWindow
            let container = UIView.init()
            container.frame = (window?.bounds)!
            container.backgroundColor = UIColor.gray
            container.tag = 10001010
            window?.addSubview(container)
            
            //
            let dottedView = DottedView.init(frame: CGRect.init(x: 0, y: 0, width: 150, height: 70))
            dottedView.center = container.center
            dottedView.tag = 10001020
            container.addSubview(dottedView)
            dottedView.startAnimation()
            
            let delay = DispatchQueue.init(label: "loading.delay")
            delay.asyncAfter(deadline: DispatchTime.now()+DispatchTimeInterval.seconds(2), execute: {
                DispatchQueue.main.async {
                    self.removeLoadingView()
                }
            })
        }
        
    }
    
    class func removeLoadingView(){
        let window = UIApplication.shared.keyWindow
        let view = window?.viewWithTag(10001010)
        let dotted = view?.viewWithTag(10001020) as! DottedView
        
        view?.removeFromSuperview()
        
        dotted.stopAnimation();
        
        
    }
}
