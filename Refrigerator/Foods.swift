//
//  Foods.swift
//  Refrigerator
//
//  Created by Saffi on 28/07/2017.
//  Copyright © 2017 Saffi. All rights reserved.
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
