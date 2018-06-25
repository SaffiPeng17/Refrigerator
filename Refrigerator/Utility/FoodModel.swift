//
//  FoodModel.swift
//  Refrigerator
//
//  Created by Saffi on 2018/6/14.
//  Copyright © 2018 Saffi. All rights reserved.
//

import Foundation


//MARK: - Data Model
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

var classifiedArray = [String]()
var foodDict = [String: [Record]]()

func prepareData() {
    //Update ClassifiedArray
    var array = ClassifiedDefault.strArray
    let cusClassifieds = Coredata.shared.readClassified(fetchLimit: nil, predicate: nil, sortBy: nil)
    if cusClassifieds.count > 0 {
        for cusClassified in cusClassifieds {
            array.append(cusClassified.name!)
        }
    }
    classifiedArray = array
    //Update FoodDict
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
            if array.count != 0 {
                dict.updateValue(array, forKey: classified)
            }
        }
    }
    foodDict = dict
}

//MARK: - global Variable
var isReloadListTable = false


