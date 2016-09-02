//
//  ViewController.swift
//  Methods
//
//  Created by 韩威 on 16/8/23.
//  Copyright © 2016年 韩威. All rights reserved.
//


/**
 结构体和枚举能够定义方法是 Swift 与 C/Objective-C 的主要区别之一。
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 在实例方法中修改值类型
        var somePoint = Point(x: 1.0, y: 1.0)
        somePoint.moveByX(2.0, y: 3.0)
        print("The point is now at (\(somePoint.x), \(somePoint.y))")
        // 打印输出: "The point is now at (3.0, 4.0)"
        
//        let fixedPoint = Point(x: 3.0, y: 3.0)
//        fixedPoint.moveByX(2.0, y: 3.0)
        // 这里将会报告一个错误
        
        
        // 枚举的可变方法可以把self设置为同一枚举类型中不同的成员：
        enum TriStateSwitch {
            case Off, Low, High
            mutating func next() {
                switch self {
                case Off:
                    self = Low
                case Low:
                    self = High
                case High:
                    self = Off
                }
            }
        }
        var ovenLight = TriStateSwitch.Low
        ovenLight.next()
        // ovenLight 现在等于 .High
        ovenLight.next()
        // ovenLight 现在等于 .Off
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        
//        SomeSonClass.someTypeMethod()
//        //father type method
//        //son type method

        
        var player = Player(name: "Argyrios")
        player.completedLevel(1)
        print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
        // 打印输出：highest unlocked level is now 2
    
        player = Player(name: "Beto")
        if player.tracker.advanceToLevel(6) {
            print("player is now on level 6")
        } else {
            print("level 6 has not yet been unlocked")
        }
        // 打印输出：level 6 has not yet been unlocked
    }

}


// 在实例方法中修改值类型(Modifying Value Types from Within Instance Methods)
/*
 结构体和枚举是值类型。默认情况下，值类型的属性不能在它的实例方法中被修改。
 
 但是，如果你确实需要在某个特定的方法中修改结构体或者枚举的属性，你可以为这个方法选择可变(mutating)行为，然后就可以从其方法内部改变它的属性；并且这个方法做的任何改变都会在方法执行结束时写回到原始结构中。方法还可以给它隐含的self属性赋予一个全新的实例，这个新实例在方法结束时会替换现存实例。
 */
struct Point {
    var x = 0.0, y = 0.0
//    mutating func moveByX(deltaX: Double, y deltaY: Double) {
//        x += deltaX
//        y += deltaY
//    }
    // 或者⬇️
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        self = Point(x: x + deltaX, y: y + deltaY)
    }
}



/**
 类型方法 (Type Methods)
 
 实例方法是被某个类型的实例调用的方法。你也可以定义在类型本身上调用的方法，这种方法就叫做类型方法（Type Methods）。在方法的func关键字之前加上关键字static，来指定类型方法。类还可以用关键字class来允许子类重写父类的方法实现。
 
 */


class SomeClass {
    class func someTypeMethod() {
        // type method implementation goes here
        print("father type method")
    }
}
// SomeClass.someTypeMethod()

class SomeSonClass: SomeClass {
    override class func someTypeMethod() {
        super.someTypeMethod()
        print("son type method")
    }
}


struct LevelTracker {
    static var highestUnlockedLevel = 1
    static func unlockLevel(level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }
    static func levelIsUnlocked(level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    var currentLevel = 1
    mutating func advanceToLevel(level: Int) -> Bool {
        if LevelTracker.levelIsUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}


class Player {
    var tracker = LevelTracker()
    let playerName: String
    func completedLevel(level: Int) {
        LevelTracker.unlockLevel(level + 1)
        tracker.advanceToLevel(level + 1)
    }
    init(name: String) {
        playerName = name
    }
}


