//
//  UIBaseViewController.swift
//  Swift_1Demo
//
//  Created by JianF.Sun on 17/10/11.
//  Copyright © 2017 sjf. All rights reserved.
//

import UIKit

let WIDTH = UIScreen.main.bounds.size.width

let HEIGHT = UIScreen.main.bounds.size.height

class UIBaseViewController: JFBaseViewController,UITableViewDataSource,UITableViewDelegate,testProtocol{

    var tableView: UITableView!
    
    //lazy
    lazy var datasource: [String] = {
    
        var tmpdatasource = ["UIButton","UILabel","UIView","UIImageView","UITextField","UIScrollView","UITableView(UIAlertViewController)","UIButton","UILabel","UIView","UIImageView","UITextField","UIScrollView","UITableView(UIAlertViewController)"]
//        print(tmpdatasource[1])
        return (tmpdatasource as NSArray) as! [NSString] as [String]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.view.autoresizesSubviews = false
        print(JYUuid.getUuid())
        self.title = "UI基础"
        self.tableView = UITableView(frame:CGRect.zero ,style: UITableViewStyle.grouped)
        if (self.jf_tabBarController != nil) {
            let frame = self.jf_tabBarController?.contentView.bounds
            self.view.frame = frame!;
        }else{
            print(self.tabBarController?.tabBar.bounds.size.height ?? "mei")
        }
       
        self.tableView.frame = self.view.bounds
//        self.tableView.backgroundColor = UIColor.red
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
       
        
    }

    @objc override func orientationChanged(notification: Notification) {
        super.orientationChanged(notification: notification)
        let queue = DispatchQueue(label: "com.test.backtomain")
        queue.async{
            DispatchQueue.main.async {
                self.tableView.frame = self.view.bounds
            }
        }

    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        print(self.tabBarController!.tabBar.bounds.size.height)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func testAdd( a:Int, b:Int) -> Int{
        print(a+b)
        return a+b
    }
    //MARK:-delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60;
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.count;
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        cell.textLabel?.text = self.datasource[indexPath.row]
        
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true;
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        
        return UITableViewCellEditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print("delete suc")
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            self.addUIbutton(title: "点击隐藏按钮")
            break
        case 1:
            self.addLabel(title: "两秒后这个label自动隐藏")
            break
        case 2:
            self.addView()
            break
        case 3:
            self.addImageView()
            break
        case 4:
            let txtVC = TextFieldViewController()
            //delegate step 4:
            txtVC.delegate = self
            self.navigationController!.pushViewController(txtVC, animated: true)
            
             break
        case 5:
//            self.jf_tabBarController?.tabBar.isHidden = true;
            self.navigationController?.pushViewController(ScrollViewViewController(), animated: true)
            break
        case 6:
            self.showAlert()
            
            break
        default:
            
            break
        }
    }
    
    
    //MARK:- Create Base UI 
    
    //UIButton
    func addUIbutton(title:String){

        let button = UIButton.init(type: UIButtonType.custom) as UIButton
        button.frame = CGRect.init(x: 0, y: 0, width: 200, height: 40)
        button.center = self.view.center;
        button.titleLabel?.text = title
        button.setTitle(title, for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.backgroundColor = UIColor.gray;
        button.tag = 1000
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.addTarget(self, action:#selector(remove(view:)), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(button)
        
    }
    
    //UILabel
    
    //MARK: 懒加载创建label
    lazy var lazyLabel: UILabel = self.addLabel_d(title: "");
    func addLabel_d(title:String) -> UILabel {
        let label = UILabel(frame: CGRect.init(x: 0, y: 0, width: 200, height: 40))
        label.center = self.view.center
        label.backgroundColor = UIColor.gray
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.text = title
        label.font = UIFont.systemFont(ofSize: 17)
        return label;
    }
    //MARK: UILabel
    func addLabel(title:String) {
        let label = UILabel(frame: CGRect.init(x: 0, y: 0, width: 200, height: 40))
        label.center = self.view.center
        label.backgroundColor = UIColor.gray
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.text = title
        label.font = UIFont.systemFont(ofSize: 17)
       
        self.view.addSubview(label)
        
        let queue = DispatchQueue(label:"remove.label")
        queue.asyncAfter(deadline: .now()+DispatchTimeInterval.seconds(1)) {
            DispatchQueue.main.sync {
                label.removeFromSuperview()
            }
        }
    }
    //MARK: UIView
    func addView() {
        let view = UIView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 80))
        view.center = self.view.center
        view.backgroundColor = UIColor.gray
        
        self.view.addSubview(view)
        
        let queue = DispatchQueue(label:"remove.view")
        queue.asyncAfter(deadline: .now()+DispatchTimeInterval.seconds(1)) {
            DispatchQueue.main.sync {
                view.removeFromSuperview()
            }
        }
    }
    //MARK: UIImageView
    func addImageView() {
        let imageView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        imageView.center = self.view.center
        imageView.backgroundColor = UIColor.gray
        imageView.image = UIImage(named: "1")
        imageView.animationImages = ([
            
            UIImage(named: "1"),
            UIImage(named: "2"),
            UIImage(named: "3")
            ] as! [UIImage])
        self.view.addSubview(imageView)
        imageView.animationDuration = 1
        imageView.startAnimating()

        
        let queue = DispatchQueue(label:"remove.imageView")
        queue.asyncAfter(deadline: .now()+DispatchTimeInterval.seconds(3)) {
            DispatchQueue.main.sync {
                imageView.stopAnimating()
                imageView.removeFromSuperview()
            }
        }
    }
    //MARK: UIAlertController
    func showAlert(){
        let alert = UIAlertController.init(title: "当前展示的就是TableView", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let confirm = UIAlertAction.init(title: "确认", style: UIAlertActionStyle.cancel, handler: { (confir:UIAlertAction) in
            
        })
        
        alert.addAction(confirm)
        self.present(alert, animated: true, completion: {
            
        })
        
                
    }
    
    //remove subview
    @objc func remove(view:AnyObject) {
        view.removeFromSuperview()
    }
    
}
