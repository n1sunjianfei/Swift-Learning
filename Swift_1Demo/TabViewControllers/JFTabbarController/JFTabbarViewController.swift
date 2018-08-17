//
//  JFTabbarViewController.swift
//  Swift_1Demo
//
//  Created by ever-mac on 2018/8/3.
//  Copyright © 2018年 sjf. All rights reserved.
//

import UIKit

let tabbarHeight:CGFloat = 49.0
let tabbarHeight_iphoneX:CGFloat = 83.0

enum TestEnum {
    case TestEnum_01
    case TestEnum_02
    case TestEnum_03
    case TestEnum_04
}


class JFTabbarViewController: JFBaseViewController {

    
    var viewControllers:[UIViewController]!
    var currentViewController:AnyObject?
    var contentView:UIView!
    var lineView:UIView!
    var tabBar:UIView!
    var selectedIndex:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;

        self.selectedIndex = 0
        self.setupBaseUI()
        let itemWidth = UIScreen.main.bounds.width/CGFloat.init(viewControllers.count);
        for index in 0...viewControllers.count-1 {
            let vcOut = viewControllers[index]
            var vc = vcOut
            if vcOut is UINavigationController{
                vc = (vcOut as! UINavigationController).topViewController!
            }
//            vcOut.jf_tabBarController = self;
            vc.jf_tabBarController = self;
            let button = JFTabbarButton.init(frame: CGRect.init(x: CGFloat.init(index)*itemWidth, y: 0, width: itemWidth, height: tabbarHeight))
            button.title = vc.jf_tabbarItem.title
            button.image = vc.jf_tabbarItem.image
            button.selectedImage = vc.jf_tabbarItem.selectedImage
            button.textColor = vc.jf_tabbarItem.textColor
            button.selectedTextColor = vc.jf_tabbarItem.textSelectedColor

            button.tag = index
            button.action = #selector(clickIndex(sender:))
            if index==self.selectedIndex {button.selected = true}
            self.tabBar.addSubview(button)
            self.addChildViewController(vcOut)

        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.currentViewController == nil {
            self.currentViewController = self.childViewControllers[0];
            self.addContentView()
        }
    }
    
    @objc override func orientationChanged(notification: Notification) {
        super.orientationChanged(notification: notification)
        if self.currentViewController != nil {
            //重新设置contentView的frame
            self.addContentView()
            let itemWidth = UIScreen.main.bounds.width/CGFloat.init(viewControllers.count)
            //重新设置tabbar按钮frame
            for button:UIView in self.tabBar.subviews{
                if button .isKind(of: JFTabbarButton.self) {
                    var frame = button.frame
                    frame.size.width = itemWidth
                    frame.origin.x = CGFloat.init(button.tag)*itemWidth
                    button.frame = frame
                    print(frame)
                }
            }
        }
    }
    
    func setupBaseUI(){
        self.contentView = UIView.init()
        self.lineView = UIView.init()
        self.lineView.backgroundColor = UIColor.lightGray;
        self.tabBar = UIView.init()
        self.tabBar.backgroundColor = UIColor.white
        self.tabBar.addSubview(self.lineView)

        self.view.addSubview(self.contentView)
        self.view.addSubview(self.tabBar)
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.lineView.translatesAutoresizingMaskIntoConstraints = false
        self.tabBar.translatesAutoresizingMaskIntoConstraints = false
        let views = self.ConstraintDictionWithArray(nameArray: [self.contentView,self.lineView,self.tabBar,self.view], object: self);
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[contentView]|", options: NSLayoutFormatOptions.alignAllLeft, metrics: nil, views: views))
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tabBar]|", options: NSLayoutFormatOptions.alignAllLeft, metrics: nil, views: views))
       
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[contentView][tabBar(tabbarHeight)]|", options: NSLayoutFormatOptions.alignAllLeft, metrics: ["tabbarHeight":(self.isIphoneX() ? tabbarHeight_iphoneX : tabbarHeight)], views: views))
       
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options: NSLayoutFormatOptions.alignAllLeft, metrics: nil, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(0.5)]", options: NSLayoutFormatOptions.alignAllLeft, metrics: nil, views: views))
    }
    
    @objc func clickIndex(sender:UIButton!) {
        if self.selectedIndex==sender.tag {
            return;
        }
        self.selectedIndex = sender.tag;
        for view:UIView in self.tabBar.subviews {
            if(view is JFTabbarButton){
                let tmpTabBtn = view  as? JFTabbarButton
                tmpTabBtn?.selected = false
                if (tmpTabBtn?.subviews.contains(sender))!{
                    tmpTabBtn?.selected = true

                }
            }
            
        }
        self.currentViewController = self.childViewControllers[sender.tag];
        self.addContentView()
        
//        self.transition(from: self.currentViewController! as! UIViewController, to: self.viewControllers[sender.tag], duration: 0.1, options: UIViewAnimationOptions.preferredFramesPerSecond30, animations: {
//
//        }) { (finished:Bool) in
//            if (finished){
    }
    func addContentView(){
        self.contentView.subviews.forEach { (subview:UIView) in
            subview.removeFromSuperview()
        }
        let view = self.currentViewController?.view
        view?.frame = self.contentView.bounds
        self.contentView.addSubview(view!)
        
        self.contentView.sendSubview(toBack:view!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK: 相当于OC中的NSBinding
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
    //MARK:isIphoneX
    func isIphoneX() -> Bool {
        if UIScreen.main.bounds.height == 812 {
            return true
        }
        return false
    }

}

class JFTabbarItem: NSObject {
    
    var title : String?
    var image : UIImage?
    var selectedImage : UIImage?
    var textColor:UIColor?
    var textSelectedColor:UIColor?

    override init() {
        super.init()
        self.setupBase()
    }
    func setupBase(){
        self.textColor = UIColor.gray
        self.textSelectedColor = UIColor.blue
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class JFTabbarButton: UIView {
    private(set) var titleLabel:UILabel?
    private(set) var imageView:UIImageView?
    private(set) var button:UIButton?
    private(set) var _action:Selector?
    private(set) var _title:String?
    private(set) var _image:UIImage?

    //自定义属性get，set
    var image : UIImage?{
        get{
            return _image
        }
        set(newValue){
            _image = newValue
            self.imageView?.image = _image
        }
    }
    var selectedImage:UIImage?
    var textColor : UIColor?
    var selectedTextColor:UIColor?
    var title :String?{
        get{
            return _title
        }
        set(newValue){
            _title = newValue
            self.titleLabel?.text = _title
        }
    }
    var action:Selector?{
       
        get{
            return _action
        }
        set(newAction){
            _action = newAction
            self.button?.addTarget(nil, action:_action!, for: UIControlEvents.touchUpInside)
        }
    }
    private(set) var _selected : Bool?
    var selected:Bool?{
        get{
            return _selected
        }
        set(newValue){
            _selected = newValue
            if self.selected! {
                self.imageView?.image = (self.selectedImage != nil) ? self.selectedImage:self.image;
                self.titleLabel?.textColor = (self.selectedTextColor != nil) ?self.selectedTextColor :UIColor.blue;
            }else{
                self.imageView?.image = self.image;
                self.titleLabel?.textColor = self.textColor;
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.imageView = UIImageView.init()
        self.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        self.titleLabel = UILabel.init()
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.titleLabel?.textAlignment = NSTextAlignment.center
        self.button = UIButton.init(type: UIButtonType.custom)
        self.addSubview(self.titleLabel!)
        self.addSubview(self.imageView!)
        self.addSubview(self.button!)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let height = self.bounds.size.height
        let width = self.bounds.size.width

        self.imageView?.frame = CGRect.init(x: height/2-10, y: 10, width: 20, height: 20)
        var imageViewCenter = self.imageView?.center
        imageViewCenter?.x = width/2
        self.imageView?.center = imageViewCenter!
        self.titleLabel?.frame = CGRect.init(x: 0, y: 35, width: height, height: 14)
        var titleLabelCenter = self.titleLabel?.center
        titleLabelCenter?.x = width/2
        self.titleLabel?.center = titleLabelCenter!
        self.button?.frame = CGRect.init(x: 0, y: 0, width: width, height: height)
    }
    //重写父类属性get，set
    override var tag:Int{
        
        get{
           return super.tag
        }
        set(newValue){
            super.tag = newValue
            self.button?.tag = newValue
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
