//
//  ViewController.swift
//  Functions
//
//  Created by 韩威 on 16/8/18.
//  Copyright © 2016年 韩威. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    /*
     函数类型作为参数类型（Function Types as Parameter Types）
     
     这个例子定义了 printMathResult(_:_:_:) 函数，它有三个参数：第一个参数叫 mathFunction，类型是(Int, Int) -> Int，你可以传入任何这种类型的函数；第二个和第三个参数叫 a 和 b，它们的类型都是 Int，这两个值作为已给出的函数的输入值。
     
     当 printMathResult(_:_:_:) 被调用时，它被传入 addTwoInts 函数和整数3和5。它用传入3和5调用 addTwoInts，并输出结果：8。
     
     printMathResult(_:_:_:) 函数的作用就是输出另一个适当类型的数学函数的调用结果。它不关心传入函数是如何实现的，它只关心这个传入的函数类型是正确的。这使得 printMathResult(_:_:_:) 能以一种类型安全（type-safe）的方式将一部分功能转给调用者实现。
     */
    func printMathResult(mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
        print("Result: \(mathFunction(a, b))")
    }
    
    // prints "Result: 8"
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
//        let str = sayHello("韩威")
//        print(str)
//        
//        let bounds = minMax([8, -6, 2, 109, 3, 71])
//        print("min is \(bounds!.min) and max is \(bounds!.max)")
//        // prints "min is -6 and max is 109"
//        
//        
//        let methodFun: (Int, Int) -> Int = addTwoInts
//        
//        print("result is \(methodFun(1,2))")
        
        
        printMathResult(addTwoInts, 3, 5)
    }
    
    
    func sayHello(personName: String) -> String {
        let greeting = "Hello, " + personName + "!"
        return greeting
    }

    func sayHelloAgain(personName: String) -> String {
        return "Hello again, " + personName + "!"
    }
    
    func sayHello(personName: String, alreadyGreeted: Bool) -> String {
        if alreadyGreeted {
            return sayHelloAgain(personName)
        } else {
            return sayHello(personName)
        }
    }
    
    func sayGoodbye(personName: String) {
        print("Goodbye, \(personName)!")
    }
    
    
    /**
     如果函数返回的元组类型有可能整个元组都“没有值”，你可以使用可选的（Optional） 元组返回类型反映整个元组可以是nil的事实。你可以通过在元组类型的右括号后放置一个问号来定义一个可选元组，例如(Int, Int)?或(String, Int, Bool)?
     
     - parameter array:
     
     - returns:
     */
    func minMax(array: [Int]) -> (min: Int, max: Int)? {
        if array.isEmpty {
            return nil
        }
        var currentMin = array[0]
        var currentMax = array[0]
        for value in array[1..<array.count] {
            if value < currentMin {
                currentMin = value
            } else if value > currentMax {
                currentMax = value
            }
        }
        return (currentMin, currentMax)
        
        
        
        var sss = 1
        someFunction(&sss)
    }
    
    
    
    func someFunction(inout parameterWithDefault: Int) {
        parameterWithDefault = 13
        // function body goes here
        // if no arguments are passed to the function call,
        // value of parameterWithDefault is 12
        
        
        
    }
    
//    func someFunction(externalParameterName localParameterName: Int) {
//        // function body goes here, and can use localParameterName
//        // to refer to the argument value for that parameter
//        
//        let nihao = 1
//        hahah(nihao: nihao)
//    }
    
    
    
    func addTwoInts(a: Int, b: Int) -> Int {
        return a + b
    }

    
    /**
     外部可见参数名 nihao
     
     - parameter nh: 内部参数名
     */
//    func hahah(nihao nh: Int) -> () {
//        nh = 2
//    }
    
    
    
    
    /*
     函数类型作为返回类型（Function Types as Return Types）
     
     你可以用函数类型作为另一个函数的返回类型。你需要做的是在返回箭头（->）后写一个完整的函数类型。
     
     下面的这个例子中定义了两个简单函数，分别是 stepForward 和stepBackward。stepForward 函数返回一个比输入值大一的值。stepBackward 函数返回一个比输入值小一的值。这两个函数的类型都是 (Int) -> Int：
     

     */
    
    
//    func stepForward(input: Int) -> Int {
//        return input + 1
//    }
//    func stepBackward(input: Int) -> Int {
//        return input - 1
//    }
//    
//    func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
//        return backwards ? stepBackward : stepForward
//    }
    
    /*
     嵌套函数
     */
    func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
        func stepForward(input: Int) -> Int { return input + 1 }
        func stepBackward(input: Int) -> Int { return input - 1 }
        return backwards ? stepBackward : stepForward
    }

}

