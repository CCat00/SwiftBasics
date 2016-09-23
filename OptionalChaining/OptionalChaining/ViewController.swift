//
//  ViewController.swift
//  OptionalChaining
//
//  Created by 韩威 on 2016/9/13.
//  Copyright © 2016年 韩威. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let john = Person();
        // 强制解包如果为空会出错
        // fatal error: unexpectedly found nil while unwrapping an Optional value
        // let roomCount = john.residence!.numberOfRooms;
        // 可选式调用 把叹号替换为问号 如果返回没有值就返回nil
        
//         当residence为nil的时候，可选的Int将会为nil，表明无法访问numberOfRooms。访问成功时，可选的Int值会通过可选绑定展开，并赋值给非可选类型的roomCount常量。
//         
//         要注意的是，即使numberOfRooms是非可选的Int时，这一点也成立。只要使用可选链式调用就意味着numberOfRooms会返回一个Int?而不是Int。
 
//        if let roomCount = john.residence?.numberOfRooms {
//            print("John's residence has \(roomCount) room(s).")
//        } else {
//            print("Unable to retrieve the number of rooms.")
//        }
//        // 打印 “Unable to retrieve the number of rooms.”
        
        
        let someAddress = Address();
        someAddress.buildingName = "德鑫嘉园"
        someAddress.buildingNumber = "401"
        someAddress.street = "槐房北路"
        
        let john = Person()
        // 这行代码无法设置address，因为residence这个属性就为nil
        // set方法和等号右边的式子都并未执行
        john.residence?.address = someAddress
        
        // printNumberOfRooms 这个方法看似没有返回值，其实是返回 Void 类型，这里用可选链式调用就是返回Void？类型因此可以用来作为判断条件
        if john.residence?.printNumberOfRooms() != nil {
            print("It was possible to print the number of rooms.")
        } else {
            print("It was not possible to print the number of rooms.")
        }
        // 打印 “It was not possible to print the number of rooms.”
        
        // 通过可选链式调用访问下标
        if (john.residence?[0].name) != nil {
            
        } else {
            
        }
        
        let johnsHouse = Residence();
        johnsHouse.rooms.append(Room.init(name: "Living Room"));
        johnsHouse.rooms.append(Room.init(name: "Kitchen"))
        john.residence = johnsHouse;
        
        
//        let johnsHouse = Residence()
//        johnsHouse.rooms.append(Room(name: "Living Room"))
//        johnsHouse.rooms.append(Room(name: "Kitchen"))
//        john.residence = johnsHouse
//        
//        if let firstRoomName = john.residence?[0].name {
//            print("The first room name is \(firstRoomName).")
//        } else {
//            print("Unable to retrieve the first room name.")
//        }
        // 打印 “The first room name is Living Room.”
        
        // 访问可选类型的下标
        var testSource = ["key1" : [1, 2], "key2" : [1, 2, 3]]
        _ = testSource["key1"]?[0]
        
        testSource["key2"]?[1] += 2
        
        // 连接多层可选链式调用
//        通过可选连调用的返回值是可选类型
        
        
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

class Person {
    
    /// 住所
    var residence: Residence?
}


/// 住宅
class Residence {
    
    var rooms = [Room]()
    
    var numberOfRooms: Int {
        return rooms.count;
    }
    
    subscript(i: Int) -> Room {
        get {
            return rooms[i];
        }
        set {
            rooms[i] = newValue;
        }
    }
    
    func printNumberOfRooms() {
        print("the number of rooms is \(self.numberOfRooms)");
    }
    
    var address: Address?
}

class Room {
    let name: String
    init(name: String) {
        self.name = name;
    }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    
    func buildIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil && street != nil {
            return "\(buildingNumber) \(street)"
        } else {
            return nil
        }
    }
}


