//
//  ViewController.swift
//  Swift_1Demo
//
//  Created by 孙建飞 on 16/4/22.
//  Copyright © 2016年 sjf. All rights reserved.
//

import UIKit

var label:UILabel!

var array:NSArray!

var dic:NSDictionary!

var btn:UIButton!

//var textField:UITextField


class ViewController: UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        var textField:UITextField!
//label
        label = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 30))
        label.text="aaa";
        label.textColor=UIColor.red
        label.backgroundColor=UIColor.yellow
        label.textAlignment=NSTextAlignment.center
        self.view.addSubview(label)
        //
        array=NSArray(objects: "你","好","吗")
        
        print(array.count,array.object(at: 0))
        
//button
        btn=UIButton(type: UIButtonType.custom)
        
        btn.frame=CGRect(x: 100, y: 200, width: 100, height: 30)
        
        btn.setTitle("button", for: UIControlState())
        
        btn.addTarget(self, action: #selector(ViewController.click), for: UIControlEvents.touchUpInside)
        
        btn.setTitleColor(UIColor.red, for: UIControlState())
        btn.setTitleColor(UIColor.black, for: UIControlState.highlighted)
        self.view.addSubview(btn)
//textField
        
        textField=UITextField(frame: CGRect(x: 100, y: 300, width: 100, height: 30))

        
        
        textField.placeholder="textfield"
        
       // textField.backgroundColor=UIColor.grayColor()
        /*UITextBorderStyle.None：无边框
        UITextBorderStyle.Line：直线边框
        UITextBorderStyle.RoundedRect：圆角矩形边框
        UITextBorderStyle.Bezel：边线+阴影*/
        textField.borderStyle=UITextBorderStyle.roundedRect
   
        //    文字大小超过文本框长度时自动缩小字号，而不是隐藏显示省略号
        textField.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        textField.minimumFontSize=14  //最小可缩小的字号

        textField.textAlignment=NSTextAlignment.left
        
        textField.clearButtonMode=UITextFieldViewMode.whileEditing  //编辑时出现清除按钮
       // textField.clearButtonMode=UITextFieldViewMode.UnlessEditing  //编辑时不出现，编辑后才出现清除按钮
       // textField.clearButtonMode=UITextFieldViewMode.Always  //一直显示清除按钮

        
        textField.returnKeyType = UIReturnKeyType.done //表示完成输入
        textField.returnKeyType = UIReturnKeyType.go //表示完成输入，同时会跳到另一页
        textField.returnKeyType = UIReturnKeyType.search //表示搜索
        textField.returnKeyType = UIReturnKeyType.join //表示注册用户或添加数据
        textField.returnKeyType = UIReturnKeyType.next //表示继续下一步
        textField.returnKeyType = UIReturnKeyType.send //表示发送

        textField.delegate=self
        
//        textField.addTarget(self,action:#selector(ViewController.click),type:)
        
        self.view.addSubview(textField)
        
        
    }

    @objc func click(){
       
        //textField.resignFirstResponder()
        
        print("click")
    }
    
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //收起键盘
        textField.resignFirstResponder()
        
        //打印出文本框中的值
        print(textField.text ?? "空")
        var strtmp = "qqqqq"
        strtmp = "ajsja"
        print(strtmp)
        return true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

