/**
 扩展（Extensions）
 */

// 扩展就是对已有的类、结构体、枚举和协议添加新功能。这包括在没有获取到源代码的情况下扩展类型的能力（即 逆向建模）。和oc的类目类似。swift中的扩展没有名字。

//extension sometype {
//    
//}

// 计算型属性 （Computed Properties）
extension Double {
    /// get可省略
    var km: Double { get { return self * 1_000.0 } }
    var m : Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    /// 英尺 1m = 3.28084ft
    var ft: Double { return self / 3.28084 }
}

let ss = 15.0.cm
print("15cm is \(ss)m")

let oneFeet = 3.ft

/////////////////////////////////////////////

//class Person {
//    
//}
//
//
//
//extension Person {
//    var test: String {
//        get {
//            return objc_getAssociatedObject(self, &pointer) as! String
//        }
//        set {
//            objc_setAssociatedObject(self, &pointer, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
//        }
//    }
//}

/////////////////////////////////////////////

// 构造器 (Initializers)
// 扩展能为类添加新的便利构造器，但是它们不能为类添加新的指定构造器或析构器。指定构造器和析构器必须总是由原始的类实现来提供。

struct Size {
    var width = 0.0, height = 0.0
}

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var size = Size();
    var point = Point();
}

// 默认构造器
let rect = Rect()
print(rect)

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - size.width / 2.0
        let originY = center.y - size.height / 2.0
        self.init(size: size, point: Point.init(x: originX, y: originY))
    }
}

// 方法 （Methods）

extension Int {
    func repetitions(task: ()->Void) {
        for _ in 0..<self {
            task()
        }
    }
}


3.repetitions {
    print("重要的事情说三遍！！！")
}

// 可变实例方法

extension Int {
    mutating func square() {
        self = self * self
    }
    
    // 下标（subscripts）
    
    subscript(index: Int) -> Int{
        var decimalBase = 1
        for _ in 0..<index {
            decimalBase *= 10
        }
        
        return (self / decimalBase) % 10
    }
}

var three = 3;
three.square()
print("\(three)")


let aaa = 123[2]

// 嵌套类型

extension Int {
    enum Kind {
        case Negative, Zero, Positive
    }
    
    var kind :Kind {
        
        switch self {
        case 0:
            return .Zero
        case let x where x > 0:
            return .Positive
        default:
            return .Negative
        }
    }
    
}


func printIntegerKinds(numbers: [Int])
{
    for number in numbers {
        switch number.kind {
        case .Positive:
            print("+ ", terminator: "")
        case .Zero:
            print("0 ", terminator: "")
        case .Negative:
            print("- ", terminator: "")
        }
    }
    print("")
}

printIntegerKinds(numbers: [-10,0,10,20,-30])



