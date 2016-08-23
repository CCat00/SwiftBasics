//
//  ViewController.swift
//  Enumerations
//
//  Created by 韩威 on 16/8/22.
//  Copyright © 2016年 韩威. All rights reserved.
//



/**
 枚举语法
 */
enum SomeEnumeration {
    // 枚举定义放在这里
}

// eg.1
/**
 枚举中定义的值（如 North，South，East和West）是这个枚举的成员值（或成员）。你使用case关键字来定义一个新的枚举成员值。
 与 C 和 Objective-C 不同，Swift 的枚举成员在被创建时不会被赋予一个默认的整型值。在上面的CompassPoint例子中，North，South，East和West不会被隐式地赋值为0，1，2和3。相反，这些枚举成员本身就是完备的值，这些值的类型是已经明确定义好的CompassPoint类型。
 */
enum CompassPoint {
    case North
    case South
    case East
    case West
}

// 也可以写在一行，用逗号隔开
enum Planet {
    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}


import UIKit

class ViewController: UIViewController {
    
    var compass: CompassPoint?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        compass = CompassPoint.North
        // 当类型已知的时候可以省略的写法
        compass = .West
        
        if compass == CompassPoint.North {
            print("方向是北方")
        } else {
            print("不是北方")
        }
        
        //let directionToHead = CompassPoint.North
        
        /**
         *  这里需要注意，switch语句必须全部列举出枚举的每一种情况，或者加上default语句。
         *  否则，编译会报错
         */
        switch compass! {
        case .North:
            print("北")
        case .South:
            print("南")
        case .East:
            print("东")
        case .West:
            print("西")
//        default:
//            print("default, 西")
            
        }
        
//        if compass! == .North {
//            // ...
//        }
//        
//        guard compass! == .North else {
//            
//            return
//        }
//        // code ...
        
        // 关联值 (Associated Values)
        
        enum Barcode {
            case UPCA(Int, Int, Int, Int)
            case QRCode(String)
        }
        
        var productBarcode = Barcode.UPCA(8, 85909, 51226, 3)
        
        /*
         这时，原始的Barcode.UPCA和其整数关联值被新的Barcode.QRCode和其字符串关联值所替代。Barcode类型的常量和变量可以存储一个.UPCA或者一个.QRCode（连同它们的关联值），但是在同一时间只能存储这两个值中的一个。
         */
        productBarcode = .QRCode("ABCDEFGHIJKLMNOP")
        
        /**
         这里单独写个方法，是为了不报警告。
         */
        func testSwitchEnum(product: Barcode) {
            
            switch  product { // 这里如果直接传入`productBarcode`的话，会报警告： Switch condition evaluates to a constant
            case .UPCA(let numberSystem, let manufacturer, let product, let check):
                print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
            case .QRCode(let productCode):
                print("QR code: \(productCode).")
            }
            // 输出 "QR code: ABCDEFGHIJKLMNOP."
        }
        
        testSwitchEnum(productBarcode)
        
        
        
        // 如果一个枚举成员的所有关联值都被提取为常量，或者都被提取为变量，为了简洁，你可以只在成员名称前标注一个let或者var：
        /*
        switch productBarcode {
        case let .UPCA(numberSystem, manufacturer, product, check):
            print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
        case let .QRCode(productCode):
            print("QR code: \(productCode).")
        }
        // 输出 "QR code: ABCDEFGHIJKLMNOP."
         */
        
        
        enum ASCIIControlCharacter: Character {
            case Tab = "\t"
            case LineFeed = "\n"
            case CarriageReturn = "\r"
        }
        
        enum Planet: Int {
            case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
        }

        let merRawValue = Planet.Mercury.rawValue
        print(merRawValue)
        
        enum CompassPointString: String {
            case North, South, East, West
        }

        let sunsetDirection = CompassPointString.West.rawValue
        print(sunsetDirection)
        // sunsetDirection 值为 "West"
        
        let testPlanet: Planet = .Venus
        if testPlanet.rawValue == 2 {
            print("Venus")
        }
        
        // 原始值构造器是一个可失败构造器，因为并不是每一个原始值都有与之对应的枚举成员
        let possiblePlanet = Planet(rawValue: 7)
        print("possiblePlanet \(possiblePlanet)")
        // possiblePlanet 类型为 Planet? 值为 Planet.Uranus
        
        let positionToFind = 9
        if let somePlanet = Planet(rawValue: positionToFind) {
            // 这里 somePlanet 类型是可选类型(Planet?) ，由于上面用了if判断语句，编译器这里不会报错。如果没有写这个判断的话，就需要在somePlanet加`!`
            switch somePlanet {
            case .Earth:
                print("Mostly harmless")
            default:
                print("Not a safe place for humans")
            }
        } else {
            print("There isn't a planet at position \(positionToFind)")
        }
        // 输出 "There isn't a planet at position 9
        
        
        // 递归枚举（Recursive Enumerations）
        
//        enum ArithmeticExpression {
//            case Number(Int)
//            indirect case Addition(ArithmeticExpression, ArithmeticExpression)
//            indirect case Multiplication(ArithmeticExpression, ArithmeticExpression)
//        }
        
        indirect enum ArithmeticExpression {
            case Number(Int)
            case Addition(ArithmeticExpression, ArithmeticExpression)
            case Multiplication(ArithmeticExpression, ArithmeticExpression)
        }
        
        // 求表达式 (5+4)*2
        let five = ArithmeticExpression.Number(5)
        let four = ArithmeticExpression.Number(4)
        let sum = ArithmeticExpression.Addition(five, four)
        let product = ArithmeticExpression.Multiplication(sum, ArithmeticExpression.Number(2))
        
        
        func evaluate(expression: ArithmeticExpression) -> Int {
            switch expression {
            case .Number(let value):
                return value
            case .Addition(let left, let right):
                return evaluate(left) + evaluate(right)
            case .Multiplication(let left, let right):
                return evaluate(left) * evaluate(right)
            }
        }
        
        print(evaluate(product))
        // 输出 "18"
        
    }
    
    

}

