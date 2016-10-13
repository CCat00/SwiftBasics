//
//  ViewController.swift
//  Protocols
//
//  Created by 韩威 on 2016/10/13.
//  Copyright © 2016年 韩威. All rights reserved.
//

import UIKit

protocol SomeProtocl {
    //变量属性，必须要用 var 声明。
    var mustBeSettable: Int {set get}
    var justGet: Int {get}
    
    // 类型属性必须要用 static 声明
    static var staticVar: Int {set get}
    
    // 类方法可以用 static ////还可以用 class
    
//    class func someFun() swift3有问题
    static func somFun2()
}

protocol FullNamed {
    var fullName: String {get}
}

struct Person: FullNamed {
    var fullName: String
}


/*
 Mutating 方法要求
 有时需要在方法中改变方法所属的实例。例如，在值类型（即结构体和枚举）的实例方法中，将 mutating 关键字作为方法的前缀，写在 func 关键字之前，表示可以在该方法中修改它所属的实例以及实例的任意属性的值。这一过程在在实例方法中修改值类型章节中有详细描述。
 
 如果你在协议中定义了一个实例方法，该方法会改变采纳该协议的类型的实例，那么在定义协议时需要在方法前加 mutating 关键字。这使得结构体和枚举能够采纳此协议并满足此方法要求。
 
 注意
 实现协议中的 mutating 方法时，若是类类型，则不用写 mutating 关键字。而对于结构体和枚举，则必须写 mutating 关键字。

 */


protocol MutatingProtocol {
    mutating func change()
}

struct SomeStruct: MutatingProtocol{
    var vara: Int
    mutating func change() {
        //
        self.vara = 1;
    }
}


// 构造器要求

protocol InitProtocol {
    init(ss: Int)
}

class ViewController: UIViewController/*, MutatingProtocol, InitProtocol */{
    
//    func change() {
//        //
//    }
//    
//    //MARK:InitProtocol
//    required init(ss: Int) {
//        //
//        super.init(nibName: "", bundle: Bundle.main)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    
//    internal static var staticVar: Int
//
//    internal var justGet: Int = 0
//
//    internal var mustBeSettable: Int = 0
//
//    
//    static func somFun2() {
//        //
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var john = Person(fullName: "john")
        john.fullName = ""
        
//        let r = 8/2
//        let q = 8/3.0
//        let w = 8%5
////
//        let ss = 8.0.truncatingRemainder(dividingBy: 5)
//        print(ss)
        
        
//        var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
//        for _ in 1...5 {
//            print("Random dice roll is \(d6.roll())")
//        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let snackAndLadder = SnacksAndLadders.init()
        /// 3、设置代理
        snackAndLadder.delegate = DiceGameTracker.init()
        snackAndLadder.play()
        
        
        /*
         Started a new game of Snacks and Ladders
         The game is using a 6-sided dice
         Rolled a 3
         Rolled a 5
         Rolled a 4
         Rolled a 5
         The game Lasted for 4 turns
         */
        
        let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
        print("\(d12.textualDescription)")
        /*
         A 12-sided dice.
         */
        
        print(snackAndLadder.prettyTextualDescription)
        
        /*
         A Snack and Ladder games of 25:
         0️⃣0️⃣🔼0️⃣0️⃣🔼0️⃣0️⃣🔼🔼0️⃣0️⃣0️⃣🔽0️⃣0️⃣0️⃣0️⃣🔽0️⃣0️⃣🔽0️⃣🔽0️⃣
         */
        
        let objects: [AnyObject] = [
            Circle.init(radius: 2.0),
            Country.init(area: 5),
            Animal.init(legs: 2),
            ]
        for object in objects {
            if let objWithArea = object as? HasArea {
                print("Area is \(objWithArea.area)")
            } else {
                print("something that doesn't have an area")
            }
        }
        
        /*
         Area is 12.5663706143592
         Area is 5.0
         something that doesn't have an area
         */
        
        
        let murrayTheHamster = Hamster(name: "Murray")
        let morganTheHamster = Hamster(name: "Morgan")
        let mauriceTheHamster = Hamster(name: "Maurice")
        let hamsters = [murrayTheHamster, morganTheHamster, mauriceTheHamster]
    // 因为 Array 符合 CollectionType 协议，而数组中的元素又符合 TextRepresentable 协议，所以数组可以使用 textualDescription 属性得到数组内容的文本表示：
        print(hamsters.textualDescription)
        // Prints "[A hamster named Murray, A hamster named Morgan, A hamster named Maurice]"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy: m))
        return lastRandom / m
    }
}

// 协议作为类型

protocol RandomNumberGenerator {
    func random() -> Double
}




// 委托代理模式

// 委托是一种设计模式，它允许类或结构体将一些需要他们负责的功能委托给其他类型的实例。委托模式的实现很简单：定义协议来封装那些需要被委托的功能，这样就能确保采纳协议的类型提供这些功能。委托设计模式可以用来相应特定的动作，或者接收外部数据源的数据，而无需关心外部数据源的类型。

/// 🎲
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

/// 🎲游戏
protocol DiceGame {
    var dice: Dice {get}
    func play()
}

/// 1、声明代理方法
protocol DiceGameDelegate: class {
    func gameDidStart(game: DiceGame)
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(game: DiceGame)
}

/// 🐍和楼梯的游戏
class SnacksAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init () {
        board = [Int].init(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02;
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08;
    }
    weak var delegate: DiceGameDelegate?
    
    func play() {
        square = 0;
        delegate?.gameDidStart(game: self)
        // 到25格就结束了
        gameLoop: while square != finalSquare {
            /// 掷骰子的结果
            let diceRoll = dice.roll()
            delegate?.game(game: self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop;
            case let newSquare where newSquare > finalSquare:
                continue gameLoop;
            default:
                //走几格
                square += diceRoll
                //加或减相应的格数
                square += board[square]
            }
        }
        delegate?.gameDidEnd(game: self)
    }
}

/// 2、签协议
class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    
    /// 3、实现代理
    // MARK: DiceGameDelegate
    func gameDidStart(game: DiceGame) {
        numberOfTurns = 0
        if game is SnacksAndLadders {
            print("Started a new game of Snacks and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    
    func gameDidEnd(game: DiceGame) {
        print("The game Lasted for \(numberOfTurns) turns")
    }
}



////////////////////////////////////////////////////////////////////////////////////////////////
// 通过扩展添加协议一致性
////////////////////////////////////////////////////////////////////////////////////////////////

protocol TextRepresentable {
    var textualDescription: String { get }
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice."
    }
}

// 上面👆这个例子，可以适用于，不知道一个类的实现的时候，对他进行扩展一个协议。现在所有的Dice实例都可看做TextRepresentable类型

// 通过扩展采纳协议

struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}

// 当一个类型已经符合了某个协议的所有却还没有声明采纳改协议时，可以通过空扩展体实现
// 只有声明了这句话，才能知道，Hamster，是属于 TextRepresentable 类型的，即使已经实现了协议的所有方法
extension Hamster: TextRepresentable {}

// 协议类型的集合 
class test {
    func test1() {
        let hamster = Hamster(name: "sss")
        let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
        let things: [TextRepresentable] = [hamster, d12]
        for thing in things {
            print(thing.textualDescription)
        }
    }
}

// 协议的继承
// MARK:-
protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

extension SnacksAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A Snack and Ladder games of \(finalSquare)"
    }
}

extension SnacksAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "🔼"
            case let ladder where ladder < 0:
                output += "🔽"
            default:
                output += "0️⃣"
            }
        }
        return output
    }
}

// 类类型专属协议Inherited
protocol SomeInheritedProtocol: class {
    
}

protocol SomeClassOnlyProtocol: class , SomeInheritedProtocol {
    
}

class SomeClass1: SomeInheritedProtocol {
    
}

// 协议合成

protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: UInt { get }
}

struct PersonAnother: Named, Aged {
    var name: String
    var age: UInt
}

class AAAJJJJJ {
    func wishHappyBirthday(to celebrator: Named & Aged) -> () {
        print("Happy birthday , \(celebrator.name), you're \(celebrator.age)!")
    }
    
}

/*
 wishHappyBirthday(_:) 函数的参数 celebrator 的类型为 Named & Aged。这意味着它不关心参数的具体类型，只要参数符合这两个协议即可。
 
 上面的例子创建了一个名为 birthdayPerson 的 Person 的实例，作为参数传递给了 wishHappyBirthday(_:) 函数。因为 Person 同时符合这两个协议，所以这个参数合法，函数将打印生日问候语。
 
 注意
 协议合成并不会生成新的、永久的协议类型，而是将多个协议中的要求合成到一个只在局部作用域有效的临时协议中。
 */

// 检查协议的一致性
/*
 is 用来检查实例是否符合某个协议，若符合则返回 true，否则返回 false。
 as? 返回一个可选值，当实例符合某个协议时，返回类型为协议类型的可选值，否则返回 nil。
 as! 将实例强制向下转换到某个协议类型，如果强转失败，会引发运行时错误。
 */

protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = M_PI
    var radius: Double
    var area: Double { return M_PI * radius * radius }
    init(radius: Double) {
        self.radius = radius
    }
}

class Country: HasArea {
    var area: Double
    init(area: Double) {
        self.area = area
    }
}

class Animal {
    var legs: UInt
    init(legs: UInt) {
        self.legs = legs
    }
}

class JJJJJ {
    func JJJJJMM() {
        
    }
}

// 可选的协议要求
@objc protocol CounterDataSource {
    @objc optional func incrementForCount(count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

// 协议扩展
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

// 提供默认实现
extension PrettyTextRepresentable {
    var prettyTextualDescription: String {
        return textualDescription
    }
}

// 为协议扩展添加限制条件
extension Collection where Iterator.Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}











