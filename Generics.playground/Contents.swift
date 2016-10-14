/**
 Generics(泛型)
 */

/// 交换两个Int值
func swapTwoInts(_ a: inout Int,_ b: inout Int)
{
    let temp = a;
    a = b;
    b = temp;
}

var a = 3; var b = 4;
swap(&a, &b)
print("a is \(a), b is \(b)")

// 泛型函数
// 对上面函数改造，使其能够交换，字符串，double，等
func swapTwoValues<T>(_ a: inout T, _ b: inout T)
{
    let temp = a;
    a = b;
    b = temp;
}

var a2 = "world", b2 = "hello"
swapTwoValues(&a2, &b2)
print("a2 is \(a2), b2 is \(b2)")

//swift中有标准函数
//swap(&<#T##a: T##T#>, &<#T##b: T##T#>)

// 类型参数
/*
 命名类型参数
 在大多数情况下，类型参数具有一个描述性名字，例如 Dictionary<Key, Value> 中的 Key 和 Value，以及 Array<Element> 中的 Element，这可以告诉阅读代码的人这些类型参数和泛型函数之间的关系。然而，当它们之间没有有意义的关系时，通常使用单个字母来命名，例如 T、U、V，正如上面演示的 swapTwoValues(_:_:) 函数中的 T 一样。
 
 注意
 请始终使用大写字母开头的驼峰命名法（例如 T 和 MyTypeParameter）来为类型参数命名，以表明它们是占位类型，而不是一个值
 */

// 编写一个 stack（栈）先进后出
//struct IntStack {
//    var items: [Int]
//    mutating func push(_ item: Int) {
//        items.append(item)
//    }
//    
//    mutating func pop() -> Int {
//        return items.removeLast()
//    }
//}

struct Stack<Element> {
    var items: [Element]
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>.init(items: [String]())
stackOfStrings.push("h")
stackOfStrings.push("w")
stackOfStrings.push("o")
let lastString = stackOfStrings.pop()
print(lastString)
print(stackOfStrings)

// 扩展一个泛型类型
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

print(stackOfStrings.topItem)

// 类型约束

//Dictionary<Key : Hashable, Value>

/*
func someFunc<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
    
}
*/

func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

// 注意 T: Equatable ，如果不这么写。 value == valueToFind 这会报错。
func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

// 关联类型
protocol Container {
    associatedtype ItmeType
    mutating func append(_ item: ItmeType)
    var count: Int { get }
    subscript(i: Int) -> ItmeType { get }
}

struct IntStack: Container {
    var items: [Int]
    mutating func push(_ item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
    // MARK: Container
    
    typealias ItmeType = Int
    
    mutating func append(_ item: Int) {
        self.push(item)
    }
    
    var count: Int {
        return self.items.count
    }
    
    subscript(i: Int) -> Int {
        return items[i]
    }
}

extension Array: Container {}

/// where 子句

func allItemsMatch<C1: Container,C2: Container>
    (_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.ItmeType == C2.ItmeType, C1.ItmeType: Equatable {
        
        if someContainer.count != anotherContainer.count {
            return false
        }
        
        for i in 0..<anotherContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }
        
        return true
}

//extension Stack: Container {
//    internal var count: Int {
//        <#code#>
//    }
//
//    typealias ItmeType = <#type#>
//}

var intStrucks = IntStack.init(items: [Int]())
intStrucks.push(1)
intStrucks.push(2)
intStrucks.push(3)

var arrayOfInts = [1, 2, 3]

let res = allItemsMatch(arrayOfInts, intStrucks)
print(res)




