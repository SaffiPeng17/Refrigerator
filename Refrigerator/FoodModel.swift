//
//  FoodModel.swift
//  Refrigerator
//
//  Created by Saffi on 2018/6/14.
//  Copyright © 2018 Saffi. All rights reserved.
//

import Foundation

class Foods {
    var name = ""
    var period = ""
    var quantity = 0
    var pic = ""
    
    init(name: String, period: String, quantity: Int, pic: String) {
        self.name = name
        self.period = period
        self.quantity = quantity
        self.pic = pic
    }
}

//Models
var foods: [Foods] = [
    Foods(name: "Onion", period: "2017-8-20", quantity: 3, pic: "onion.jpg"),
    Foods(name: "Watermelon", period: "2017-7-31", quantity: 1, pic: "watermelon.jpg"),
    Foods(name: "Banana", period: "2017-7-28", quantity: 10, pic: "banana.jpg"),
    Foods(name: "Grapefruit", period: "2017-7-16", quantity: 2, pic: "grapefruit.jpg"),
    Foods(name: "Pumpkin", period: "2017-8-7", quantity: 1, pic: "pumpkin.jpg"),

    Foods(name: "Potato", period: "2017-8-2", quantity: 5, pic: "potato.jpg"),
    Foods(name: "Carrot", period: "2017-8-16", quantity: 3, pic: "carrot.jpg"),
    Foods(name: "Cabbage", period: "2017-8-1", quantity: 1, pic: "cabbage.jpg"),
    Foods(name: "Cucumber", period: "2017-8-3", quantity: 3, pic: "cucumber.jpg"),
    Foods(name: "Pea", period: "2017-8-1", quantity: 1, pic: "pea.jpg"),

    Foods(name: "Chicken", period: "2017-7-29", quantity: 1, pic: "chicken.jpg"),
    Foods(name: "Beef", period: "2017-7-30", quantity: 3, pic: "beef.jpg"),
    Foods(name: "Cheese", period: "2017-8-20", quantity: 3, pic: "cheese.jpg"),
    Foods(name: "Butter", period: "2017-8-19", quantity: 1, pic: "butter.jpg"),
    Foods(name: "Ham", period: "2017-8-15", quantity: 7, pic: "ham.jpg"),

    Foods(name: "Sausage", period: "2017-7-29", quantity: 5, pic: "sausage.jpg"),
    Foods(name: "Milk", period: "2017-7-30", quantity: 1, pic: "milk.jpg"),
    Foods(name: "Black Tea", period: "2017-8-20", quantity: 10, pic: "blacktea.jpg"),
    Foods(name: "Curry", period: "2017-8-19", quantity: 1, pic: "curry.jpg"),
    Foods(name: "Spaghetti", period: "2017-8-15", quantity: 2, pic: "spaghetti.jpg"),

    Foods(name: "Juice", period: "2017-8-12", quantity: 1, pic: "juice.jpg")
]

var foodSelect = Array(repeating: false, count: 21)

