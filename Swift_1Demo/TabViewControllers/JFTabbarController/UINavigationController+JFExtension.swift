//
//  BaseNavigationController.swift
//  Swift_1Demo
//
//  Created by ever-mac on 2018/8/10.
//  Copyright © 2018年 sjf. All rights reserved.
//

import UIKit

extension UINavigationController {

     public class func initializeNavMethod() {
        let originalSelector = #selector(UINavigationController.pushViewController(_:animated:))
        let swizzledSelector = #selector(UINavigationController.transfer_jfTabbarController(viewController:animated:))
        let originalMethod = class_getInstanceMethod(self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
        //在进行 Swizzling 的时候,需要用 class_addMethod 先进行判断一下原有类中是否有要替换方法的实现
        let didAddMethod: Bool = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
        //如果 class_addMethod 返回 yes,说明当前类中没有要替换方法的实现,所以需要在父类中查找,这时候就用到 method_getImplemetation 去获取 class_getInstanceMethod 里面的方法实现,然后再进行 class_replaceMethod 来实现 Swizzing
        if didAddMethod {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
            
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
            
        }
        
    }
    @objc func transfer_jfTabbarController(viewController:UIViewController,animated:Bool) {
        print("传递自定义标签栏")

        //先传递标签栏，再进行push
        viewController.jf_tabBarController = self.topViewController?.jf_tabBarController;

        self.transfer_jfTabbarController(viewController: viewController, animated: animated)
        
    }
}
