//
//  UIViewController+JFExtention.swift
//  Swift_1Demo
//
//  Created by ever-mac on 2018/8/6.
//  Copyright © 2018年 sjf. All rights reserved.
//

import Foundation
private var jf_tabBarControllerKey:String = "jf_tabBarControllerKey"
private var jf_tabbarItemKey:String = "jf_tabbarItemKey"
private var jf_hidesBottomBarWhenPushedKey:String = "jf_hidesBottomBarWhenPushedKey"

extension UIViewController{
    
    public class func initializeMethod() {
        let originalSelector = #selector(UIViewController.viewWillAppear(_:))
        let swizzledSelector = #selector(UIViewController.dealWithJF_Tabbar(animated:))
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
    @objc func dealWithJF_Tabbar(animated: Bool) {
       
        self.dealWithJF_Tabbar(animated: animated)
         print("处理自定义tabbar隐藏问题")
        self.jf_tabBarController?.tabBar.isHidden = self.jf_hidesBottomBarWhenPushed;
    }
    
    var jf_tabBarController:JFTabbarViewController?{
        get{
            let tabbar = objc_getAssociatedObject(self, &jf_tabBarControllerKey)
            return (tabbar as! JFTabbarViewController?);
        }
        set(tabbar){
            objc_setAssociatedObject(self, &jf_tabBarControllerKey, tabbar, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    var jf_hidesBottomBarWhenPushed:Bool!{
        get{
            var isHideTabbar = objc_getAssociatedObject(self, &jf_hidesBottomBarWhenPushedKey)
            if isHideTabbar==nil {
                isHideTabbar = false
            }
            return isHideTabbar as! Bool;
        }
        set(newValue){

            objc_setAssociatedObject(self, &jf_hidesBottomBarWhenPushedKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    var jf_tabbarItem:JFTabbarItem!{
        get{
            var tabbar = objc_getAssociatedObject(self, &jf_tabbarItemKey)
            if tabbar==nil {
                tabbar = JFTabbarItem.init()
                self.jf_tabbarItem = tabbar as! JFTabbarItem
            }
            return tabbar as! JFTabbarItem;
        }
        set(tabbarItem){
            objc_setAssociatedObject(self, &jf_tabbarItemKey, tabbarItem, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
}
