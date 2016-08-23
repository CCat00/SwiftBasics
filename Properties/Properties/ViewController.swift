//
//  ViewController.swift
//  Properties
//
//  Created by 韩威 on 16/8/22.
//  Copyright © 2016年 韩威. All rights reserved.
//

import UIKit

struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

class DataImporter {
    /*
     DataImporter 是一个负责将外部文件中的数据导入的类。
     这个类的初始化会消耗不少时间。
     */
    var fileName = "data.txt"
    // 这里会提供数据导入功能
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // 这里会提供数据管理功能
}


class ViewController: UIViewController {
    
    struct Point {
        var x = 0.0, y = 0.0
    }
    
    struct Size {
        var width = 0.0, height = 0.0
    }
    
    struct Rect {
        var origin = Point()
        var size = Size()
        var center: Point {
            get {
                let centerX = origin.x + size.width / 2
                let centerY = origin.y + size.height / 2
                return Point(x: centerX, y: centerY)
            }
            set {
                origin.x = newValue.x - (size.width / 2)
                origin.y = newValue.y - (size.height / 2)
            }
        }
    }
    
    
    struct Cuboid {
        var width = 0.0, height = 0.0, depth = 0.0
        // 只读属性(get{}可以省略)
        var volume: Double {
            return width * height * depth
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
        // 该区间表示整数0，1，2
        rangeOfThreeItems.firstValue = 6
        // 该区间现在表示整数6，7，8
        
        // 延迟储存属性
        // 用`lazy`关键字修饰，用到的时候才会加载。（类似于懒加载）
        /// 如果一个被标记为 lazy 的属性在没有初始化时就同时被多个线程访问，则无法保证该属性只会被初始化一次。
        let manager = DataManager()
        manager.data.append("Some data")
        manager.data.append("Some more data")
        // DataImporter 实例的 importer 属性还没有被创建
        
        print(manager.importer.fileName)
        // DataImporter 实例的 importer 属性现在被创建了
        // 输出 "data.txt”
        
        
        var square = Rect(origin: Point(x: 0.0, y: 0.0),
                          size: Size(width: 10.0, height: 10.0))
        //let initialSquareCenter = square.center
        square.center = Point(x: 15.0, y: 15.0)
        print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
        // 输出 "square.origin is now at (10.0, 10.0)”
        
        
        let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
        print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
        // 输出 "the volume of fourByFiveByTwo is 40.0"

        
        // 属性观察器
        // 属性观察器监控和响应属性值的变化，每次属性被设置值的时候都会调用属性观察器，即使新值和当前值相同的时候也不例外。
        
        let stepCounter = StepCounter()
        stepCounter.totalSteps = 200
        // About to set totalSteps to 200
        // Added 200 steps
        stepCounter.totalSteps = 360
        // About to set totalSteps to 360
        // Added 160 steps
        stepCounter.totalSteps = 896
        // About to set totalSteps to 896
        // Added 536 steps
        
        let son = SonStepCounter()
        
        son.totalSteps = 20
        // son class willset newValue is 20
        // About to set totalSteps to 20
        // Added 20 steps
        // son class didset oldValue is 0

        //类型属性的访问
        
        print(SomeStructure.storedTypeProperty)
        // 输出 "Some value."
        SomeStructure.storedTypeProperty = "Another value."
        print(SomeStructure.storedTypeProperty)
        // 输出 "Another value.”
        print(SomeEnumeration.computedTypeProperty)
        // 输出 "6"
        print(SomeClass.computedTypeProperty)
        // 输出 "27"
    }
}

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

/*
 父类的属性在子类的构造器中被赋值时，它在父类中的 willSet 和 didSet 观察器会被调用，随后才会调用子类的观察器。在父类初始化方法调用之前，子类给属性赋值时，观察器不会被调用。 有关构造器代理的更多信息，请参考值类型的构造器代理和类的构造器代理规则。
 */
class SonStepCounter: StepCounter {
    override var totalSteps: Int {
        willSet {
            print("son class willset newValue is \(newValue)")
        }
        didSet {
            print("son class didset oldValue is \(oldValue)")
        }
    }
}

// 类型属性 跟类相关不是实例

struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}

class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}
