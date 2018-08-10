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
    var jf_tabBarController:JFTabbarViewController?{
        get{
            let tabbar = objc_getAssociatedObject(self, &jf_tabBarControllerKey)
            return (tabbar as! JFTabbarViewController?);
        }
        set(tabbar){
            objc_setAssociatedObject(self, &jf_tabBarControllerKey, tabbar, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
//    var jf_hidesBottomBarWhenPushed:Bool!{
//        get{
//            var isHideTabbar = objc_getAssociatedObject(self, &jf_hidesBottomBarWhenPushedKey)
//            if isHideTabbar==nil {
//                isHideTabbar = false
//            }
//            return isHideTabbar as! Bool;
//        }
//        set(newValue){
//
//            self.jf_tabBarController?.tabBar.isHidden = newValue;
//            objc_setAssociatedObject(self, &jf_hidesBottomBarWhenPushedKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
//        }
//    }
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
