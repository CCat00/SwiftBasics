/**
 访问控制（Access Control）
 */

public class SomePublicClass {          //显式的 public 类
    public var somePublicProperty = 0   //显式的 public 属性
    var someInternalProperty = 0        //隐式的 internal 属性 <<<<< ****** 注意 *********
    private var somePrivateProperty = 0 //显式的 private 属性
}

class SomeInternalClass {               //隐式的 internal 类
    var someInternalProperty = 0        //隐式的 internal 属性
    private var somePrivateProperty = 0 //显式的 private 属性
}

private class SomePrivateClass {        //显式的 private 类
    var somePrivateProperty = 0         //隐式的 private 属性
    func somePrivateFunc() {}           //隐式的 private 方法
}

// 元组类型
// 元组的访问级别将由元组中访问级别最严格的类型来决定。例如，如果你构建了一个包含两种不同类型的元组，其中一个类型为 internal 级别，另一个类型为 private 级别，那么这个元组的访问级别为 private。”
// 函数类型
// 👇分析：函数的返回值类型是一个元组,根据👆可得：改元组为 private。然后根据 “函数的访问级别根据访问级别最严格的参数类型或返回类型的访问级别来决定” 得出：该函数为 private
// “将该函数指定为 public 或 internal，或者使用默认的访问级别 internal 都是错误的，因为如果把该函数当做 public 或 internal 级别来使用的话，可能会无法访问 private 级别的返回值。”
//private func someFunc() -> (SomeInternalClass, SomePrivateClass) {
//    //...
//}

// 枚举类型 “枚举成员的访问级别和该枚举类型相同，你不能为枚举成员单独指定不同的访问级别。”
public enum CompassPoint {
    case North
    case South
    case East
    case West
}
/*“枚举定义中的任何原始值或关联值的类型的访问级别至少不能低于枚举类型的访问级别。例如，你不能在一个 internal 访问级别的枚举中定义 private 级别的原始值类型。”*/

/*“如果在 private 级别的类型中定义嵌套类型，那么该嵌套类型就自动拥有 private 访问级别。如果在 public 或者 internal 级别的类型中定义嵌套类型，那么该嵌套类型自动拥有 internal 访问级别。如果想让嵌套类型拥有 public 访问级别，那么需要明确指定该嵌套类型的访问级别。”*/

/*“子类的访问级别不得高于父类的访问级别。例如，父类的访问级别是 internal，子类的访问级别就不能是 public。”*/

public class ClassA {
     func somePrivateFunc() {}
}

internal class ClassB: ClassA {
     override internal func somePrivateFunc() {}
}


struct TrackedString {
    // set 是private，get 还是默认的internal
    private(set) var numberOfEdits = 0
    var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
}

//协议的访问级别。 
//定义协议的访问级别，里面的方法和属性和协议访问级别相同。如果是public，里面也是public。
//继承的时候，最高只能是和父协议相同
public protocol SomePublicProtocol {
    
}
//“采纳了协议的类型的访问级别取它本身和所采纳协议两者间最低的访问级别。也就是说如果一个类型是 public 级别，采纳的协议是 internal 级别，那么采纳了这个协议后，该类型作为符合协议的类型时，其访问级别也是 internal。

//如果你采纳了协议，那么实现了协议的所有要求后，你必须确保这些实现的访问级别不能低于协议的访问级别。例如，一个 public 级别的类型，采纳了 internal 级别的协议，那么协议的实现至少也得是 internal 级别。”
























