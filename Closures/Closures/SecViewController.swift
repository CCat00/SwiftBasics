//
//  SecViewController.swift
//  Closures
//
//  Created by 韩威 on 16/8/19.
//  Copyright © 2016年 韩威. All rights reserved.
//

import UIKit

// 1.定义
typealias FeedbackBlock = (String) -> ()

class SecViewController: UIViewController {
    
    @IBOutlet weak var tf: UITextField!
    
    var feedback: FeedbackBlock?
    
    // 2.直接声明
    var feedback2: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        somFun2 { 
            print("逃逸闭包=-=---回调")
        }
    }
    
    @IBAction func back(sender: UIButton) {
        
        if feedback != nil {
            
            feedback!(tf.text!)
        }
        
        if feedback2 != nil {
            
            feedback2!(tf.text!)
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // 非逃逸闭包(Nonescaping Closures)
    /*
     当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸。当你定义接受闭包作为参数的函数时，你可以在参数名之前标注@noescape，用来指明这个闭包是不允许“逃逸”出这个函数的。将闭包标注@noescape能使编译器知道这个闭包的生命周期（译者注：闭包只能在函数体中被执行，不能脱离函数体执行，所以编译器明确知道运行时的上下文），从而可以进行一些比较激进的优化。
     
     举个例子，sort(_:)方法接受一个用来进行元素比较的闭包作为参数。这个参数被标注了@noescape，因为它确保自己在排序结束之后就没用了。见：ViewController里的`ViewDidLoad`第一个例子`sort(_:)`
     
     一种能使闭包“逃逸”出函数的方法是，将这个闭包保存在一个函数外部定义的变量中。
     
     var completionHandlers: [() -> Void] = []
     func someFunctionWithEscapingClosure(completionHandler: () -> Void) {
        completionHandlers.append(completionHandler)
     }
     
     */
//    func someFun(@noescape paraFeedback: FeedbackBlock) -> Void {
//        paraFeedback("")
//    }
    
    /**
     这里不能用 `@noescape` 修饰，因为是
     同步操作的话，是没有体现出noescape的特别，主要是在异步的时候起作用，譬如，你在doSomething里面执行异步的网络请求，你需要用some来执行一些请求后的操作的话，如果用noescape的话，会变异出错，请求的返回处理some函数是在doSomething这个函数结束后才会执行，根据noescape的定义，doSomething结束后就不能执行some了
     
     
     非逃逸闭包和逃逸闭包讲的不是执行先后顺序吧,非逃逸是指你那个 some 闭包不能在函数外单独调用,只能在函数内部调用,函数调用完成后,那个闭包也就结束了,而逃逸闭包,你看官方给的例子,将闭包加入了数组,通过在外部访问数组元素,从而达到了使用那个闭包的效果
     "someFunctionWithEscapingClosure(_:)函数接受一个闭包作为参数，该闭包被添加到一个函数外定义的数组中。如果你试图将这个参数标注为@noescape，你将会获得一个编译错误。
     */
    func somFun2(/*@noescape*/ block: () -> Void) -> () {
        
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC*10))
        let queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_CONCURRENT)
        
        dispatch_after(time, queue) { 
            
            
            dispatch_async(dispatch_get_main_queue(), {
                block()
            })
        }
        
        
        print("函数")
    }
    
    
    
}
