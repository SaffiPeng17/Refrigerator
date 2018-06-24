//
//  FoodModel.swift
//  Refrigerator
//
//  Created by Saffi on 2018/6/14.
//  Copyright © 2018 Saffi. All rights reserved.
//

import Foundation


enum ClassifiedDefault: String {
    case vegetable = "Vegetable"
    case fruit = "Fruit"
    case meat = "Meat"
    case dairy = "Dairy Products"
    case drink = "Drink"
    case delicatessen = "Delicatessen"
    
    static var strArray: [String] {
        return [self.vegetable.rawValue, self.fruit.rawValue, self.meat.rawValue, self.dairy.rawValue, self.drink.rawValue, self.delicatessen.rawValue]
    }
}
let classifiedStr: ((ClassifiedDefault) -> String) = { classified in
    return classified.rawValue
}

//class Foods {
//    var name: String
//    var period: String
//    var quantity: Int
//    var classified: String
//    var pic: String
//
//    init(name: String, period: String, quantity: Int, classified: String, pic: String) {
//        self.name = name
//        self.period = period
//        self.quantity = quantity
//        self.classified = classified
//        self.pic = pic
//    }
//}

//Models
var classifiedArray: [String] {
    var array = ClassifiedDefault.strArray
    let cusClassifieds = Coredata.shared.readClassified(fetchLimit: nil, predicate: nil, sortBy: nil)
    if cusClassifieds.count > 0 {
        for cusClassified in cusClassifieds {
            array.append(cusClassified.name!)
        }
    }
    print("array = \(array)")
    return array
}

var foodDict: [String: [Record]] {
    var dict = [String: [Record]]()
    let records = Coredata.shared.readRecord(fetchLimit: nil, predicate: nil, sortBy: nil)
    if records.count > 0 {
        for classified in classifiedArray {
            var array = [Record]()
            for record in records {
                if classified == record.classified {
                    array.append(record)
                }
            }
            dict.updateValue(array, forKey: classified)
        }
    } else {
        for classified in classifiedArray {
            dict.updateValue([Record](), forKey: classified)
        }
    }
    return dict
}

//Mock
//var foods: [Foods] = [
//    Foods(name: "Onion", period: "2018-8-20", quantity: 3, classified: classifiedStr(.vegetable), pic: "onion.jpg"),
//    Foods(name: "Watermelon", period: "2018-7-31", quantity: 1, classified: classifiedStr(.fruit), pic: "watermelon.jpg"),
//    Foods(name: "Banana", period: "2018-7-28", quantity: 10, classified: classifiedStr(.fruit), pic: "banana.jpg"),
//    Foods(name: "Grapefruit", period: "2018-7-16", quantity: 2, classified: classifiedStr(.fruit), pic: "grapefruit.jpg"),
//    Foods(name: "Pumpkin", period: "2018-8-7", quantity: 1, classified: classifiedStr(.vegetable), pic: "pumpkin.jpg"),
//
//    Foods(name: "Potato", period: "2018-8-2", quantity: 5, classified: classifiedStr(.vegetable), pic: "potato.jpg"),
//    Foods(name: "Carrot", period: "2018-8-16", quantity: 3, classified: classifiedStr(.vegetable), pic: "carrot.jpg"),
//    Foods(name: "Cabbage", period: "2018-8-1", quantity: 1, classified: classifiedStr(.vegetable), pic: "cabbage.jpg"),
//    Foods(name: "Cucumber", period: "2018-8-3", quantity: 3, classified: classifiedStr(.vegetable), pic: "cucumber.jpg"),
//    Foods(name: "Pea", period: "2018-8-1", quantity: 1, classified: classifiedStr(.vegetable), pic: "pea.jpg"),
//
//    Foods(name: "Chicken", period: "2018-7-29", quantity: 1, classified: classifiedStr(.meat), pic: "chicken.jpg"),
//    Foods(name: "Beef", period: "2018-7-30", quantity: 3, classified: classifiedStr(.meat), pic: "beef.jpg"),
//    Foods(name: "Cheese", period: "2018-8-20", quantity: 3, classified: classifiedStr(.dairy), pic: "cheese.jpg"),
//    Foods(name: "Butter", period: "2018-8-19", quantity: 1, classified: classifiedStr(.dairy), pic: "butter.jpg"),
//    Foods(name: "Ham", period: "2018-8-15", quantity: 7, classified: classifiedStr(.meat), pic: "ham.jpg"),
//
//    Foods(name: "Sausage", period: "2018-7-29", quantity: 5, classified: classifiedStr(.meat), pic: "sausage.jpg"),
//    Foods(name: "Milk", period: "2018-7-30", quantity: 1, classified: classifiedStr(.dairy), pic: "milk.jpg"),
//    Foods(name: "Black Tea", period: "2018-8-20", quantity: 10, classified: classifiedStr(.drink), pic: "blacktea.jpg"),
//    Foods(name: "Curry", period: "2018-8-19", quantity: 1, classified: classifiedStr(.delicatessen), pic: "curry.jpg"),
//    Foods(name: "Spaghetti", period: "2018-8-15", quantity: 2, classified: classifiedStr(.delicatessen), pic: "spaghetti.jpg"),
//
//    Foods(name: "Juice", period: "2018-8-12", quantity: 1, classified: classifiedStr(.drink), pic: "juice.jpg")
//]

