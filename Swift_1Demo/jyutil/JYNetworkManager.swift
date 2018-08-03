//
//  JYNetworkManager.swift
//  Swift_1Demo
//
//  Created by JianF.Sun on 2017/10/17.
//  Copyright © 2017年 sjf. All rights reserved.
//

import UIKit

class JYNetworkManager: NSObject {

    
    
    class func POST(urlStr:String,parameters:Any,completion:@escaping( _ data:Any?, _ error:Error?)->()){
        
        let manager = AFHTTPSessionManager.init()
        manager.requestSerializer = AFHTTPRequestSerializer.init()
        manager.responseSerializer = AFHTTPResponseSerializer.init()
        manager.responseSerializer.acceptableContentTypes = NSSet.init(objects: "application/json", "text/plain") as? Set<String>
        manager.post(urlStr, parameters: parameters, success: { (task:URLSessionDataTask, responseObject:Any?) in
            completion(responseObject,nil)
            
        }) { (task:URLSessionDataTask?, error:Error) in
            completion(nil,error)
        }
    }
    //MARK:- uploadFile
    class func POST_UploadFile(urlStr:String,inputStream:InputStream,header:NSDictionary,completion:@escaping( _ data:Any?, _ error:Error?)->()){
        let url = NSURL.init(string: urlStr)! as URL
        let mutRequest = NSMutableURLRequest.init(url: url)
        mutRequest.httpMethod = "POST"
        mutRequest.httpBodyStream = inputStream
        for key in header.allKeys{
            mutRequest.setValue(header[key as! String], forKey: (key as! String) )
        }
        let request = mutRequest.copy() as! URLRequest
        let queue = OperationQueue.main
        
        NSURLConnection.sendAsynchronousRequest(request, queue: queue) { (response:URLResponse?, data:Data?, error:Error?) in
            completion(data,error)
        }
        
    }
    class func POST_UploadFile(urlStr:String,fileData:Data,headerField:NSDictionary,completion:@escaping( _ data:Any?, _ error:Error?)->()){
        let stream = InputStream.init(data: fileData)
        self.POST_UploadFile(urlStr: urlStr, inputStream: stream, header: headerField, completion: completion)
        
    }
    
    class func POST_UploadFile(urlStr:String,fileUrl:URL,headerField:NSDictionary,completion:@escaping( _ data:Any?, _ error:Error?)->()){
        let stream = InputStream.init(url: fileUrl)
        self.POST_UploadFile(urlStr: urlStr, inputStream: stream!, header: headerField, completion: completion)
    }
    
    class func POST_UploadFile(urlStr:String,filePath:String,headerField:NSDictionary,completion:@escaping( _ data:Any?, _ error:Error?)->()){
        let stream = InputStream.init(fileAtPath: filePath)
        self.POST_UploadFile(urlStr: urlStr, inputStream: stream!, header: headerField, completion: completion)
    }
    
}
