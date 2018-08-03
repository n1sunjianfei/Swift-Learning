//
//  JFTabbarViewController.swift
//  Swift_1Demo
//
//  Created by ever-mac on 2018/8/3.
//  Copyright © 2018年 sjf. All rights reserved.
//

import UIKit

class JFTabbarViewController: UIViewController {

    var viewControllers:[UIViewController]!
    var currentViewController:UIViewController?
    var contentView:UIView!
    var tabbarView:UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        // Do any additional setup after loading the view.

        self.contentView = UIView.init()
        self.contentView.backgroundColor = UIColor.green

        self.tabbarView = UIView.init()
        self.tabbarView.backgroundColor = UIColor.gray;
        
        self.view.addSubview(self.contentView)
        self.view.addSubview(self.tabbarView)
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.tabbarView.translatesAutoresizingMaskIntoConstraints = false
        
        for index in 0...viewControllers.count-1 {
            let vc = viewControllers[index]
//            vc.view.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height-44)
            let button = UIButton.init(type: UIButtonType.custom) as UIButton
            button.frame = CGRect.init(x: (20+60)*index, y: 40, width: 60, height: 40)
            button.titleLabel?.text = NSString.init(format: "%d", index) as String
            button.setTitle(title, for: UIControlState.normal)
            button.setTitleColor(UIColor.white, for: UIControlState.normal)
            button.backgroundColor = UIColor.gray;
            button.tag = index
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 5
            button.addTarget(self, action:#selector(clickIndex(sender:)), for: UIControlEvents.touchUpInside)

//            self.view.addSubview(button)
            self.addChildViewController(vc)

        }
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let views = self.ConstraintDictionWithArray(nameArray: [self.contentView,self.tabbarView,self.view], object: self);
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[contentView]|", options: NSLayoutFormatOptions.alignAllLeft, metrics: nil, views: views))
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tabbarView]|", options: NSLayoutFormatOptions.alignAllLeft, metrics: nil, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[contentView][tabbarView(44)]|", options: NSLayoutFormatOptions.alignAllLeft, metrics: nil, views: views))
        let view = self.childViewControllers[0].view
        view?.frame = self.contentView.bounds
        
        self.currentViewController = self.childViewControllers[0];
        self.currentViewController?.view.frame = self.contentView.bounds;
        self.contentView.addSubview(view!)

//        self.contentView.sendSubview(toBack:view!)
        self.currentViewController?.didMove(toParentViewController: self)
    }
    @objc func clickIndex(sender:UIButton) {
        self.transition(from: self.currentViewController!, to: self.viewControllers[sender.tag], duration: 0.3, options: UIViewAnimationOptions.autoreverse, animations: {

        }) { (finished:Bool) in
            if (finished){

                self.currentViewController = self.childViewControllers[sender.tag];
                let view = self.childViewControllers[sender.tag].view
                view?.frame = self.contentView.bounds
                self.contentView.addSubview(view!)
                self.contentView.sendSubview(toBack:view!)
            }
        }
        print(NSString.init(format: "click--%d", sender.tag))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func ConstraintDictionWithArray(nameArray:Array<UIView>,object:AnyObject) -> Dictionary<String,AnyObject> {
        
        var dict:Dictionary<String,AnyObject> = [:]
        
        var count:UInt32 = 0
        
        let ivars = class_copyIvarList(object.classForCoder, &count)
        
        for i in 0...Int(count) {
            
            let obj = object_getIvar(object, ivars![i])
            
            if let temp = obj as? UIView {
                
                if nameArray.contains(temp){
                    
                    let name = String.init(cString: ivar_getName(ivars![i])!)
                    
                    dict[name] = temp
                }
                
            }
        }
        free(ivars)
        
        return dict
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
