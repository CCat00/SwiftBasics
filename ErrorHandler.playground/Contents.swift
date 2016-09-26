/**
 错误处理（Error Handler）
 */

enum VendingMachineError: Error {
    case InvalidSelection                       //选择无效
    case InsufficientFunds(coinsNeeded: Int)    //金额不足
    case OutOfStock                             //无货
}

// test
//throw VendingMachineError.InsufficientFunds(coinsNeeded: 5)

//func canThrowErrors() throws -> Void {
//}

struct Item {
    var priec: Int
    var count: Int
}

class VendingMachine {
    // 存货
    var inventory = [
        "Candy Bar" : Item(priec: 12, count: 7),
        "Chips" : Item(priec: 10, count: 4),
        "pretzels" : Item(priec: 7, count: 11)
    ]
    
    //金币存放
    var coinsDeposited = 0;
    
    func dispenseSnack(snack: String) -> Void {
        print("Dispense \(snack)")
    }
    
    //售卖
    func vend(itemNamed name: String) throws -> Void {
        guard let item = inventory[name] else {
            throw VendingMachineError.InvalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.OutOfStock
        }
        
        guard item.priec <= coinsDeposited else {
            throw VendingMachineError.InsufficientFunds(coinsNeeded: item.priec - coinsDeposited)
        }
        
        coinsDeposited -= item.priec
        
        var newItem = item
        newItem.count -= 1
        
        inventory[name] = newItem
        
        dispenseSnack(snack: name)
    }
}

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}
//do {
//    try expression
//    statements
//} catch pattern 1 {
//    statements
//} catch pattern 2 where condition {
//    statements
//}

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
} catch VendingMachineError.InvalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.OutOfStock {
    print("Out of Stock.")
} catch VendingMachineError.InsufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
}
// 打印 “Insufficient funds. Please insert an additional 2 coins.”


//将错误转换成可选值

//func someThrowingFunction() throws -> Int {
//    // ...
//}
//
//let x = try? someThrowingFunction()
//
//let y: Int?
//do {
//    y = try someThrowingFunction()
//} catch {
//    y = nil
//}

// x，y 都是可选整形
// `try?` 表示失败了就返回`nil`


// 禁用错误传递

//let photo = try! loadImage("./Resources/John Appleseed.jpg")


// 指定清理操作
//func processFile(filename: String) throws {
//    if exists(filename) {
//        let file = open(filename)
//        defer {
//            close(file)
//        }
//        while let line = try file.readline() {
//            // 处理文件。
//        }
//        // close(file) 会在这里被调用，即作用域的最后。
//    }
//}

// 如果有多个 `defer` , 先写的最后执行，后写的先执行。
