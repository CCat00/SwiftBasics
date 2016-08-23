//
//  ViewController.swift
//  ClassesAndStructures
//
//  Created by 韩威 on 16/8/22.
//  Copyright © 2016年 韩威. All rights reserved.
//

import UIKit

/**
 *  结构体
 */
struct SomeStructure {
    // structure definition goes here
}

struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

/// ViewController类
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 实例
        let someResolution = Resolution()
        let someVideoMode = VideoMode()
        
        // 点语法
        print("The width of someResolution is \(someResolution.width)")
        // 输出 "The width of someResolution is 0"
        
        print("The width of someVideoMode is \(someVideoMode.resolution.width)")
        // 输出 "The width of someVideoMode is 0"
        
        /**
         这里可以直接设置，如果在OC里，就必须这样写：
         CGRect frame = self.view.frame;
         frame.origin.x = 10;
         self.view.frame = frame;
         
         var res = someVideoMode.resolution
         res.width = 128
         someVideoMode.resolution = res
         */
        someVideoMode.resolution.width = 128
        print("The width of someVideoMode is \(someVideoMode.resolution.width)")
        // 输出 "The width of someVideoMode is 128"
        
        // 结构体类型的成员逐一构造器（Memberwise Initializers for Structure Types）
        let vga = Resolution(width: 375, height: 675)
        
        // 1.结构体和枚举是值类型
        /**
         值类型被赋予给一个变量、常量或者被传递给一个函数的时候，其值会被拷贝。
         
         在之前的章节中，我们已经大量使用了值类型。实际上，在 Swift 中，所有的基本类型：整数（Integer）、浮点数（floating-point）、布尔值（Boolean）、字符串（string)、数组（array）和字典（dictionary），都是值类型，并且在底层都是以结构体的形式所实现。
         
         在 Swift 中，所有的结构体和枚举类型都是值类型。这意味着它们的实例，以及实例中所包含的任何值类型属性，在代码中传递的时候都会被复制。
         */
        
        // 这里进行了copy
        // vga 和 vga2 是两个不同的实例
        var vga2 = vga
        
        vga2.width = 1080
        
        // vga的值不会变
        print("vga.width is \(vga.width)")
        //vga.width is 375
        print("vga2.width is \(vga2.width)")
        //vga2.width is 1080
        
        //结构体也一样，就不举例子了
        
        
        // 2.类是引用类型
        
        let hd = Resolution(width: 1080, height: 1920)
        
        let tenEighty = VideoMode()
        tenEighty.resolution = hd
        tenEighty.interlaced = true
        tenEighty.name = "1080i"
        tenEighty.frameRate = 25.0

        // 这两个内存地址都是一样的
        let alsoTenEighty = tenEighty
        alsoTenEighty.frameRate = 30.0
        
        print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
        // 输出 "The frameRate property of theEighty is now 30.0"
        
        // 恒等运算符
        //等价于（===）
        //不等价于（!==）
        /*
         “等价于”(`===`)表示两个类类型（class type）的常量或者变量引用同一个类实例。
         “等于”(`==`)表示两个实例的值“相等”或“相同”，判定时要遵照设计者定义的评判标准，因此相对于“相等”来说，这是一种更加合适的叫法。
         */
        if tenEighty === alsoTenEighty {
            print("tenEighty and alsoTenEighty refer to the same Resolution instance.")
        }
        //输出 "tenEighty and alsoTenEighty refer to the same Resolution instance."


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

