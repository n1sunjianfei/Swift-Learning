//
//  OtherViewController.swift
//  Swift_1Demo
//
//  Created by JianF.Sun on 17/10/11.
//  Copyright © 2017年 sjf. All rights reserved.
//

import UIKit

class OtherViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    var tableView: UITableView!
    
    //lazy
    lazy var datasource:NSArray = {
        
        var tmpdatasource = NSArray(objects: ["title":"dispatch使用","content":["sync -- 同步","async -- 异步","delay -- 延迟执行三秒","main -- 主线程","global -- 全局并发队列"]],["title":"网络请求","content":["GET -- 请求","POST -- 请求","下载图片"]],["title":"自定义组件","content":["toast","。。。"]])
        
        return tmpdatasource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "线程+请求+弹窗"
        
        self.tableView = UITableView(frame:self.view.bounds, style: UITableViewStyle.grouped)
    
//        self.tableView.backgroundColor = UIColor.brown
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
       
        
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK:- dispatch
    
    func dispatch_sync(){
        let queue = DispatchQueue(label: "com.test.queuesync")
        queue.sync {
            for i in 0...10{
                print("sync test --- ",i)
            }
            print("   ---同步执行结束  子线程---")
        }
    }
    func dispatch_async(){
        let queue = DispatchQueue(label: "com.test.queueasync")
        queue.async {
            for i in 0...10{
                print("async test --- ",i)
            }
            print("   ---异步执行结束  子线程---")
        }
    }
    func dispatch_delay(){
        let queue = DispatchQueue(label: "com.test.queuedelay")
        queue.asyncAfter(deadline: DispatchTime.now()+DispatchTimeInterval.seconds(3), execute: {
            
            print("   ---延迟执行执行结束  子线程---")
        })
    }
    func dispatch_main(){
        
        let queue = DispatchQueue(label: "com.test.backtomain")
        queue.async{
            DispatchQueue.main.sync {
                print("   ---回到主线程---")
            }
        }
    }
    func dispatch_global(){
        let queue = DispatchQueue.global()
        let workItem = DispatchWorkItem{
            print("调用了workitem")
        }
        queue.async {
            for i in 0...10{
                print("async test --- ",i)
            }
            workItem.perform();
            print("   ---global异步执行结束  子线程---")
        }
    }
    //MARK:-request 
    
    func getRequest(){
        let url = URL.init(string: "https://api.github.com/repos/alibaba/weex")
        let request = NSMutableURLRequest.init(url:url!)
        
        request.httpMethod = "GET"
        
        request.timeoutInterval = 10
//        let params = "type=shentong&postid=3333557693903" as NSString
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        request.httpBody = params.data(using: String.Encoding.utf8.rawValue)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if (error != nil) {
                print(error ?? "")
                return
            }else {
                //此处是具体的解析，具体请移步下面
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    print(json)
//                    let json: Any = try! JSONSerialization.jsonObject(with: data!, options: [])
//                    print(json)
                    JYToast.showInMidWindow(title: NSString.init(format: "data is -- \n %@", json as! CVarArg) as String)
                }catch{
                    print(error.localizedDescription)
                }
                
                
            }
        }
        dataTask.resume()
        
           
    }
    func postRequest(){
        let url = URL.init(string: "http://www.kuaidi100.com/query")
        let request = NSMutableURLRequest.init(url:url!)
        
        request.httpMethod = "POST"
        
        request.timeoutInterval = 10
        let params = "type=shentong&postid=3333557693903" as NSString
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = params.data(using: String.Encoding.utf8.rawValue)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if (error != nil) {
                print(error ?? "")
                JYToast.showInMidWindow(title: NSString.init(format: "error is -- \n %@", error! as CVarArg) as String)
                return
            }else {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    print(json)
                    JYToast.showInMidWindow(title: NSString.init(format: "data is -- \n %@", json as! CVarArg) as String)
                }catch{
                    print(error.localizedDescription)

                }
            }
        }
        dataTask.resume()
    }
    //MARK:- Tableview delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60;
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dic = self.datasource[section] as! NSDictionary
        return dic["title"] as? String
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dic = self.datasource[section] as! NSDictionary
        let arr = dic["content"] as! NSArray
        
        return arr.count
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.datasource.count;
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let dic = self.datasource[indexPath.section] as! NSDictionary
        let arr = dic["content"] as! NSArray
        cell.textLabel?.text = arr[indexPath.row] as? String
        
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
        if indexPath.section==0{
            switch indexPath.row {
            case 0:
                print("\n---同步执行开始  main---")
                self.dispatch_sync()
                print("---同步执行结束  main---")

                break
            case 1:
                print("\n---异步执行开始  main---")
                self.dispatch_async()
                print("---异步执行结束  main---")
                
                break
            case 2:
                print("\n---延迟执行开始  main---")
                self.dispatch_delay()
                print("---延迟执行结束  main---")
                
                break
            case 3:
                print("\n---获取主线程执行开始  main---")
                self.dispatch_main()
                print("---获取主线程执行结束  main---")
                
                break
            case 4:
                print("\n---global 执行开始  main---")
                self.dispatch_global()
                print("---global执行结束  main---")
                
                break
            default:
                break
            }
        }else if indexPath.section==1{
            switch indexPath.row {
            case 0:
                self.getRequest()
                
                break
            case 1:
                self.postRequest()
                
                break
            case 2:
                let queue = DispatchQueue.global();
                queue.async {
                
                    let data = NSData.init(contentsOf: NSURL.init(string: "http://c.hiphotos.baidu.com/image/h%3D300/sign=58adc7aa3c2ac65c78056073cbf3b21d/3b292df5e0fe9925de1b729a3da85edf8cb171e0.jpg")! as URL)
                    let image = UIImage.init(data: data! as Data)
                    
                    let doc = NSHomeDirectory() as NSString
                    doc.appendingPathComponent("Documents/1.jpg")
                    do{
                        try data?.write(toFile: doc.appendingPathComponent("Documents/1.jpg"), options: NSData.WritingOptions.atomic)
                    }catch{
                        print(error.localizedDescription)
                    }

                    let main = DispatchQueue.main
                    main.async {
                        let imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 80, width: 200, height: 100))
                        imageView.image = image
                        self.view.addSubview(imageView)
                        
                        let delay = DispatchQueue.init(label: "delay.remove.imageview")
                        delay.asyncAfter(deadline: DispatchTime.now()+DispatchTimeInterval.seconds(3), execute: {
                            DispatchQueue.main.async {
                                imageView.removeFromSuperview()

                            }
                        })
                    }
                    
                }
                break
            default:
                break
            }
        }else if indexPath.section==2{
            switch indexPath.row {
            case 0:
                JYToast.showInMidWindow(title: "这是一个toast啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊奥奥奥奥奥多多付所付所多付所多所")
                break
            case 1:

                JYShowAlert.showAlert(alertTitle: "这是一个提示框", message: "这是提示信息", actionTitle: "确认", handler: {(action:UIAlertAction) in
                    
                })
//                let str = JYDateUtil.getDateString(formatterString: "yyyy-MM-dd HH:mm:ss", date: NSDate())
//                JYToast.showInMidWindow(title: str)
//                let month = JYDateUtil.compareCurrentDateWithOtherDate(dateString: "20171016 11:14:00", timeInterval: 20)
                
                
//                    print(month)
            default:
                break
            }
        }
       
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
