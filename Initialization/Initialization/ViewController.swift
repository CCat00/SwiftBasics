//
//  ViewController.swift
//  Initialization
//
//  Created by 韩威 on 16/9/1.
//  Copyright © 2016年 韩威. All rights reserved.
//

/// 构造过程

struct Fahrenheit {
    //var temperature: Double
    var temperature = 32.0
    init() {
        //temperature = 32.0
    }
}

/// 构造参数

struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}

struct Color {
    let red, green, blue: Double
    // 会自动生成外部参数名 red green blue
    // red 前的外部参数用了_表示，在外面调用的时候，就没有参数名了
    init(_ red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}

/// 可选类型属性

class SurveyQuestion {
    // 构造过程中常量属性的修改
    // 这里把text改为let修饰，也可在构造函数里修改它的值
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}

/// 默认构造器

class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}

/// 结构体的逐一成员构造器

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

/// 类的继承和构造过程
/// 类里面的所有存储型属性——包括所有继承自父类的属性——都必须在构造过程中设置初始值。
/// Swift 为类类型提供了两种构造器来确保实例中所有存储型属性都能获得初始值，它们分别是指定构造器和便利构造器。
/// 指定构造器（designated initializers）是类中最主要的构造器。一个指定构造器将初始化类中提供的所有属性，并根据父类链往上调用父类的构造器来实现父类的初始化。
/// 便利构造器（convenience initializers）是类中比较次要的、辅助型的构造器。你可以定义便利构造器来调用同一个类中的指定构造器，并为其参数提供默认值。你也可以定义便利构造器来创建一个特殊用途或特定输入值的实例。
///
/// convenience init(parameters) {
///    statements
/// }
///

/**
 类的构造器代理规则
 
 为了简化指定构造器和便利构造器之间的调用关系，Swift 采用以下三条规则来限制构造器之间的代理调用：
 
 规则 1
 
 指定构造器必须调用其直接父类的的指定构造器。
 
 规则 2
 
 便利构造器必须调用同一类中定义的其它构造器。
 
 规则 3
 
 便利构造器必须最终导致一个指定构造器被调用。
 
 一个更方便记忆的方法是：
 
 指定构造器必须总是向上代理
 便利构造器必须总是横向代理
 */

class SuperClass {
    var number = 0
}

class Subclass: SuperClass {
    override init() {
        super.init()
        number = 2
    }
}

/*
 构造器的自动继承
 
 如上所述，子类在默认情况下不会继承父类的构造器。但是如果满足特定条件，父类构造器是可以被自动继承的。在实践中，这意味着对于许多常见场景你不必重写父类的构造器，并且可以在安全的情况下以最小的代价继承父类的构造器。
 
 假设你为子类中引入的所有新属性都提供了默认值，以下 2 个规则适用：
 
 规则 1
 
 如果子类没有定义任何指定构造器，它将自动继承所有父类的指定构造器。
 
 规则 2
 
 如果子类提供了所有父类指定构造器的实现——无论是通过规则 1 继承过来的，还是提供了自定义实现——它将自动继承所有父类的便利构造器。
 
 即使你在子类中添加了更多的便利构造器，这两条规则仍然适用。
 */

class Food {
    var name: String
    
    // 3
    // 指定构造器
    init(name: String) {
        self.name = name
    }
    // ⬆️
    // 便利构造器
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

class RecipeIngredient: Food {
    var quantity: Int
    
    // 2
    init(name: String, quantity: Int) {
        self.quantity = quantity;
        super.init(name: name);
    }
    
    // 1
    override convenience init(name: String) {
        self.init(name: name, quantity: 1);
    }
    
}

/// 可失败构造器

struct Animal {
    let species: String
    
    init?(species: String) {
        if species.isEmpty {
            return nil
        }
        self.species = species
    }
}

/// 枚举类型的可失败构造器

enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}

// 也可这么写

//enum TemperatureUnit: Character {
//    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
//}


/// 构造失败的传递

class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}

/// 重写一个可失败构造器
/// 你可以用非可失败构造器重写可失败构造器，但反过来却不行。

class Document {
    var name: String?
    // 该构造器创建了一个 name 属性的值为 nil 的 document 实例
    init() {}
    // 该构造器创建了一个 name 属性的值为非空字符串的 document 实例
    init?(name: String) {
        self.name = name
        if name.isEmpty { return nil }
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}

/// 你可以在子类的非可失败构造器中使用强制解包来调用父类的可失败构造器。比如，下面的UntitledDocument子类的name属性的值总是"[Untitled]"，它在构造过程中使用了父类的可失败构造器init?(name:)：

class UntitledDocument: Document {
    override init() {
        super.init(name: "[Untitled]")!
    }
}

class SomeClass {
    required init() {
        // 构造器的实现代码
    }
}

class SomeSubclass: SomeClass {
    required init() {
        
    }
}


/// 通过闭包或函数设置属性的默认值
/*
class SomeClass2 {
    let someProperty: SomeType = {
        // 在这个闭包中给 someProperty 创建一个默认值
        // someValue 必须和 SomeType 类型相同
        return someValue
    }()
}
*/

/*
 如果你使用闭包来初始化属性，请记住在闭包执行时，实例的其它部分都还没有初始化。这意味着你不能在闭包里访问其它属性，即使这些属性有默认值。同样，你也不能使用隐式的self属性，或者调用任何实例方法
 */

/**
 *  西洋跳棋游戏在一副黑白格交替的10x10的棋盘中进行。为了呈现这副游戏棋盘，Checkerboard结构体定义了一个属性boardColors，它是一个包含100个Bool值的数组。在数组中，值为true的元素表示一个黑格，值为false的元素表示一个白格。数组中第一个元素代表棋盘上左上角的格子，最后一个元素代表棋盘上右下角的格子。
 */
struct Checkerboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad();
        
//        var fah = Fahrenheit()
//        
//        print("The default temperature is \(fah.temperature)° Fahrenheit")

//        let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
//        // boilingPointOfWater.temperatureInCelsius 是 100.0
//        let freezingPointOfWater = Celsius(fromKelvin: 273.15)
//        // freezingPointOfWater.temperatureInCelsius 是 0.0”
        
//        let color = Color.init(1, green: 1, blue: 1)
        
        let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
        cheeseQuestion.ask()
        // 输出 "Do you like cheese?"
        cheeseQuestion.response = "Yes, I do like cheese."
        
     
        let shopping = ShoppingListItem.init()
        print(shopping)
        
//        let twoByTwo = Size.init(width: 2.0, height: 2.0)
        
//        let originRect = Rect.init(origin: Point.init(x: 2, y: 3), size: Size.init(width: 4, height: 4));
        
//        let superC = SuperClass.init()
//        let subC = Subclass.init()
        
//        let nameMeat = Food.init(name: "Bacon");
        
        
        let someCreature = Animal(species: "Giraffe")
        // someCreature 的类型是 Animal? 而不是 Animal
        
        if let giraffe = someCreature {
            print("An animal was initialized with a species of \(giraffe.species)")
        }
        // 打印 "An animal was initialized with a species of Giraffe"
        
        let anonymousCreature = Animal(species: "")
        // anonymousCreature 的类型是 Animal?, 而不是 Animal
        
        if anonymousCreature == nil {
            print("The anonymous creature could not be initialized")
        }
        // 打印 "The anonymous creature could not be initialized"
        
        
        let fahrenheitUnit = TemperatureUnit(symbol: "F")
        if fahrenheitUnit != nil {
            print("This is a defined temperature unit, so initialization succeeded.")
        }
        // 打印 "This is a defined temperature unit, so initialization succeeded."
        
        let unknownUnit = TemperatureUnit(symbol: "X")
        if unknownUnit == nil {
            print("This is not a defined temperature unit, so initialization failed.")
        }
        // 打印 "This is not a defined temperature unit, so initialization failed."
        
        let board = Checkerboard()
        print(board.squareIsBlackAtRow(0, column: 1))
        // 打印 "true"
        print(board.squareIsBlackAtRow(7, column: 7))
        // 打印 "false"
        
        
    }
}

