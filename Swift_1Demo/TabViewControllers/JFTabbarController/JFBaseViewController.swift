//
//  JFBaseViewController.swift
//  Swift_1Demo
//
//  Created by ever-mac on 2018/8/17.
//  Copyright © 2018年 sjf. All rights reserved.
//

import UIKit

/// 处理横屏问题的控制器
class JFBaseViewController: UIViewController {

    private(set) var notification:Notification?
    override func viewDidLoad() {
        super.viewDidLoad()
 
        NotificationCenter.default.addObserver(self, selector: #selector(orientationChanged(notification:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.notification != nil {
            self.orientationChanged(notification: self.notification!)
        }
    }
    @objc func orientationChanged(notification: Notification) {
        self.notification = notification
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
