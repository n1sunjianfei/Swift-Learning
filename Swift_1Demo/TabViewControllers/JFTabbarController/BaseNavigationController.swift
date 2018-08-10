//
//  BaseNavigationController.swift
//  Swift_1Demo
//
//  Created by ever-mac on 2018/8/10.
//  Copyright © 2018年 sjf. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count >= 1{
            viewController.hidesBottomBarWhenPushed = true
            
            viewController.jf_tabBarController?.tabBar.isHidden = true;
//            viewController.jf_hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
}
