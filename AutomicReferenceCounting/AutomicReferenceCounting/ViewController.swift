//
//  ViewController.swift
//  AutomicReferenceCounting
//
//  Created by 韩威 on 16/9/7.
//  Copyright © 2016年 韩威. All rights reserved.
//

/// 自动引用计数(ARC)

class Person {
    let name: String
    
    init(name: String) {
        self.name = name;
        print("person init")
    }
    
    var apartment: Apartment?
    
    deinit {
        print("person deinit")
    }
}

class Apartment {
    let unit: String
    init(unit: String) {
        self.unit = unit;
        print("apartment init")
    }
    
    // 这里加weak就是弱引用，防止循环引用
    weak var ower: Person?
    
    deinit {
        print("apartment deinit")
    }
}

/// 无主类型

class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
    // CreditCard类的number属性被定义为UInt64类型而不是Int类型，以确保number属性的存储量在 32 位和 64 位系统上都能足够容纳 16 位的卡号。
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number;
        self.customer = customer;
    }
    
    deinit {
        print("Card #\(number) is being deinitialized")
    }
    
}

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var p1: Person?
//        var p2: Person?
//        var p3: Person?
//        
//        p1 = Person.init(name: "name1")
//        //log: init
//        p2 = p1;
//        p3 = p1;
//        
//        p1 = nil;
//        p2 = nil;
//        
//        p3 = nil;
//        //log: deinit
        
//        var john: Person?
//        var apartment: Apartment?
//        
//        john = Person.init(name: "john")
//        apartment = Apartment.init(unit: "501")
//        
//        john!.apartment = apartment;
//        apartment!.ower = john
//        
//        //这里强制释放 john对apartment的引用
//        //john!.apartment = nil;
//        john = nil;
//        apartment = nil;
        
        // 无主引用
        /*
         和弱引用类似，无主引用不会牢牢保持住引用的实例。和弱引用不同的是，无主引用是永远有值的。因此，无主引用总是被定义为非可选类型（non-optional type）。你可以在声明属性或者变量时，在前面加上关键字unowned表示这是一个无主引用。
         
         由于无主引用是非可选类型，你不需要在使用它的时候将它展开。无主引用总是可以被直接访问。不过 ARC 无法在实例被销毁后将无主引用设为nil，因为非可选类型的变量不允许被赋值为nil。
         */
        
        
        
        //以上的意义在于你可以通过一条语句同时创建Country和City的实例，而不产生循环强引用，并且capitalCity的属性能被直接访问，而不需要通过感叹号来展开它的可选值：
        // 在上面的例子中，使用隐式解析可选值意味着满足了类的构造函数的两个构造阶段的要求。capitalCity属性在初始化完成后，能像非可选值一样使用和存取，同时还避免了循环强引用。
        
//        var country: Country
//        country = Country.init(name: "中国", capitalName: "北京")
        
        
        /*
         循环强引用还会发生在当你将一个闭包赋值给类实例的某个属性，并且这个闭包体中又使用了这个类实例时。这个闭包体中可能访问了实例的某个属性，例如self.someProperty，或者闭包中调用了实例的某个方法，例如self.someMethod()。这两种情况都导致了闭包“捕获”self，从而产生了循环强引用。
         
         */

//        
//        let heading = HTMLElement(name: "h1")
//        let defaultText = "some default text"
//        heading.asHTML = {
//            return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
//        }
//        print(heading.asHTML())
//         打印 “<h1>some default text</h1>”
        
        var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
        print(paragraph!.asHTML())
        // 打印 “<p>hello, world</p>”
        paragraph = nil;
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

/*
 Person和Apartment的例子展示了两个属性的值都允许为nil，并会潜在的产生循环强引用。这种场景最适合用弱引用来解决。
 
 Customer和CreditCard的例子展示了一个属性的值允许为nil，而另一个属性的值不允许为nil，这也可能会产生循环强引用。这种场景最适合通过无主引用来解决。
 
 ** 然而，存在着第三种场景，在这种场景中，两个属性都必须有值，并且初始化完成后永远不会为nil。在这种场景中，需要一个类使用无主属性，而另外一个类使用隐式解析可选属性。
 ** 下面的例子定义了两个类，Country和City，每个类将另外一个类的实例保存为属性。在这个模型中，每个国家必须有首都，每个城市必须属于一个国家。为了实现这种关系，Country类拥有一个capitalCity属性，而City类有一个country属性：
 */


class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

/// 闭包引起的循环强引用
/*
 // 1.定义捕获列表
 lazy var someClosure: (Int, String) -> String = {
 [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
 // 这里是闭包的函数体
 }
 
 如果闭包没有指明参数列表或者返回类型，即它们会通过上下文推断，那么可以把捕获列表和关键字in放在闭包最开始的地方：
 
 lazy var someClosure: (Int, String) -> String = {
 [unowned self, weak delegate = self.delegate!]  in
 // 这里是闭包的函数体
 }
 
 // 2.弱引用和无主引用
 在闭包和捕获的实例总是互相引用并且总是同时销毁时，将闭包内的捕获定义为无主引用。
 
 相反的，在被捕获的引用可能会变为nil时，将闭包内的捕获定义为弱引用。弱引用总是可选类型，并且当引用的实例被销毁后，弱引用的值会自动置为nil。这使我们可以在闭包体内检查它们是否存在。
 


 
 */

class HTMLElement {
    
    let name: String
    let text: String?
    
    lazy var asHTML: Void -> String = {
        
        // 解决循环引用
        // 这里，捕获列表是[unowned self]，表示“将self捕获为无主引用而不是强引用”。
        [unowned self] in
        
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
    
}

