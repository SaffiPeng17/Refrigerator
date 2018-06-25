//
//  UIConfig.swift
//  Refrigerator
//
//  Created by Saffi on 2018/6/20.
//  Copyright © 2018 Saffi. All rights reserved.
//

import UIKit


let colorRGBA: ((CGFloat, CGFloat, CGFloat, CGFloat) -> UIColor) = { r,g,b,a in
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
extension UIColor {
    static let editYellow = colorRGBA(249, 218, 97, 1)
    static let editBlue = colorRGBA(0, 122, 255, 1)
}
