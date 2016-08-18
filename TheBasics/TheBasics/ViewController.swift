//
//  ViewController.swift
//  TheBasics
//
//  Created by 韩威 on 16/8/17.
//  Copyright © 2016年 韩威. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        
        // 常亮
        let maxCount = 10
        
        // 变量
        var currentCount = 0
        
        var x = 0.0 , y = 0.0, z = 0.0
        
        var message: String
        
        message = "Hello"
        
        var red, blue, yellow: Double
        
        let π = 3.14
        
        let 你好 = "你好"
        
        let 😢😊 = "哈哈"
        
        
//        var x = 0
//        x = 1
        
        
        print(message)
        
        /*
         /*
            注释可以嵌套
         */
         */
        print("这可以转移 \(你好)")
        
        
        let cat = "🐱"; print(cat)
        
        
        
        let minValue = UInt8.min // 0
        let maxValue = UInt8.max // 255
        
        // Int
        
        /**
         Int
         
         In most cases, you don’t need to pick a specific size of integer to use in your code. Swift provides an additional integer type, Int, which has the same size as the current platform’s native word size:
         
         On a 32-bit platform, Int is the same size as Int32.
         On a 64-bit platform, Int is the same size as Int64.
         */
        
        // UInt
        
        /**
         UInt
         
         Swift also provides an unsigned integer type, UInt, which has the same size as the current platform’s native word size:
         
         On a 32-bit platform, UInt is the same size as UInt32.
         On a 64-bit platform, UInt is the same size as UInt64.
         */
        
        
        
        let http404Error = (404, "Not Found")
        
        let (statusCode, statusMessage) = http404Error
        
        print("The status code is \(statusCode)")
        // Prints "The status code is 404"
        print("The status message is \(statusMessage)")
        // Prints "The status message is Not Found"
        
        let (justTheStatusCode, _) = http404Error
        print("The status code is \(justTheStatusCode)")
        // Prints "The status code is 404"
        
        
        print("The status code is \(http404Error.0)")
        // Prints "The status code is 404"
        print("The status message is \(http404Error.1)")
        // Prints "The status message is Not Found"
        
        
       
        
        
//        let age = -3
//        assert(age >= 0, "A person's age cannot be less than zero")
        
        
        let stringlen = "1234567890"
        
        
        let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
        print("unusualMenagerie has \(unusualMenagerie.characters.count) characters")
        // Prints "unusualMenagerie has 40 characters"
        
        
        
            
        
        
        9 %  4 == 1
//
//        9 = (4 * 2) + 1
        
//        let xss = 2 + 3.2
        
//        let x1: Int
//        let y1: Float
//        
//        x1 + y1
        
        
        
        
//        do {
//            try makeASandwich()
//            eatASandwich()
//        } catch Error.OutOfCleanDishes {
//            washDishes()
//        } catch Error.MissingIngredients(let ingredients) {
//            buyGroceries(ingredients)
//        }
        
        */
        var iii = 5;
        testInout(&iii)
        
        
        print(iii);
        
    }
    
    func testInout(inout a: Int) {
        a += 1;
    }
    
    func exchange<T>(inout a: T) -> Void {
        
    }
    
    func makeASandwich() throws {
        // ...
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

