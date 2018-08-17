//
//  TextFieldViewController.swift
//  Swift_1Demo
//
//  Created by JianF.Sun on 17/10/11.
//  Copyright © 2017年 sjf. All rights reserved.
//

import UIKit

//delegate step 1:
@objc protocol testProtocol:NSObjectProtocol{
     @objc optional func testAdd( a:Int, b:Int) -> Int;
    
}

class TextFieldViewController: UIViewController ,UITextFieldDelegate{
    //delegate step 2:
    var delegate:testProtocol?

    func logJFFF(string:String?){
        print(string ?? "")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldTextDidBeginEditingNotification(sender:)), name:NSNotification.Name.UITextFieldTextDidBeginEditing, object:nil)
        
        let textField = UITextField(frame: CGRect.init(x: 0, y: 0, width: 200, height: 40))
        textField.center = self.view.center
        textField.backgroundColor = UIColor.clear
        textField.textColor = UIColor.black
        textField.placeholder = "请输入..."
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.adjustsFontSizeToFitWidth = true
        textField.delegate = self
        
        self.view.addSubview(textField)
    }
    //MARK:-notification
    @objc func textFieldTextDidBeginEditingNotification(sender: NSNotification!) {
        
    }
    //MARK:-delegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true;
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        //delegate step 3:
//        if (self.delegate != nil)&&(self.delegate?.responds(to:#selector(testProtocol.testAdd(a:b:))))!{
//            let result = self.delegate!.testAdd!(a: 2, b: 5)
//            print(result)
//        }
        let result = self.delegate?.testAdd!(a: 3, b: 1)
        print(result ?? "delegate没有响应")
        return true;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
