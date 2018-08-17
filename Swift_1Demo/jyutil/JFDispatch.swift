//
//  JFDispatch.swift
//  Swift_1Demo
//
//  Created by ever-mac on 2018/8/17.
//  Copyright © 2018年 sjf. All rights reserved.
//

import Foundation

//MARK:- dispatch
typealias jf_dispatch_block = () -> ()

func dispatch_sync(label:String?,_ block:jf_dispatch_block){
    let queue = DispatchQueue(label: (label != nil) ? label! : "com.test.queuesync")
    queue.sync {
        block()
       
    }
}
func dispatch_async(label:String?,_ block:@escaping jf_dispatch_block){
    let queue = DispatchQueue(label: (label != nil) ? label! : "com.test.queueasync")
    queue.async {
        block()
        
    }
}
func dispatch_delay(label:String?,_ block:@escaping jf_dispatch_block){
    let queue = DispatchQueue(label: (label != nil) ? label! : "com.test.queuedelay")
    queue.asyncAfter(deadline: DispatchTime.now()+DispatchTimeInterval.seconds(3), execute: {
        block()
    })
}
func dispatch_main(_ block: @escaping jf_dispatch_block){
    
    let queue = DispatchQueue.main
    queue.async{
        DispatchQueue.main.async {
            block()
        }
    }
}
func dispatch_global(_ block: @escaping jf_dispatch_block){
    let queue = DispatchQueue.global()

    queue.async {
        block()
    }
}
func dispatch_group(label:String?,_ block1: @escaping jf_dispatch_block,_ block2: @escaping jf_dispatch_block){
    let queue = DispatchQueue(label: (label != nil) ? label! : "com.flion.dispatchgroup", attributes: .concurrent)
    let group = DispatchGroup()
    // 任务一
    queue.async(group: group) {
        block1()
        Thread.sleep(forTimeInterval: 4)
        print("dispatch_group--in -任务一")
    }
    //任务二
    queue.async(group: group) {
        block2()
        Thread.sleep(forTimeInterval: 3)
        print("dispatch_group--in -任务二")
    }
    //两个任务做完回到主线程
    group.notify(queue: DispatchQueue.main) {
        print("dispatch_group--完成")
    }
}
func dispatch_workItems(label:String?,_ block1: @escaping jf_dispatch_block){
    
    let queue = DispatchQueue(label: (label != nil) ? label! : "com.flion.dispatchworkItem")

    let workItem01 = DispatchWorkItem{
            print("dispatch_workItems调用了workitem02")
            Thread.sleep(forTimeInterval: 4)
            block1()
       
    }
    queue.async{
        workItem01.perform();
        //两个任务做完回到主线程
        workItem01.notify(queue: DispatchQueue.main) {
            print("dispatch_workItems--done01")
        }
    }
}

