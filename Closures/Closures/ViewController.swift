//
//  ViewController.swift
//  Closures
//
//  Created by 韩威 on 16/8/19.
//  Copyright © 2016年 韩威. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var contentLabel: UILabel!



    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        
//
//        var reversed = names.sort(backwards)
//        print(reversed)
//        // reversed 为 ["Ewa", "Daniella", "Chris", "Barry", "Alex"]
//        
//        
//        /*
//         { (parameters) -> returnType in
//            statements
//         }
//         */
//        
//        reversed = names.sort({ (s1: String, s2: String) -> Bool in
//            return s1 > s2
//        })
//        
//        
//        reversed = names.sort( { (s1: String, s2: String) -> Bool in return s1 > s2 } )
//        reversed = names.sort( { s1, s2 in return s1 > s2 } )
        
        
        // 定义一个闭包（类型是函数类型  (Int, Int) -> Int)  ）
//        var myclosure0: ((Int, Int) -> Int)?
//        
//        typealias MyClosure = (Int, Int) -> Int
//        
//        var myClosure1: MyClosure?
//        
//        /*
//         给Closure变量赋值，其实就是把一个函数体赋值给一个函数类型的变量，和函数的定义区别不大。
//         */
//        myclosure0 = { (num1: Int, num2: Int) -> Int in
//            return num1 + num2
//        }
//        
//        
//        // 闭包的调用
//        let result = myclosure0!(20, 40)
//        
//        print(result)
        
        
        
        // map函数
        
//        let array = [1, 2, 3, 4, 5]
//        
//        let stringArray = array.map { (value: Int) -> String in
//            
//            return "我是老\(value)"
//        }
//        
//        print(stringArray)
        
        
        
        // filter函数
        
//        let array = [190, 100, 195, 174, 134]
//        
//        let overTan150 = array.filter { (value: Int) -> Bool in
//            return value > 150
//        }
//        
//        print(overTan150)
        
        
    }
//
//    
//    func backwards(s1: String, s2: String) -> Bool {
//        return s1 > s2
//    }
//
//    func sum(inout a: Int, b: Int) -> Int {
//        a += 1
//        return a + b
//    }
    
    
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let secVC = segue.destinationViewController as! SecViewController
        
//        secVC.feedback = { (text: String) -> () in
//        
//            print(text)
//            
//            self.contentLabel.text = text
//            
//        }
        
        // 测试闭包可以捕获值(capturing values)
        var testVar = 5;
        
        secVC.feedback2 = { (text: String) -> Void in
            
            // 闭包可以在其被定义的上下文中捕获常量或变量。即使定义这些常量和变量的原作用域已经不存在，闭包仍然可以在闭包函数体内引用和修改这些值。
            testVar += 1
            
            print("testVar = \(testVar)")
            
            print(text)
            
            self.contentLabel.text = text
            
        }
        
        
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        return true
    }
    

}





