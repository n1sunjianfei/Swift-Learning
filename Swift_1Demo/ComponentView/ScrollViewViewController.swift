//
//  ScrollViewViewController.swift
//  Swift_1Demo
//
//  Created by JianF.Sun on 17/10/11.
//  Copyright © 2017年 sjf. All rights reserved.
//

import UIKit

class ScrollViewViewController: UIViewController ,UIScrollViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad();
   
 print(HEIGHT,self.view.bounds.size.height,UIApplication.shared.keyWindow?.bounds.size.height ?? 1);
        
        self.jf_hidesBottomBarWhenPushed = true
        self.view.backgroundColor = UIColor.white
        let scroll = UIScrollView(frame: self.view.bounds)
        scroll.isScrollEnabled = true
        scroll.showsVerticalScrollIndicator = true
//        scroll.showsHorizontalScrollIndicator = true
        scroll.delegate = self
        scroll.contentSize = CGSize.init(width:0, height: 3*HEIGHT)
       
        self.view.addSubview(scroll)
        
        //
        let label = UILabel()
        label.textColor = UIColor.white;
        label.font = UIFont.systemFont(ofSize: 10);
        label.lineBreakMode = NSLineBreakMode.byCharWrapping;
        label.numberOfLines = 0;
        let classText = Bundle.main.path(forResource: "ScrollViewViewController", ofType: "txt");
        if classText != nil{
            do{
                let text = try NSString.init(contentsOfFile: classText!, encoding: String.Encoding.utf8.rawValue);
                label.text = text as String;
            }catch{
                print("error---" + error.localizedDescription)
                
            }
        }
        label.textAlignment = NSTextAlignment.left
        label.backgroundColor = UIColor.red;
        label.frame = CGRect.init(x:0, y:0, width:self.view.bounds.size.width, height:self.view.bounds.size.height*3)
        scroll.addSubview(label)
        
    }
    
    //MARK:-  UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("scrollViewDidScroll")
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
    }
    
    func scrollViewDidEndDecelerating(_scrollView: UIScrollView) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
