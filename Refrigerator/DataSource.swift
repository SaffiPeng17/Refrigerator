//
//  DataSource.swift
//  Refrigerator
//
//  Created by Saffi on 2018/6/14.
//  Copyright © 2018 Saffi. All rights reserved.
//

import Foundation

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

//    var foods = ["Onion", "Watermelon", "Banana", "Grapefruit", "Pumpkin",
//                 "Potato", "Carrot", "Cabbage", "Cucumber", "Pea",
//                 "Chicken", "Beef", "Cheese", "Butter", "Ham",
//                 "Sausage", "Milk", "Black Tea", "Curry", "Spaghetti", "Juice"]
//
//    var foodimgs = ["onion.jpg", "watermelon.jpg", "banana.jpg", "grapefruit.jpg", "pumpkin.jpg",
//                    "potato.jpg", "carrot.jpg", "cabbage.jpg", "cucumber.jpg", "pea.jpg",
//                    "chicken.jpg", "beef.jpg", "cheese.jpg", "butter.jpg", "ham.jpg",
//                    "sausage.jpg", "milk.jpg", "blacktea.jpg", "curry.jpg", "spaghetti.jpg", "juice.jpg"]
//
var foodSelect = Array(repeating: false, count: 21)
//
//    var quantity = ["3", "0.5", "6", "3", "1",
//                    "2", "2", "1", "4", "7",
//                    "0.75", "2", "3", "1", "6",
//                    "9", "1.5", "1", "3", "3", "10"]
//
//    var period = ["2017/8/30", "2017/10/2", "", "", "",
//                  "2017/7/23", "2017/8/30", "", "2017/8/2", "2017/10/2",
//                  "2017/7/30", "2017/7/24", "2017/12/19", "2018/2/20", "2017/10/30",
//                  "2017/10/17", "2017/7/28", "2017/7/10", "", "", "2017/9/2"]
