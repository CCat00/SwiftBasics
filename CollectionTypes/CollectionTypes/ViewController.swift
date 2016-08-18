//
//  ViewController.swift
//  CollectionTypes
//
//  Created by 韩威 on 16/8/18.
//  Copyright © 2016年 韩威. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    //MARK: - 生命周期
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: - 手势事件
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //arrayTest()
        
        //setTest()
        
        dictionaryTest()
        
    }
    
    /**
     字典
     */
    func dictionaryTest() -> Void {
        
        var dictonary = [Int: String]()
        
        dictonary[16] = "sixteen"
        
        dictonary.updateValue("ss", forKey: 16)
        
        dictonary.updateValue("kk", forKey: 18)
        
        
        
        
        for (key, value) in dictonary {
            print("key = \(key), value = \(value)")
        }

    }
    
    /**
     集合
     */
    func setTest() {
    
    }
    
    /**
     数组
     */
    func arrayTest() {
        
        //数组
        var someInts = [Int]()
        print("someInts is of type [Int] with \(someInts.count) items.")
        
        someInts.append(1)
        // someInts now contains 1 value of type Int
        someInts = []
        // someInts is now an empty array, but is still of type [Int]
        
        
        let threeDoubles = [Double](count: 3, repeatedValue: 0.0)
        // threeDoubles is of type [Double], and equals [0.0, 0.0, 0.0]
        
        let anotherThreeDoubles = [Double](count: 3, repeatedValue: 2.5)
        // anotherThreeDoubles is of type [Double], and equals [2.5, 2.5, 2.5]
        
        let sixDoubles = threeDoubles + anotherThreeDoubles
        // sixDoubles is inferred as [Double], and equals [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]
        
        print(sixDoubles)
        
        //var shoppingList: [String] = ["Eggs", "Milk"]
        // shoppingList has been initialized with two initial items

        var shoppingList = ["Eggs", "Milk"]
        
        print("The shopping list contains \(shoppingList.count) items.")
        // Prints "The shopping list contains 2 items."

        if shoppingList.isEmpty {
            print("The shopping list is empty.")
        } else {
            print("The shopping list is not empty.")
        }
        // Prints "The shopping list is not empty."

        shoppingList.append("Flour")
        
        shoppingList += ["Baking Powder"]
        // shoppingList now contains 4 items
        shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
        // shoppingList now contains 7 items
        
        var firstItem = shoppingList[0]
        // firstItem is equal to "Eggs"
        
        shoppingList[0] = "Six eggs"
        // the first item in the list is now equal to "Six eggs" rather than "Eggs"
        
        
        shoppingList[4...6] = ["Bananas", "Apples"]
        // shoppingList now contains 6 items
        
        shoppingList.insert("Maple Syrup", atIndex: 0)
        // shoppingList now contains 7 items
        // "Maple Syrup" is now the first item in the list
        
        
        let mapleSyrup = shoppingList.removeAtIndex(0)
        // the item that was at index 0 has just been removed
        // shoppingList now contains 6 items, and no Maple Syrup
        // the mapleSyrup constant is now equal to the removed "Maple Syrup" string
        
        firstItem = shoppingList[0]
        // firstItem is now equal to "Six eggs"
        
        let apples = shoppingList.removeLast()
        // the last item in the array has just been removed
        // shoppingList now contains 5 items, and no apples
        // the apples constant is now equal to the removed "Apples" string
        
        
        for item in shoppingList {
            print(item)
        }
        
        
        for (index, value) in shoppingList.enumerate() {
            print("Item \(index + 1): \(value)")
        }
        // Item 1: Six eggs
        // Item 2: Milk
        // Item 3: Flour
        // Item 4: Baking Powder
        // Item 5: Bananas

    }
    
    
    //MARK: - UITextFieldDelegate
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if string == "" {
            
            return true
            
        } else {
            
            return false
        }
    }
}







